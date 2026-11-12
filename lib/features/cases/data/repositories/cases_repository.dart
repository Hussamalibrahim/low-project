import 'dart:io';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/utils/arabic_normalizer.dart';

class CaseListItem {
  final Case caseItem;
  final String clientName;
  final String clientRole;
  final String? courtName;
  final String? opponentName;
  final int? nextHearingDate;
  final String? nextHearingType;

  const CaseListItem({
    required this.caseItem,
    required this.clientName,
    required this.clientRole,
    this.courtName,
    this.opponentName,
    this.nextHearingDate,
    this.nextHearingType,
  });
}

class CaseWithDetails {
  final Case caseItem;
  final Court? court;
  final List<Client> clients;
  final List<CaseParty> parties;
  final Map<String, String> clientRoles;

  const CaseWithDetails({
    required this.caseItem,
    this.court,
    required this.clients,
    required this.parties,
    this.clientRoles = const {},
  });
}

class CaseClientInput {
  final String? id;
  final String name;
  final String role; // 'PLAINTIFF' (مدعي) or 'DEFENDANT' (مدعى عليه)
  final String? phone;
  final String? phoneSecondary;
  final String? nationalId;
  final String? address;
  final String? mukhtar;
  final String? notes;

  const CaseClientInput({
    this.id,
    required this.name,
    this.role = 'PLAINTIFF',
    this.phone,
    this.phoneSecondary,
    this.nationalId,
    this.address,
    this.mukhtar,
    this.notes,
  });
}

class CaseOpponentInput {
  final String? id;
  final String name;
  final String role; // 'DEFENDANT' (مدعى عليه) or 'PLAINTIFF' (مدعي)
  final String? phone;
  final String? nationalId;
  final String? address;
  final String? mukhtar;
  final String? notes;

  const CaseOpponentInput({
    this.id,
    required this.name,
    this.role = 'DEFENDANT',
    this.phone,
    this.nationalId,
    this.address,
    this.mukhtar,
    this.notes,
  });
}

class CasesRepository {
  final AppDatabase _db;

  CasesRepository(this._db);

  Future<List<Case>> getAllCases() {
    return (_db.select(_db.cases)
          ..where((tbl) => tbl.deletedAt.isNull())
          ..orderBy([
            (tbl) => OrderingTerm.desc(tbl.caseYear),
            (tbl) => OrderingTerm.desc(tbl.createdAt),
          ]))
        .get();
  }

  Stream<List<Case>> watchAllCases({
    String? searchQuery,
    String? statusFilter,
    String? typeFilter,
    bool includeArchived = false,
  }) {
    final query = _db.select(_db.cases)
      ..where((tbl) => tbl.deletedAt.isNull());

    if (!includeArchived) {
      query.where((tbl) => tbl.status.equals('ARCHIVED').not());
    }

    if (statusFilter != null && statusFilter.isNotEmpty) {
      query.where((tbl) => tbl.status.equals(statusFilter));
    }

    if (typeFilter != null && typeFilter.isNotEmpty) {
      query.where((tbl) => tbl.caseType.equals(typeFilter));
    }

    query.orderBy([
      (tbl) => OrderingTerm.desc(tbl.caseYear),
      (tbl) => OrderingTerm.desc(tbl.createdAt),
    ]);

    return query.watch().map((list) {
      if (searchQuery == null || searchQuery.trim().isEmpty) {
        return list;
      }
      return list.where((c) {
        final matchesTitle =
            ArabicNormalizer.contains(c.title, searchQuery);
        final matchesNumber = c.caseNumber.contains(searchQuery);
        final matchesYear = c.caseYear.toString().contains(searchQuery);
        final matchesCircuit = c.circuit != null &&
            ArabicNormalizer.contains(c.circuit!, searchQuery);
        final matchesSubject = c.subject != null &&
            ArabicNormalizer.contains(c.subject!, searchQuery);

        return matchesTitle ||
            matchesNumber ||
            matchesYear ||
            matchesCircuit ||
            matchesSubject;
      }).toList();
    });
  }

