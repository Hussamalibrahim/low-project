import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/utils/arabic_normalizer.dart';
import '../services/saf_storage_service.dart';

class ClientFolderWithDocuments {
  final String clientName;
  final String? clientId;
  final List<Document> documents;

  ClientFolderWithDocuments({
    required this.clientName,
    this.clientId,
    required this.documents,
  });
}

class FileManagerRepository {
  final AppDatabase _db;
  final SafStorageService _safService;

  FileManagerRepository(this._db, this._safService);

  /// مراقبة المستندات مصنفة ومجمعة حسب مجلدات الموكلين
  Stream<List<ClientFolderWithDocuments>> watchDocumentsGroupedByClient({
    String? searchQuery,
  }) {
    return _db.select(_db.documents).watch().asyncMap((docs) async {
      final validDocs = docs.where((d) => d.deletedAt == null).toList();
      final Map<String, ({String clientName, String? clientId, List<Document> docs})> grouped = {};

      for (final doc in validDocs) {
        if (searchQuery != null && searchQuery.trim().isNotEmpty) {
          if (!ArabicNormalizer.contains(doc.fileName, searchQuery)) {
            continue;
          }
        }

        // جلب القضية المرتبطة بالمستند
        final caseDoc = await (_db.select(_db.caseDocuments)
              ..where((tbl) => tbl.documentId.equals(doc.id)))
            .get();

        String clientName = 'مستندات عامة للمكتب';
        String? clientId;

        if (caseDoc.isNotEmpty) {
          final caseId = caseDoc.first.caseId;
          final clientLink = await (_db.select(_db.caseClients)
                ..where((tbl) => tbl.caseId.equals(caseId)))
              .get();
          if (clientLink.isNotEmpty) {
            final client = await (_db.select(_db.clients)
                  ..where((tbl) => tbl.id.equals(clientLink.first.clientId)))
                .getSingleOrNull();
            if (client != null) {
              clientName = client.fullName;
              clientId = client.id;
            }
          }
        }

        final key = clientId ?? 'GENERAL';
        if (!grouped.containsKey(key)) {
          grouped[key] = (clientName: clientName, clientId: clientId, docs: []);
        }
        grouped[key]!.docs.add(doc);
      }

      return grouped.values
          .map((g) => ClientFolderWithDocuments(
                clientName: g.clientName,
                clientId: g.clientId,
                documents: g.docs,
              ))
          .toList();
    });
  }

  // --- 1. المجلدات المرتبطة (Folder Links) ---

  Stream<List<FolderLink>> watchLinkedFolders() {
    return (_db.select(_db.folderLinks)
          ..where((tbl) => tbl.deletedAt.isNull())
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)]))
        .watch();
  }

  Future<String> linkFolder({
    required String uriOrPath,
    required String displayName,
    String? notes,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final folderId = const Uuid().v4();

    await _db.into(_db.folderLinks).insert(
          FolderLinksCompanion.insert(
            id: folderId,
            uriString: uriOrPath,
            displayName: displayName,
            pathHint: Value(uriOrPath),
            isAccessible: const Value(1),
            scanStatus: const Value('IDLE'),
            notes: Value(notes),
            createdAt: now,
          ),
        );

    // تسجيل التدقيق
    await _db.into(_db.auditLogs).insert(
          AuditLogsCompanion.insert(
            id: const Uuid().v4(),
            timestamp: now,
            action: 'CREATE',
            entityType: 'DOCUMENT',
            entityId: Value(folderId),
            details: 'ربط مجلد قضايا جديد: $displayName',
          ),
        );

    // بدء الفحص التكراري الأولي في الخلفية
    scanFolder(folderId);

    return folderId;
  }

  /// الفحص التكراري والتراكمي للمجلد (Incremental Scanner)
  Future<void> scanFolder(String folderId) async {
    final folder = await (_db.select(_db.folderLinks)
          ..where((tbl) => tbl.id.equals(folderId)))
        .getSingleOrNull();

    if (folder == null) return;

    final isFolderExists =
        await _safService.checkDirectoryExists(folder.uriString);
    if (!isFolderExists) {
      await (_db.update(_db.folderLinks)..where((tbl) => tbl.id.equals(folderId)))
          .write(const FolderLinksCompanion(
        isAccessible: Value(0),
        scanStatus: Value('ERROR'),
      ));
      return;
    }

    // تعيين الحالة إلى SCANNING
    await (_db.update(_db.folderLinks)..where((tbl) => tbl.id.equals(folderId)))
        .write(const FolderLinksCompanion(scanStatus: Value('SCANNING')));

    // جلب المستندات المسجلة حالياً لهذا المجلد
    final existingDocs = await (_db.select(_db.documents)
          ..where((tbl) =>
              tbl.folderLinkId.equals(folderId) & tbl.deletedAt.isNull()))
        .get();

    final Map<String, Document> existingByUri = {
      for (final doc in existingDocs) doc.uriString: doc,
    };

    final Set<String> discoveredUris = {};
    final now = DateTime.now().millisecondsSinceEpoch;

    try {
      await for (final file in _safService.scanDirectoryRecursively(folder.uriString)) {
        discoveredUris.add(file.path);

        if (existingByUri.containsKey(file.path)) {
          final existing = existingByUri[file.path]!;
          // التحقق مما إذا كان الملف قد عُدّل
          if (existing.lastModified != file.lastModified ||
              existing.fileSize != file.size) {
            await (_db.update(_db.documents)
                  ..where((tbl) => tbl.id.equals(existing.id)))
                .write(
              DocumentsCompanion(
                fileName: Value(file.name),
                fileSize: Value(file.size),
                lastModified: Value(file.lastModified),
                isAvailable: const Value(1),
                updatedAt: Value(now),
              ),
            );
          } else if (existing.isAvailable == 0) {
            // استعادة توفر الملف إذا كان معلماً كمفقود سابقاً
            await (_db.update(_db.documents)
                  ..where((tbl) => tbl.id.equals(existing.id)))
                .write(
              DocumentsCompanion(
                isAvailable: const Value(1),
                updatedAt: Value(now),
              ),
            );
          }
        } else {
          // ملف جديد مكتشف - إدراجه دون نسخه أو نقله
          final docId = const Uuid().v4();
          await _db.into(_db.documents).insert(
                DocumentsCompanion.insert(
                  id: docId,
                  folderLinkId: Value(folderId),
                  fileName: file.name,
                  uriString: file.path,
                  mimeType: file.mimeType,
                  extension: file.extension,
                  fileSize: file.size,
                  lastModified: file.lastModified,
                  category: _inferCategory(file.name),
                  isAvailable: const Value(1),
                  hasExtractedText: const Value(0),
                  createdAt: now,
                  updatedAt: now,
                ),
              );
        }
      }

      // كشف الملفات المفقودة (التي كانت مسجلة ولم يتم اكتشافها في الفحص)
      for (final entry in existingByUri.entries) {
        if (!discoveredUris.contains(entry.key)) {
          await (_db.update(_db.documents)
                ..where((tbl) => tbl.id.equals(entry.value.id)))
              .write(
            DocumentsCompanion(
              isAvailable: const Value(0),
              updatedAt: Value(now),
            ),
          );
        }
      }

      // تحديث حالة المجلد بعد نجاح الفحص
      await (_db.update(_db.folderLinks)..where((tbl) => tbl.id.equals(folderId)))
          .write(
        FolderLinksCompanion(
          isAccessible: const Value(1),
          scanStatus: const Value('IDLE'),
          lastScannedAt: Value(now),
        ),
      );
    } catch (_) {
      await (_db.update(_db.folderLinks)..where((tbl) => tbl.id.equals(folderId)))
          .write(const FolderLinksCompanion(scanStatus: Value('ERROR')));
    }
  }

  // --- 2. المستندات والبحث (Documents) ---

  Stream<List<Document>> watchAllDocuments({
    String? searchQuery,
    String? categoryFilter,
    String? extensionFilter,
  }) {
    final query = _db.select(_db.documents)
      ..where((tbl) => tbl.deletedAt.isNull())
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)]);

    if (categoryFilter != null && categoryFilter.isNotEmpty) {
      query.where((tbl) => tbl.category.equals(categoryFilter));
    }

    if (extensionFilter != null && extensionFilter.isNotEmpty) {
      query.where((tbl) => tbl.extension.equals(extensionFilter.toLowerCase()));
    }

    return query.watch().map((list) {
      if (searchQuery == null || searchQuery.trim().isEmpty) {
        return list;
      }
      return list.where((doc) {
        final matchesName =
            ArabicNormalizer.contains(doc.fileName, searchQuery);
        return matchesName;
      }).toList();
    });
  }

  Stream<List<Document>> watchFolderDocuments(String folderId) {
    return (_db.select(_db.documents)
          ..where((tbl) =>
              tbl.folderLinkId.equals(folderId) & tbl.deletedAt.isNull())
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.fileName)]))
        .watch();
  }

  Future<Document?> getDocumentById(String id) {
    return (_db.select(_db.documents)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  // --- 3. ربط المستند بالقضايا (Many-to-Many Relationships) ---

  Future<void> associateDocumentWithCases(
    String documentId,
    List<String> caseIds, {
    String? note,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    for (final caseId in caseIds) {
      // تجنب التكرار إذا كانت العلاقة موجودة
      final existing = await (_db.select(_db.caseDocuments)
            ..where((tbl) =>
                tbl.caseId.equals(caseId) & tbl.documentId.equals(documentId)))
          .getSingleOrNull();

      if (existing == null) {
        await _db.into(_db.caseDocuments).insert(
              CaseDocumentsCompanion.insert(
                id: const Uuid().v4(),
                caseId: caseId,
                documentId: documentId,
                relationNote: Value(note),
                createdAt: now,
              ),
            );
      }
    }
  }

  /// فك ارتباط المستند بقضية دون حذف المستند الأصلي ودون حذفه من القضايا الأخرى
  Future<void> removeDocumentCaseAssociation(
      String documentId, String caseId) async {
    await (_db.delete(_db.caseDocuments)
          ..where((tbl) =>
              tbl.caseId.equals(caseId) & tbl.documentId.equals(documentId)))
        .go();
  }

  Stream<List<Document>> watchCaseDocuments(String caseId) {
    final query = _db.select(_db.documents).join([
      innerJoin(
        _db.caseDocuments,
        _db.caseDocuments.documentId.equalsExp(_db.documents.id),
      ),
    ])
      ..where(_db.caseDocuments.caseId.equals(caseId) &
          _db.documents.deletedAt.isNull())
      ..orderBy([OrderingTerm.desc(_db.documents.createdAt)]);

    return query.watch().map((rows) {
      return rows.map((r) => r.readTable(_db.documents)).toList();
    });
  }

  Stream<List<Case>> watchDocumentCases(String documentId) {
    final query = _db.select(_db.cases).join([
      innerJoin(
        _db.caseDocuments,
        _db.caseDocuments.caseId.equalsExp(_db.cases.id),
      ),
    ])
      ..where(_db.caseDocuments.documentId.equals(documentId) &
          _db.cases.deletedAt.isNull());

    return query.watch().map((rows) {
      return rows.map((r) => r.readTable(_db.cases)).toList();
    });
  }

  /// حذف سجل المستند من قاعدة البيانات (حذف منطقي)
  /// لا يقوم بحذف الملف الفعلي من القرص إطلاقاً
  Future<void> deleteDocumentRecord(String id, String fileName) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await (_db.update(_db.documents)..where((tbl) => tbl.id.equals(id))).write(
      DocumentsCompanion(
        deletedAt: Value(now),
        updatedAt: Value(now),
      ),
    );

    await _db.into(_db.auditLogs).insert(
          AuditLogsCompanion.insert(
            id: const Uuid().v4(),
            timestamp: now,
            action: 'DELETE',
            entityType: 'DOCUMENT',
            entityId: Value(id),
            details: 'حذف سجل المستند (دون حذف الملف الأصلي): $fileName',
          ),
        );
  }

  // --- 4. فهرسة واستخراج النصوص للبحث الذكي المحلي ---

  Future<void> saveExtractedText({
    required String documentId,
    required String extractedText,
    String method = 'MANUAL',
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final normalized = ArabicNormalizer.normalize(extractedText);

    // حذف فهرس قديم إن وجد
    await (_db.delete(_db.documentTextIndex)
          ..where((tbl) => tbl.documentId.equals(documentId)))
        .go();

    await _db.into(_db.documentTextIndex).insert(
          DocumentTextIndexCompanion.insert(
            id: const Uuid().v4(),
            documentId: documentId,
            extractedText: extractedText,
            normalizedText: normalized,
            extractionMethod: method,
            indexedAt: now,
          ),
        );

    await (_db.update(_db.documents)..where((tbl) => tbl.id.equals(documentId)))
        .write(const DocumentsCompanion(hasExtractedText: Value(1)));
  }

  Future<List<Document>> searchDocumentFullText(String query) async {
    if (query.trim().isEmpty) return [];
    final normalizedQuery = ArabicNormalizer.normalize(query);

    final matches = await (_db.select(_db.documentTextIndex)
          ..where((tbl) => tbl.normalizedText.like('%$normalizedQuery%')))
        .get();

    final docIds = matches.map((m) => m.documentId).toList();
    if (docIds.isEmpty) return [];

    return (_db.select(_db.documents)
          ..where((tbl) => tbl.id.isIn(docIds) & tbl.deletedAt.isNull()))
        .get();
  }

  String _inferCategory(String fileName) {
    final lower = fileName.toLowerCase();
    if (lower.contains('وكالة') || lower.contains('توكيل') || lower.contains('poa')) {
      return 'POA';
    } else if (lower.contains('عقد') || lower.contains('اتفاق') || lower.contains('مشارطة')) {
      return 'CONTRACT';
    } else if (lower.contains('دعوى') || lower.contains('استدعاء') || lower.contains('ادعاء')) {
      return 'CLAIM_STATEMENT';
    } else if (lower.contains('مذكرة') || lower.contains('جوابية') || lower.contains('دفاع')) {
      return 'DEFENSE_MEMO';
    } else if (lower.contains('حكم') || lower.contains('قرار') || lower.contains('قرار_محكمة')) {
      return 'JUDGMENT';
    } else if (lower.contains('بينة') || lower.contains('سند') || lower.contains('إثبات')) {
      return 'EVIDENCE';
    } else if (lower.contains('هوية') || lower.contains('جواز') || lower.contains('قيد')) {
      return 'ID_DOCUMENT';
    } else if (lower.contains('إيصال') || lower.contains('سند_قبض') || lower.contains('فاتورة')) {
      return 'RECEIPT';
    }
    return 'OTHER';
  }
}