  Stream<List<CaseListItem>> watchCaseListItems({
    String? searchQuery,
    String? statusFilter,
    String? typeFilter,
  }) {
    return watchAllCases(
      searchQuery: null,
      statusFilter: statusFilter,
      typeFilter: typeFilter,
    ).asyncMap((cases) async {
      final now = DateTime.now().millisecondsSinceEpoch;
      final List<CaseListItem> items = [];

      for (final c in cases) {
        // جلب الموكلين وصفاتهم (يدعم موكلين متعددين)
        final clientLinks = await (_db.select(_db.caseClients)
              ..where((tbl) => tbl.caseId.equals(c.id)))
            .get();

        String clientName = 'غير محدد';
        String clientRole = 'مدعي';
        if (clientLinks.isNotEmpty) {
          final clientIds = clientLinks.map((l) => l.clientId).toList();
          final clients = await (_db.select(_db.clients)
                ..where((tbl) => tbl.id.isIn(clientIds) & tbl.deletedAt.isNull()))
              .get();
          if (clients.isNotEmpty) {
            clientName = clients.map((cl) => cl.fullName).join('، ');
          }
          final hasPlaintiff = clientLinks.any((l) => l.role == 'PLAINTIFF');
          final hasDefendant = clientLinks.any((l) => l.role == 'DEFENDANT');
          if (hasPlaintiff && hasDefendant) {
            clientRole = 'مدعي / مدعى عليه';
          } else if (hasDefendant) {
            clientRole = 'مدعى عليه';
          } else {
            clientRole = 'مدعي';
          }
        }

        // جلب المحكمة
        String? courtName;
        if (c.courtId != null) {
          final court = await (_db.select(_db.courts)
                ..where((tbl) => tbl.id.equals(c.courtId!)))
              .getSingleOrNull();
          courtName = court?.name;
        }

        // جلب الخصوم (يدعم خصوماً متعددين بأمان)
        final parties = await (_db.select(_db.caseParties)
              ..where((tbl) => tbl.caseId.equals(c.id)))
            .get();
        final opponentName = parties.isNotEmpty
            ? parties.map((p) => p.name).join('، ')
            : null;

        // جلب موعد أقرب جلسة قادمة
        final nextHearing = await (_db.select(_db.hearings)
              ..where((tbl) =>
                  tbl.caseId.equals(c.id) &
                  tbl.deletedAt.isNull() &
                  tbl.hearingDate.isBiggerOrEqualValue(now))
              ..orderBy([(tbl) => OrderingTerm.asc(tbl.hearingDate)])
              ..limit(1))
            .getSingleOrNull();

        items.add(CaseListItem(
          caseItem: c,
          clientName: clientName,
          clientRole: clientRole,
          courtName: courtName,
          opponentName: opponentName,
          nextHearingDate: nextHearing?.hearingDate,
          nextHearingType: nextHearing?.hearingType,
        ));
      }

      if (searchQuery == null || searchQuery.trim().isEmpty) {
        return items;
      }

      return items.where((item) {
        final matchesClient =
            ArabicNormalizer.contains(item.clientName, searchQuery);
        final matchesType =
            ArabicNormalizer.contains(item.caseItem.caseType, searchQuery);
        final matchesOpponent = item.opponentName != null &&
            ArabicNormalizer.contains(item.opponentName!, searchQuery);
        final matchesCourt = item.courtName != null &&
            ArabicNormalizer.contains(item.courtName!, searchQuery);
        final matchesNumber = item.caseItem.caseNumber.contains(searchQuery);

        return matchesClient ||
            matchesType ||
            matchesOpponent ||
            matchesCourt ||
            matchesNumber;
      }).toList();
    });
  }

  Future<Case?> getCaseById(String id) {
    return (_db.select(_db.cases)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  Future<CaseWithDetails?> getCaseWithDetails(String caseId) async {
    final c = await getCaseById(caseId);
    if (c == null) return null;

    Court? court;
    if (c.courtId != null) {
      court = await (_db.select(_db.courts)
            ..where((tbl) => tbl.id.equals(c.courtId!)))
          .getSingleOrNull();
    }

    // الموكلون المرتبطون
    final clientRows = await (_db.select(_db.clients).join([
      innerJoin(
        _db.caseClients,
        _db.caseClients.clientId.equalsExp(_db.clients.id),
      ),
    ])
      ..where(_db.caseClients.caseId.equals(caseId) &
          _db.clients.deletedAt.isNull()))
        .get();

    final clients = clientRows.map((r) => r.readTable(_db.clients)).toList();
    final clientRoles = {
      for (final r in clientRows)
        r.readTable(_db.clients).id: r.readTable(_db.caseClients).role
    };

    // أطراف الدعوى والخصوم
    final parties = await (_db.select(_db.caseParties)
          ..where((tbl) => tbl.caseId.equals(caseId)))
        .get();

    return CaseWithDetails(
      caseItem: c,
      court: court,
      clients: clients,
      parties: parties,
      clientRoles: clientRoles,
    );
  }

  Future<String> createCase({
    required String caseNumber,
    required int caseYear,
    required String title,
    required String caseType,
    String? courtId,
    String? circuit,
    required String stage,
    int? registrationDate,
    String? subject,
    int? claimAmount,
    String currency = 'SYP',
    String status = 'OPEN',
    String? notes,
    required List<String> clientIds,
    List<Map<String, String>> parties = const [],
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final caseId = const Uuid().v4();

    await _db.transaction(() async {
      await _db.into(_db.cases).insert(
            CasesCompanion.insert(
              id: caseId,
              caseNumber: caseNumber.trim(),
              caseYear: caseYear,
              title: title.trim(),
              caseType: caseType,
              courtId: Value(courtId),
              circuit: Value(circuit?.trim()),
              stage: stage,
              registrationDate: Value(registrationDate),
              subject: Value(subject?.trim()),
              claimAmount: Value(claimAmount),
              currency: Value(currency),
              status: status,
              notes: Value(notes?.trim()),
              createdAt: now,
              updatedAt: now,
            ),
          );

      // ربط الموكلين بالقضية
      for (final cId in clientIds) {
        await _db.into(_db.caseClients).insert(
              CaseClientsCompanion.insert(
                id: const Uuid().v4(),
                caseId: caseId,
                clientId: cId,
                role: 'PLAINTIFF',
                createdAt: now,
              ),
            );
      }

      // إضافة أطراف الدعوى والخصوم
      for (final party in parties) {
        await _db.into(_db.caseParties).insert(
              CasePartiesCompanion.insert(
                id: const Uuid().v4(),
                caseId: caseId,
                name: party['name'] ?? '',
                role: party['role'] ?? 'OPPONENT',
                lawyerName: Value(party['lawyerName']),
                lawyerPhone: Value(party['lawyerPhone']),
                notes: Value(party['notes']),
                createdAt: now,
              ),
            );
      }

      // تسجيل في سجل التدقيق
      await _db.into(_db.auditLogs).insert(
            AuditLogsCompanion.insert(
              id: const Uuid().v4(),
              timestamp: now,
              action: 'CREATE',
              entityType: 'CASE',
              entityId: Value(caseId),
              details: 'قيد قضية جديدة رقم $caseNumber لعام $caseYear: $title',
            ),
          );
    });

    return caseId;
  }

  Future<void> updateCase({
    required String id,
    required String caseNumber,
    required int caseYear,
    required String title,
    required String caseType,
    String? courtId,
    String? circuit,
    required String stage,
    int? registrationDate,
    String? subject,
    int? claimAmount,
    String currency = 'SYP',
    required String status,
    String? outcome,
    int? closingDate,
    String? notes,
    List<String>? clientIds,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;

    await _db.transaction(() async {
      await (_db.update(_db.cases)..where((tbl) => tbl.id.equals(id))).write(
        CasesCompanion(
          caseNumber: Value(caseNumber.trim()),
          caseYear: Value(caseYear),
          title: Value(title.trim()),
          caseType: Value(caseType),
          courtId: Value(courtId),
          circuit: Value(circuit?.trim()),
          stage: Value(stage),
          registrationDate: Value(registrationDate),
          subject: Value(subject?.trim()),
          claimAmount: Value(claimAmount),
          currency: Value(currency),
          status: Value(status),
          outcome: Value(outcome?.trim()),
          closingDate: Value(closingDate),
          notes: Value(notes?.trim()),
          updatedAt: Value(now),
        ),
      );

      if (clientIds != null) {
        // تحديث موكلي القضية
        await (_db.delete(_db.caseClients)..where((tbl) => tbl.caseId.equals(id))).go();
        for (final cId in clientIds) {
          await _db.into(_db.caseClients).insert(
                CaseClientsCompanion.insert(
                  id: const Uuid().v4(),
                  caseId: id,
                  clientId: cId,
                  role: 'PLAINTIFF',
                  createdAt: now,
                ),
              );
        }
      }

      // تسجيل في سجل التدقيق
      await _db.into(_db.auditLogs).insert(
            AuditLogsCompanion.insert(
              id: const Uuid().v4(),
              timestamp: now,
              action: 'UPDATE',
              entityType: 'CASE',
              entityId: Value(id),
              details: 'تعديل بيانات القضية رقم $caseNumber: $title',
            ),
          );
    });
  }

  Future<void> updateCaseNotes(String caseId, String notes) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await (_db.update(_db.cases)..where((tbl) => tbl.id.equals(caseId))).write(
      CasesCompanion(
        notes: Value(notes.trim()),
        updatedAt: Value(now),
      ),
    );
  }

  Future<void> archiveCase(String id, String caseTitle) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await (_db.update(_db.cases)..where((tbl) => tbl.id.equals(id))).write(
      CasesCompanion(
        status: const Value('ARCHIVED'),
        updatedAt: Value(now),
      ),
    );

    await _db.into(_db.auditLogs).insert(
          AuditLogsCompanion.insert(
            id: const Uuid().v4(),
            timestamp: now,
            action: 'UPDATE',
            entityType: 'CASE',
            entityId: Value(id),
            details: 'أرشفة القضية: $caseTitle',
          ),
        );
  }

  Future<void> restoreCase(String id, String caseTitle) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await (_db.update(_db.cases)..where((tbl) => tbl.id.equals(id))).write(
      CasesCompanion(
        status: const Value('OPEN'),
        updatedAt: Value(now),
      ),
    );

    await _db.into(_db.auditLogs).insert(
          AuditLogsCompanion.insert(
            id: const Uuid().v4(),
            timestamp: now,
            action: 'RESTORE',
            entityType: 'CASE',
            entityId: Value(id),
            details: 'استرجاع القضية من الأرشيف: $caseTitle',
          ),
        );
  }

  Future<void> deleteCase(String id, String caseTitle) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await (_db.update(_db.cases)..where((tbl) => tbl.id.equals(id))).write(
      CasesCompanion(
        deletedAt: Value(now),
        updatedAt: Value(now),
      ),
    );

    await _db.into(_db.auditLogs).insert(
          AuditLogsCompanion.insert(
            id: const Uuid().v4(),
            timestamp: now,
            action: 'DELETE',
            entityType: 'CASE',
            entityId: Value(id),
            details: 'حذف القضية: $caseTitle',
          ),
        );
  }

  /// إضافة محكمة جديدة فورياً من شاشة الدعوى
  Future<Court> createCourt({
    required String name,
    required String address,
    String courtType = 'CIVIL',
    String governorate = 'دمشق',
    String city = 'دمشق',
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final courtId = const Uuid().v4();
    await _db.into(_db.courts).insert(
          CourtsCompanion.insert(
            id: courtId,
            name: name.trim(),
            courtType: courtType,
            governorate: governorate,
            city: city,
            address: Value(address.trim()),
            createdAt: now,
          ),
        );
    return await (_db.select(_db.courts)..where((tbl) => tbl.id.equals(courtId)))
        .getSingle();
  }

  /// إنشاء ملف قضية متكامل يرتكز على الموكلين والخصوم (يدعم موكلين وخصوماً متعددين)
  Future<String> createFullLegalCase({
    List<CaseClientInput> clients = const [],
    List<CaseOpponentInput> opponents = const [],
    String? clientName,
    String? clientPhone,
    String? clientPhoneSecondary,
    String? clientNationalId,
    String? clientAddress,
    String? clientMukhtar,
    String? clientOccupation,
    String? clientNotes,
    String clientRole = 'PLAINTIFF', // 'PLAINTIFF' (مدعي) أو 'DEFENDANT' (مدعى عليه)
    String? opponentName,
    String opponentRole = 'DEFENDANT',
    String? opponentLawyer,
    String? opponentPhone,
    String? opponentNationalId,
    String? opponentAddress,
    String? opponentMukhtar,
    String? opponentOccupation,
    List<Map<String, String>> additionalParties = const [],
    String? caseNumber,
    int? caseYear,
    String? title,
    String caseType = 'مدني',
    String? courtId,
    String? circuit,
    String stage = 'بداية',
    String? subject,
    String? notes,
    List<({int date, String action})> initialHearings = const [],
    List<({int date, String title})> initialTasks = const [],
    int? agreedAmount,
    int? paidAmount,
    String currency = 'SYP',
    List<String> attachedFilePaths = const [],
    List<({String path, String displayName})> attachedNamedFiles = const [],
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final caseId = const Uuid().v4();

    return await _db.transaction(() async {
      // 1. تجميع قائمة الموكلين النهائية
      final resolvedClients = <CaseClientInput>[];
      if (clients.isNotEmpty) {
        resolvedClients.addAll(clients.where((cl) => cl.name.trim().isNotEmpty));
      } else if (clientName != null && clientName.trim().isNotEmpty) {
        resolvedClients.add(CaseClientInput(
          name: clientName.trim(),
          role: clientRole,
          phone: clientPhone,
          phoneSecondary: clientPhoneSecondary,
          nationalId: clientNationalId,
          address: clientAddress,
          mukhtar: clientMukhtar,
          notes: clientNotes,
        ));
      }

      // 2. تجميع قائمة الخصوم النهائية
      final resolvedOpponents = <CaseOpponentInput>[];
      if (opponents.isNotEmpty) {
        resolvedOpponents.addAll(opponents.where((opp) => opp.name.trim().isNotEmpty));
      } else if (opponentName != null && opponentName.trim().isNotEmpty) {
        resolvedOpponents.add(CaseOpponentInput(
          name: opponentName.trim(),
          role: opponentRole,
          phone: opponentPhone,
          nationalId: opponentNationalId,
          address: opponentAddress,
          mukhtar: opponentMukhtar,
        ));
      }

      // 3. إنشاء القضية
      final finalCaseNumber =
          caseNumber?.trim().isNotEmpty == true ? caseNumber!.trim() : '-';
      final finalCaseYear = caseYear ?? DateTime.now().year;
      final primaryClientName = resolvedClients.isNotEmpty
          ? resolvedClients.first.name.trim()
          : (clientName?.trim() ?? 'دعوى');
      final finalTitle = title?.trim().isNotEmpty == true
          ? title!.trim()
          : (resolvedClients.length > 1
              ? '$primaryClientName وشركاه - $caseType'
              : '$primaryClientName - $caseType');

      await _db.into(_db.cases).insert(
            CasesCompanion.insert(
              id: caseId,
              caseNumber: finalCaseNumber,
              caseYear: finalCaseYear,
              title: finalTitle,
              caseType: caseType,
              courtId: Value(courtId),
              circuit: Value(circuit?.trim()),
              stage: stage,
              subject: Value(subject?.trim()),
              notes: Value(notes?.trim()),
              currency: Value(currency),
              status: 'OPEN',
              createdAt: now,
              updatedAt: now,
            ),
          );

      // 4. معالجة وحفظ كافة الموكلين وربطهم بالقضية بصفاتهم الفردية
      String? firstClientId;
      for (final cl in resolvedClients) {
        final trimmedName = cl.name.trim();
        final resolvedAddr = [
          if (cl.address?.trim().isNotEmpty == true) cl.address!.trim(),
          if (cl.mukhtar?.trim().isNotEmpty == true) 'المختار: ${cl.mukhtar!.trim()}',
        ].join(' • ');

        Client? existingClient;
        if (cl.id != null && cl.id!.isNotEmpty) {
          existingClient = await (_db.select(_db.clients)
                ..where((tbl) => tbl.id.equals(cl.id!) & tbl.deletedAt.isNull()))
              .getSingleOrNull();
        }
        if (existingClient == null) {
          existingClient = await (_db.select(_db.clients)
                ..where((tbl) =>
                    tbl.fullName.equals(trimmedName) & tbl.deletedAt.isNull()))
              .getSingleOrNull();
        }

        String cId;
        if (existingClient != null) {
          cId = existingClient.id;
          if (cl.phone != null || resolvedAddr.isNotEmpty || cl.phoneSecondary != null || cl.nationalId != null) {
            await (_db.update(_db.clients)..where((tbl) => tbl.id.equals(cId))).write(
              ClientsCompanion(
                phone: cl.phone != null && cl.phone!.trim().isNotEmpty
                    ? Value(cl.phone!.trim())
                    : const Value.absent(),
                phoneSecondary: cl.phoneSecondary != null && cl.phoneSecondary!.trim().isNotEmpty
                    ? Value(cl.phoneSecondary!.trim())
                    : const Value.absent(),
                address: resolvedAddr.isNotEmpty
                    ? Value(resolvedAddr)
                    : const Value.absent(),
                nationalId: cl.nationalId != null && cl.nationalId!.trim().isNotEmpty
                    ? Value(cl.nationalId!.trim())
                    : const Value.absent(),
                updatedAt: Value(now),
              ),
            );
          }
        } else {
          cId = const Uuid().v4();
          await _db.into(_db.clients).insert(
                ClientsCompanion.insert(
                  id: cId,
                  clientType: 'INDIVIDUAL',
                  fullName: trimmedName,
                  phone: cl.phone?.trim() ?? '',
                  phoneSecondary: Value(cl.phoneSecondary?.trim()),
                  nationalId: Value(cl.nationalId?.trim()),
                  address: Value(resolvedAddr.isNotEmpty ? resolvedAddr : null),
                  notes: Value(cl.notes?.trim()),
                  createdAt: now,
                  updatedAt: now,
                ),
              );
        }
        firstClientId ??= cId;

        await _db.into(_db.caseClients).insert(
              CaseClientsCompanion.insert(
                id: const Uuid().v4(),
                caseId: caseId,
                clientId: cId,
                role: cl.role,
                createdAt: now,
              ),
            );
      }

      // 5. معالجة وحفظ كافة الخصوم بصفاتهم الفردية
      for (final opp in resolvedOpponents) {
        final oppNotes = [
          if (opp.nationalId?.trim().isNotEmpty == true) 'الرقم الوطني: ${opp.nationalId!.trim()}',
          if (opp.address?.trim().isNotEmpty == true) 'العنوان: ${opp.address!.trim()}',
          if (opp.mukhtar?.trim().isNotEmpty == true) 'المختار: ${opp.mukhtar!.trim()}',
        ].join(' • ');

        await _db.into(_db.caseParties).insert(
              CasePartiesCompanion.insert(
                id: const Uuid().v4(),
                caseId: caseId,
                name: opp.name.trim(),
                role: opp.role,
                lawyerPhone: Value(opp.phone?.trim()),
                notes: Value(oppNotes.isNotEmpty ? oppNotes : null),
                createdAt: now,
              ),
            );
      }

      // 6. إضافة الأطراف الأخرى المحددة إن وجدت
      for (final party in additionalParties) {
        final pName = party['name']?.trim() ?? '';
        final pRole = party['role']?.trim() ?? 'طرف آخر';
        if (pName.isNotEmpty) {
          await _db.into(_db.caseParties).insert(
                CasePartiesCompanion.insert(
                  id: const Uuid().v4(),
                  caseId: caseId,
                  name: pName,
                  role: pRole,
                  createdAt: now,
                ),
              );
        }
      }

      // 7. إضافة الجلسات القضائية (في الماضي أو الحاضر)
      for (final h in initialHearings) {
        await _db.into(_db.hearings).insert(
              HearingsCompanion.insert(
                id: const Uuid().v4(),
                caseId: caseId,
                hearingDate: h.date,
                hearingType: h.action.trim().isNotEmpty ? h.action.trim() : 'جلسة محاكمة',
                status: const Value('SCHEDULED'),
                createdAt: now,
              ),
            );
      }

      // 8. إضافة الأعمال والإجراءات القضائية الأخرى (تضاف كمهام وإجراءات)
      for (final t in initialTasks) {
        if (t.title.trim().isNotEmpty) {
          await _db.into(_db.tasks).insert(
                TasksCompanion.insert(
                  id: const Uuid().v4(),
                  caseId: Value(caseId),
                  clientId: Value(firstClientId),
                  title: t.title.trim(),
                  priority: 'MEDIUM',
                  dueDate: t.date,
                  status: const Value('PENDING'),
                  createdAt: now,
                ),
              );

          await _db.into(_db.caseProcedures).insert(
                CaseProceduresCompanion.insert(
                  id: const Uuid().v4(),
                  caseId: caseId,
                  procedureDate: t.date,
                  procedureType: 'عمل قضائي',
                  title: t.title.trim(),
                  createdAt: now,
                ),
              );
        }
      }

      // 9. المبالغ والاتفاقيات المالية
      if (agreedAmount != null && agreedAmount > 0 && firstClientId != null) {
        final agreementId = const Uuid().v4();
        await _db.into(_db.feeAgreements).insert(
              FeeAgreementsCompanion.insert(
                id: agreementId,
                caseId: Value(caseId),
                clientId: firstClientId,
                agreedAmount: agreedAmount,
                currency: Value(currency),
                agreementType: 'LUMP_SUM',
                agreementDate: now,
                createdAt: now,
              ),
            );

        if (paidAmount != null && paidAmount > 0) {
          await _db.into(_db.payments).insert(
                PaymentsCompanion.insert(
                  id: const Uuid().v4(),
                  feeAgreementId: Value(agreementId),
                  clientId: firstClientId,
                  caseId: Value(caseId),
                  amount: paidAmount,
                  currency: Value(currency),
                  paymentDate: now,
                  paymentMethod: 'CASH',
                  notes: const Value('دفعة أولى عند قيد الدعوى'),
                  createdAt: now,
                ),
              );
        }
      }

      // 9. حفظ الملفات المرفقة مع أسمائها المخصصة
      final allFilesToAttach = <({String path, String displayName})>[
        ...attachedNamedFiles,
        ...attachedFilePaths.map((pStr) => (path: pStr, displayName: p.basename(pStr))),
      ];

      for (final item in allFilesToAttach) {
        final file = File(item.path);
        final docId = const Uuid().v4();
        final ext = p.extension(item.path).replaceAll('.', '');
        final fileSize = file.existsSync() ? file.lengthSync() : 0;
        await _db.into(_db.documents).insert(
              DocumentsCompanion.insert(
                id: docId,
                fileName: item.displayName.trim().isNotEmpty
                    ? item.displayName.trim()
                    : p.basename(item.path),
                uriString: item.path,
                mimeType: 'application/octet-stream',
                extension: ext.isNotEmpty ? ext : 'bin',
                fileSize: fileSize,
                lastModified: now,
                category: 'EVIDENCE',
                createdAt: now,
                updatedAt: now,
              ),
            );
        await _db.into(_db.caseDocuments).insert(
              CaseDocumentsCompanion.insert(
                id: const Uuid().v4(),
                caseId: caseId,
                documentId: docId,
                createdAt: now,
              ),
            );
      }

      // 10. تسجيل العملية في سجل التدقيق
      await _db.into(_db.auditLogs).insert(
            AuditLogsCompanion.insert(
              id: const Uuid().v4(),
              timestamp: now,
              action: 'CREATE',
              entityType: 'CASE',
              entityId: Value(caseId),
              details: 'قيد قضية متكاملة: $finalTitle',
            ),
          );

      return caseId;
    });
  }

  /// تعديل ملف قضية متكامل مع تحديث كافة الموكلين والخصوم
  Future<void> updateFullLegalCase({
    required String caseId,
    required List<CaseClientInput> clients,
    required List<CaseOpponentInput> opponents,
    required String caseNumber,
    required int caseYear,
    required String caseType,
    String? courtId,
    String? notes,
    int? agreedAmount,
    int? paidAmount,
    String currency = 'SYP',
    List<({String? id, int date, String action, String? status})> hearings = const [],
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;

    await _db.transaction(() async {
      final validClients = clients.where((cl) => cl.name.trim().isNotEmpty).toList();
      final validOpponents = opponents.where((opp) => opp.name.trim().isNotEmpty).toList();

      final primaryClientName = validClients.isNotEmpty
          ? validClients.first.name.trim()
          : 'دعوى';
      final finalTitle = validClients.length > 1
          ? '$primaryClientName وشركاه - $caseType'
          : '$primaryClientName - $caseType';

      // 1. تحديث بيانات القضية
      await (_db.update(_db.cases)..where((tbl) => tbl.id.equals(caseId))).write(
        CasesCompanion(
          caseNumber: Value(caseNumber.trim().isNotEmpty ? caseNumber.trim() : '-'),
          caseYear: Value(caseYear),
          title: Value(finalTitle),
          caseType: Value(caseType),
          courtId: Value(courtId),
          notes: Value(notes?.trim()),
          currency: Value(currency),
          updatedAt: Value(now),
        ),
      );

      // 2. تحديث الموكلين
      await (_db.delete(_db.caseClients)..where((tbl) => tbl.caseId.equals(caseId))).go();
      String? firstClientId;
      for (final cl in validClients) {
        final trimmedName = cl.name.trim();
        final resolvedAddr = [
          if (cl.address?.trim().isNotEmpty == true) cl.address!.trim(),
          if (cl.mukhtar?.trim().isNotEmpty == true) 'المختار: ${cl.mukhtar!.trim()}',
        ].join(' • ');

        Client? existingClient;
        if (cl.id != null && cl.id!.isNotEmpty) {
          existingClient = await (_db.select(_db.clients)
                ..where((tbl) => tbl.id.equals(cl.id!) & tbl.deletedAt.isNull()))
              .getSingleOrNull();
        }
        if (existingClient == null) {
          existingClient = await (_db.select(_db.clients)
                ..where((tbl) =>
                    tbl.fullName.equals(trimmedName) & tbl.deletedAt.isNull()))
              .getSingleOrNull();
        }

        String cId;
        if (existingClient != null) {
          cId = existingClient.id;
          await (_db.update(_db.clients)..where((tbl) => tbl.id.equals(cId))).write(
            ClientsCompanion(
              phone: cl.phone != null && cl.phone!.trim().isNotEmpty
                  ? Value(cl.phone!.trim())
                  : const Value.absent(),
              phoneSecondary: cl.phoneSecondary != null && cl.phoneSecondary!.trim().isNotEmpty
                  ? Value(cl.phoneSecondary!.trim())
                  : const Value.absent(),
              address: resolvedAddr.isNotEmpty
                  ? Value(resolvedAddr)
                  : const Value.absent(),
              nationalId: cl.nationalId != null && cl.nationalId!.trim().isNotEmpty
                  ? Value(cl.nationalId!.trim())
                  : const Value.absent(),
              updatedAt: Value(now),
            ),
          );
        } else {
          cId = const Uuid().v4();
          await _db.into(_db.clients).insert(
                ClientsCompanion.insert(
                  id: cId,
                  clientType: 'INDIVIDUAL',
                  fullName: trimmedName,
                  phone: cl.phone?.trim() ?? '',
                  phoneSecondary: Value(cl.phoneSecondary?.trim()),
                  nationalId: Value(cl.nationalId?.trim()),
                  address: Value(resolvedAddr.isNotEmpty ? resolvedAddr : null),
                  notes: Value(cl.notes?.trim()),
                  createdAt: now,
                  updatedAt: now,
                ),
              );
        }
        firstClientId ??= cId;

        await _db.into(_db.caseClients).insert(
              CaseClientsCompanion.insert(
                id: const Uuid().v4(),
                caseId: caseId,
                clientId: cId,
                role: cl.role,
                createdAt: now,
              ),
            );
      }

      // 3. تحديث الخصوم
      await (_db.delete(_db.caseParties)..where((tbl) => tbl.caseId.equals(caseId))).go();
      for (final opp in validOpponents) {
        final oppNotes = [
          if (opp.nationalId?.trim().isNotEmpty == true) 'الرقم الوطني: ${opp.nationalId!.trim()}',
          if (opp.address?.trim().isNotEmpty == true) 'العنوان: ${opp.address!.trim()}',
          if (opp.mukhtar?.trim().isNotEmpty == true) 'المختار: ${opp.mukhtar!.trim()}',
        ].join(' • ');

        await _db.into(_db.caseParties).insert(
              CasePartiesCompanion.insert(
                id: const Uuid().v4(),
                caseId: caseId,
                name: opp.name.trim(),
                role: opp.role,
                lawyerPhone: Value(opp.phone?.trim()),
                notes: Value(oppNotes.isNotEmpty ? oppNotes : null),
                createdAt: now,
              ),
            );
      }

      // 4. تحديث الأتعاب إن وجدت
      if (firstClientId != null && agreedAmount != null && agreedAmount > 0) {
        final existingAgreement = await (_db.select(_db.feeAgreements)
              ..where((tbl) => tbl.caseId.equals(caseId)))
            .getSingleOrNull();

        if (existingAgreement != null) {
          await (_db.update(_db.feeAgreements)
                ..where((tbl) => tbl.id.equals(existingAgreement.id)))
              .write(
            FeeAgreementsCompanion(
              agreedAmount: Value(agreedAmount),
              currency: Value(currency),
            ),
          );
        } else {
          final agreementId = const Uuid().v4();
          await _db.into(_db.feeAgreements).insert(
                FeeAgreementsCompanion.insert(
                  id: agreementId,
                  caseId: Value(caseId),
                  clientId: firstClientId,
                  agreedAmount: agreedAmount,
                  currency: Value(currency),
                  agreementType: 'LUMP_SUM',
                  agreementDate: now,
                  createdAt: now,
                ),
              );
        }
      }

      // 5. مزامنة الجلسات عند التعديل
      if (hearings.isNotEmpty) {
        final existingDbHearings = await (_db.select(_db.hearings)
              ..where((tbl) => tbl.caseId.equals(caseId) & tbl.deletedAt.isNull()))
            .get();
        final keptIds = hearings.map((h) => h.id).whereType<String>().toSet();

        for (final dbH in existingDbHearings) {
          if (!keptIds.contains(dbH.id)) {
            await (_db.update(_db.hearings)..where((tbl) => tbl.id.equals(dbH.id))).write(
              HearingsCompanion(deletedAt: Value(now)),
            );
          }
        }

        for (final h in hearings) {
          if (h.id == null) {
            await _db.into(_db.hearings).insert(
                  HearingsCompanion.insert(
                    id: const Uuid().v4(),
                    caseId: caseId,
                    courtId: Value(courtId),
                    hearingDate: h.date,
                    hearingType: h.action.trim(),
                    status: Value(h.status ?? 'SCHEDULED'),
                    createdAt: now,
                  ),
                );
          }
        }
      }

      // تسجيل التدقيق
      await _db.into(_db.auditLogs).insert(
            AuditLogsCompanion.insert(
              id: const Uuid().v4(),
              timestamp: now,
              action: 'UPDATE',
              entityType: 'CASE',
              entityId: Value(caseId),
              details: 'تعديل بيانات القضية رقم $caseNumber: $finalTitle',
            ),
          );
    });
  }

  /// فصل القضية وتثبيت قرار الحكم (حقول اختيارية تماماً وفق الممارسة الفعلية السورية)
  Future<void> resolveCase({
    required String caseId,
    int? resolutionDate,
    String? decisionNumber,
    String? notes,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final effectiveDate = resolutionDate ?? now;
    final outcomeParts = <String>[];
    if (decisionNumber != null && decisionNumber.trim().isNotEmpty) {
      outcomeParts.add('قرار رقم: ${decisionNumber.trim()}');
    }
    if (notes != null && notes.trim().isNotEmpty) {
      outcomeParts.add(notes.trim());
    }
    final outcomeText = outcomeParts.isNotEmpty
        ? outcomeParts.join('\n')
        : 'فُصلت القضية';

    await (_db.update(_db.cases)..where((tbl) => tbl.id.equals(caseId))).write(
      CasesCompanion(
        status: const Value('CLOSED'),
        closingDate: Value(effectiveDate),
        outcome: Value(outcomeText),
        updatedAt: Value(now),
      ),
    );
  }

  /// استئناف / طعن القضية والانتقال إلى مرحلة جديدة (مع أرشفة المرحلة السابقة)
  Future<void> transitionToNewStage({
    required String caseId,
    required String newStage,
    required String newCaseNumber,
    required int newCaseYear,
    String? newCourtId,
    String? grounds,
    int? firstHearingDate,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final currentCase = await getCaseById(caseId);
    if (currentCase == null) return;

    await _db.transaction(() async {
      // 1. أرشفة المرحلة السابقة في سجل الإجراءات والمراحل المفصولة
      final stageTitle = 'مرحلة ${currentCase.stage} (أساس ${currentCase.caseNumber} لعام ${currentCase.caseYear})';
      final stageDesc = [
        if (currentCase.outcome != null && currentCase.outcome!.isNotEmpty)
          'القرار السابق:\n${currentCase.outcome}',
        if (grounds != null && grounds.trim().isNotEmpty)
          'أسباب الاستئناف / الطعن:\n${grounds.trim()}',
      ].join('\n\n');

      await _db.into(_db.caseProcedures).insert(
            CaseProceduresCompanion.insert(
              id: const Uuid().v4(),
              caseId: caseId,
              procedureDate: currentCase.closingDate ?? now,
              procedureType: 'CONCLUDED_STAGE',
              title: stageTitle,
              description: Value(stageDesc.isNotEmpty ? stageDesc : null),
              result: const Value('مفصولة'),
              createdAt: now,
            ),
          );

      // 2. تحديث القضية للمرحلة الجديدة
      final updatedNotes = [
        if (grounds != null && grounds.trim().isNotEmpty)
          'ملاحظات الاستئناف: ${grounds.trim()}',
        if (currentCase.notes != null && currentCase.notes!.isNotEmpty)
          currentCase.notes!,
      ].join('\n');

      await (_db.update(_db.cases)..where((tbl) => tbl.id.equals(caseId))).write(
        CasesCompanion(
          stage: Value(newStage),
          caseNumber: Value(newCaseNumber.trim().isNotEmpty ? newCaseNumber.trim() : '-'),
          caseYear: Value(newCaseYear),
          courtId: Value(newCourtId ?? currentCase.courtId),
          status: const Value('OPEN'),
          outcome: const Value(null),
          closingDate: const Value(null),
          notes: Value(updatedNotes.isNotEmpty ? updatedNotes : null),
          updatedAt: Value(now),
        ),
      );

      // 3. إضافة أول جلسة للمرحلة الجديدة إن تم تحديد موعد
      if (firstHearingDate != null) {
        await _db.into(_db.hearings).insert(
              HearingsCompanion.insert(
                id: const Uuid().v4(),
                caseId: caseId,
                courtId: Value(newCourtId ?? currentCase.courtId),
                hearingDate: firstHearingDate,
                hearingType: 'أول جلسة في مرحلة $newStage',
                status: const Value('SCHEDULED'),
                lawyerNotes: Value(grounds?.trim()),
                createdAt: now,
              ),
            );
      }
    });
  }

  /// متابعة التبليغات القضائية للدعوى
  Stream<List<CaseProcedure>> watchCaseNotifications(String caseId) {
    return (_db.select(_db.caseProcedures)
          ..where((tbl) =>
              tbl.caseId.equals(caseId) &
              tbl.procedureType.equals('NOTIFICATION') &
              tbl.deletedAt.isNull())
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.procedureDate)]))
        .watch();
  }

  /// متابعة المراحل القضائية السابقة المفصولة للدعوى
  Stream<List<CaseProcedure>> watchConcludedStages(String caseId) {
    return (_db.select(_db.caseProcedures)
          ..where((tbl) =>
              tbl.caseId.equals(caseId) &
              tbl.procedureType.equals('CONCLUDED_STAGE') &
              tbl.deletedAt.isNull())
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.procedureDate)]))
        .watch();
  }

  /// تسجيل تبليغ قضائي جديد
  Future<String> addCaseNotification({
    required String caseId,
    required String recipient,
    required String notificationType,
    required int date,
    required String status,
    String? notes,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final id = const Uuid().v4();
    await _db.into(_db.caseProcedures).insert(
          CaseProceduresCompanion.insert(
            id: id,
            caseId: caseId,
            procedureDate: date,
            title: '$notificationType: $recipient',
            procedureType: 'NOTIFICATION',
            description: Value(notes?.trim()),
            result: Value(status),
            createdAt: now,
          ),
        );
    return id;
  }

  /// تحديث حالة التبليغ القضائي (مثال: تم التبليغ بالذات / إعادة تبليغ)
  Future<void> updateCaseNotificationStatus({
    required String notificationId,
    required String status,
    String? notes,
  }) async {
    await (_db.update(_db.caseProcedures)
          ..where((tbl) => tbl.id.equals(notificationId)))
        .write(
      CaseProceduresCompanion(
        result: Value(status),
        description: notes != null && notes.trim().isNotEmpty
            ? Value(notes.trim())
            : const Value.absent(),
      ),
    );
  }

  /// حذف تبليغ قضائي
  Future<void> deleteCaseNotification(String notificationId) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await (_db.update(_db.caseProcedures)
          ..where((tbl) => tbl.id.equals(notificationId)))
        .write(
      CaseProceduresCompanion(
        deletedAt: Value(now),
      ),
    );
  }

  /// جلب كافة جلسات الدعوى (الحالية والسابقة والمؤجلة) لتعديلها وعرضها
  Future<List<Hearing>> getCaseHearings(String caseId) async {
    return (_db.select(_db.hearings)
          ..where((tbl) => tbl.caseId.equals(caseId) & tbl.deletedAt.isNull())
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.hearingDate)]))
        .get();
  }

  /// إعادة فتح القضية واستئناف النظر بها
  Future<void> reopenCase(String caseId) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await (_db.update(_db.cases)..where((tbl) => tbl.id.equals(caseId))).write(
      CasesCompanion(
        status: const Value('OPEN'),
        closingDate: const Value(null),
        updatedAt: Value(now),
      ),
    );
  }

  /// تعديل اسم المستند
  Future<void> updateDocumentTitle(String documentId, String newTitle) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await (_db.update(_db.documents)..where((tbl) => tbl.id.equals(documentId))).write(
      DocumentsCompanion(
        fileName: Value(newTitle.trim()),
        updatedAt: Value(now),
      ),
    );
  }

  /// رفع وإرفاق مستند جديد بقضية مباشرة
  Future<String> attachDocumentToCase({
    required String caseId,
    required String filePath,
    required String displayName,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final file = File(filePath);
    final docId = const Uuid().v4();
    final ext = p.extension(filePath).replaceAll('.', '');
    final fileSize = file.existsSync() ? file.lengthSync() : 0;

    await _db.into(_db.documents).insert(
          DocumentsCompanion.insert(
            id: docId,
            fileName: displayName.trim().isNotEmpty
                ? displayName.trim()
                : p.basename(filePath),
            uriString: filePath,
            mimeType: 'application/octet-stream',
            extension: ext.isNotEmpty ? ext : 'bin',
            fileSize: fileSize,
            lastModified: now,
            category: 'EVIDENCE',
            createdAt: now,
            updatedAt: now,
          ),
        );

    await _db.into(_db.caseDocuments).insert(
          CaseDocumentsCompanion.insert(
            id: const Uuid().v4(),
            caseId: caseId,
            documentId: docId,
            createdAt: now,
          ),
        );

    return docId;
  }

  Future<void> addCaseParty({
    required String caseId,
    required String name,
    required String role,
    String? phone,
    String? notes,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await _db.into(_db.caseParties).insert(
          CasePartiesCompanion.insert(
            id: const Uuid().v4(),
            caseId: caseId,
            name: name,
            role: role,
            lawyerPhone: Value(phone),
            notes: Value(notes),
            createdAt: now,
          ),
        );
  }

  Future<void> updateCaseParty({
    required String partyId,
    required String name,
    required String role,
    String? phone,
    String? notes,
  }) async {
    await (_db.update(_db.caseParties)..where((tbl) => tbl.id.equals(partyId)))
        .write(
      CasePartiesCompanion(
        name: Value(name),
        role: Value(role),
        lawyerPhone: Value(phone),
        notes: Value(notes),
      ),
    );
  }

  Future<void> deleteCaseParty(String partyId) async {
    await (_db.delete(_db.caseParties)..where((tbl) => tbl.id.equals(partyId)))
        .go();
  }
}

