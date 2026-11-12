import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:cryptography/cryptography.dart' as crypt;
import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../database/app_database.dart';

class BackupManifest {
  final String version;
  final String appName;
  final int createdAt;
  final int documentsCount;
  final int totalFiles;
  final bool isEncrypted;

  BackupManifest({
    required this.version,
    required this.appName,
    required this.createdAt,
    required this.documentsCount,
    required this.totalFiles,
    required this.isEncrypted,
  });

  Map<String, dynamic> toJson() => {
        'version': version,
        'appName': appName,
        'createdAt': createdAt,
        'documentsCount': documentsCount,
        'totalFiles': totalFiles,
        'isEncrypted': isEncrypted,
      };

  factory BackupManifest.fromJson(Map<String, dynamic> json) => BackupManifest(
        version: json['version'] as String? ?? '1.0.0',
        appName: json['appName'] as String? ?? 'نظام إدارة مكتب المحاماة',
        createdAt: json['createdAt'] as int? ?? 0,
        documentsCount: json['documentsCount'] as int? ?? 0,
        totalFiles: json['totalFiles'] as int? ?? 0,
        isEncrypted: json['isEncrypted'] as bool? ?? false,
      );
}

class BackupResult {
  final String backupPath;
  final int fileSize;
  final String sha256Checksum;
  final int documentsCount;

  BackupResult({
    required this.backupPath,
    required this.fileSize,
    required this.sha256Checksum,
    required this.documentsCount,
  });
}

class BackupEngine {
  final AppDatabase _db;

  BackupEngine(this._db);

  /// إنشاء نسخة احتياطية محلية كاملة ومضغوطة ومشفرة
  Future<BackupResult> createFullEncryptedBackup({
    required String password,
    String backupType = 'MANUAL',
  }) async {
    final now = DateTime.now();
    final timestamp = now.millisecondsSinceEpoch;
    final dateStr =
        '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}_${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}';

    final tempDir = await getTemporaryDirectory();
    final backupWorkspace = Directory(p.join(tempDir.path, 'backup_temp_$timestamp'));
    await backupWorkspace.create(recursive: true);

    try {
      // 1. أخذ لقطة متسقة من قاعدة البيانات SQLite
      final dbFolder = await getApplicationDocumentsDirectory();
      final dbFile = File(p.join(dbFolder.path, 'law_office.sqlite'));
      final dbSnapshotDir = Directory(p.join(backupWorkspace.path, 'database'));
      await dbSnapshotDir.create();
      final targetDbFile = File(p.join(dbSnapshotDir.path, 'law_office.sqlite'));

      if (await dbFile.exists()) {
        await dbFile.copy(targetDbFile.path);
      }

      // 2. تجميع المستندات المرتبطة الأصلية ومنع التكرار (Deduplication)
      final allDocs = await (_db.select(_db.documents)
            ..where((tbl) => tbl.deletedAt.isNull()))
          .get();

      final docsDir = Directory(p.join(backupWorkspace.path, 'documents'));
      await docsDir.create();

      final Map<String, String> checksums = {};
      int copiedDocs = 0;

      for (final doc in allDocs) {
        final originalFile = File(doc.uriString);
        if (await originalFile.exists()) {
          // استخدام معرف المستند UUID كاسم ملف داخل الأرشيف لتجنب تعارض الأسماء
          final ext = p.extension(doc.uriString);
          final archiveDocName = '${doc.id}$ext';
          final destFile = File(p.join(docsDir.path, archiveDocName));
          await originalFile.copy(destFile.path);

          // حساب الـ Checksum للمستند
          final bytes = await destFile.readAsBytes();
          checksums['documents/$archiveDocName'] =
              crypto.sha256.convert(bytes).toString();
          copiedDocs++;
        }
      }

      // 3. تصدير إعدادات التطبيق العامة (بدون الأسرار ومفاتيح الـ API)
      final prefs = await SharedPreferences.getInstance();
      final settingsDir = Directory(p.join(backupWorkspace.path, 'settings'));
      await settingsDir.create();

      final safeSettings = {
        'theme_mode': prefs.getInt('pref_theme_mode'),
        'color_theme': prefs.getInt('pref_color_theme'),
        'font_size': prefs.getInt('pref_font_size'),
        'security_mode': prefs.getInt('pref_security_mode'),
        'auto_lock_minutes': prefs.getInt('pref_auto_lock_minutes'),
      };

      final settingsFile = File(p.join(settingsDir.path, 'app_settings.json'));
      await settingsFile.writeAsString(jsonEncode(safeSettings));

      // 4. إنشاء ملف الـ Manifest
      final manifest = BackupManifest(
        version: '1.0.0',
        appName: 'نظام إدارة مكتب المحاماة - النسخة السورية',
        createdAt: timestamp,
        documentsCount: copiedDocs,
        totalFiles: copiedDocs + 2, // db + settings
        isEncrypted: true,
      );

      final manifestFile = File(p.join(backupWorkspace.path, 'manifest.json'));
      await manifestFile.writeAsString(jsonEncode(manifest.toJson()));

      // 5. حفظ ملف جدول الـ Checksums
      final integrityDir = Directory(p.join(backupWorkspace.path, 'integrity'));
      await integrityDir.create();
      final checksumsFile = File(p.join(integrityDir.path, 'checksums.json'));
      await checksumsFile.writeAsString(jsonEncode(checksums));

      // 6. ضغط المجلد إلى أرشيف ZIP
      final archive = Archive();
      await for (final entity in backupWorkspace.list(recursive: true)) {
        if (entity is File) {
          final relativePath =
              p.relative(entity.path, from: backupWorkspace.path);
          final bytes = await entity.readAsBytes();
          archive.addFile(
              ArchiveFile(relativePath, bytes.length, bytes));
        }
      }

      final zipEncoder = ZipEncoder();
      final zipBytes = zipEncoder.encode(archive);
      if (zipBytes == null) {
        throw Exception('فشل في ترميز أرشيف ZIP');
      }

      // 7. تشفير الأرشيف باستخدام AES-256-GCM واشتقاق المفتاح عبر PBKDF2
      final encryptedBytes = await _encryptData(
        Uint8List.fromList(zipBytes),
        password,
      );

      // 8. حفظ الملف المشفر النهائي في مجلد النسخ الاحتياطية
      final backupDir = await _getBackupDirectory();
      final backupFileName = 'LawOffice_Backup_$dateStr.enc.zip';
      final backupFile = File(p.join(backupDir.path, backupFileName));
      await backupFile.writeAsBytes(encryptedBytes);

      // حساب Checksum للملف المشفر النهائي
      final backupSha256 =
          crypto.sha256.convert(encryptedBytes).toString();

      // 9. تسجيل النسخة في جدول تاريخ النسخ الاحتياطي
      final backupId = const Uuid().v4();
      await _db.into(_db.backupHistory).insert(
            BackupHistoryCompanion.insert(
              id: backupId,
              backupName: backupFileName,
              filePath: backupFile.path,
              fileSize: encryptedBytes.length,
              backupType: backupType,
              isEncrypted: const Value(1),
              documentsCount: copiedDocs,
              sha256Checksum: backupSha256,
              uploadedToDrive: const Value(0),
              createdAt: timestamp,
            ),
          );

      // تسجيل التدقيق
      await _db.into(_db.auditLogs).insert(
            AuditLogsCompanion.insert(
              id: const Uuid().v4(),
              timestamp: timestamp,
              action: 'BACKUP',
              entityType: 'SYSTEM',
              entityId: Value(backupId),
              details:
                  'إنشاء نسخة احتياطية مشفرة: $backupFileName ($copiedDocs مستندات)',
            ),
          );

      return BackupResult(
        backupPath: backupFile.path,
        fileSize: encryptedBytes.length,
        sha256Checksum: backupSha256,
        documentsCount: copiedDocs,
      );
    } finally {
      // تنظيف مجلد العمل المؤقت بأمان
      if (await backupWorkspace.exists()) {
        await backupWorkspace.delete(recursive: true);
      }
    }
  }

  /// فك تشفير واستعادة النسخة الاحتياطية بالكامل
  Future<BackupManifest> restoreBackup({
    required String backupFilePath,
    required String password,
  }) async {
    final backupFile = File(backupFilePath);
    if (!await backupFile.exists()) {
      throw Exception('ملف النسخة الاحتياطية غير موجود: $backupFilePath');
    }

    final encryptedBytes = await backupFile.readAsBytes();

    // 1. فك التشفير والتحقق من كلمة المرور
    final decryptedBytes = await _decryptData(encryptedBytes, password);

    // 2. فك ضغط أرشيف ZIP
    final archive = ZipDecoder().decodeBytes(decryptedBytes);

    final tempDir = await getTemporaryDirectory();
    final restoreWorkspace = Directory(p.join(
        tempDir.path, 'restore_temp_${DateTime.now().millisecondsSinceEpoch}'));
    await restoreWorkspace.create(recursive: true);

    try {
      for (final file in archive) {
        final filename = file.name;
        if (file.isFile) {
          final outFile = File(p.join(restoreWorkspace.path, filename));
          await outFile.parent.create(recursive: true);
          await outFile.writeAsBytes(file.content as List<int>);
        }
      }

      // 3. قراءة الـ Manifest والتحقق
      final manifestFile = File(p.join(restoreWorkspace.path, 'manifest.json'));
      if (!await manifestFile.exists()) {
        throw Exception('ملف التحقق (manifest.json) مفقود في النسخة الاحتياطية');
      }

      final manifestJson =
          jsonDecode(await manifestFile.readAsString()) as Map<String, dynamic>;
      final manifest = BackupManifest.fromJson(manifestJson);

      // 4. استعادة قاعدة البيانات
      final restoredDbFile =
          File(p.join(restoreWorkspace.path, 'database', 'law_office.sqlite'));
      if (await restoredDbFile.exists()) {
        final dbFolder = await getApplicationDocumentsDirectory();
        final currentDbFile = File(p.join(dbFolder.path, 'law_office.sqlite'));

        // إغلاق الاتصال الحالي واستبدال الملف
        await _db.close();
        await restoredDbFile.copy(currentDbFile.path);
      }

      // 5. استعادة المستندات إلى مجلد مستندات التطبيق المستقل
      final docsSourceDir = Directory(p.join(restoreWorkspace.path, 'documents'));
      if (await docsSourceDir.exists()) {
        final restoredDocsDir = await _getRestoredDocumentsDirectory();
        await for (final entity in docsSourceDir.list()) {
          if (entity is File) {
            final targetPath =
                p.join(restoredDocsDir.path, p.basename(entity.path));
            await entity.copy(targetPath);
          }
        }
      }

      // 6. استعادة إعدادات التطبيق
      final settingsFile =
          File(p.join(restoreWorkspace.path, 'settings', 'app_settings.json'));
      if (await settingsFile.exists()) {
        final settings =
            jsonDecode(await settingsFile.readAsString()) as Map<String, dynamic>;
        final prefs = await SharedPreferences.getInstance();

        if (settings['theme_mode'] != null) {
          await prefs.setInt('pref_theme_mode', settings['theme_mode'] as int);
        }
        if (settings['color_theme'] != null) {
          await prefs.setInt('pref_color_theme', settings['color_theme'] as int);
        }
        if (settings['font_size'] != null) {
          await prefs.setInt('pref_font_size', settings['font_size'] as int);
        }
        if (settings['auto_lock_minutes'] != null) {
          await prefs.setInt('pref_auto_lock_minutes',
              settings['auto_lock_minutes'] as int);
        }
      }

      return manifest;
    } finally {
      if (await restoreWorkspace.exists()) {
        await restoreWorkspace.delete(recursive: true);
      }
    }
  }

  // --- دوال التشفير واشتقاق المفاتيح (PBKDF2 + AES-GCM-256) ---

  Future<Uint8List> encryptDataForTesting(Uint8List data, String password) =>
      _encryptData(data, password);

  Future<Uint8List> decryptDataForTesting(Uint8List encryptedData, String password) =>
      _decryptData(encryptedData, password);

  Future<Uint8List> _encryptData(Uint8List data, String password) async {
    // 16 بايت Salt عشوائي
    final pbkdf2 = crypt.Pbkdf2(
      macAlgorithm: crypt.Hmac.sha256(),
      iterations: 100000,
      bits: 256,
    );

    final salt = crypt.SecretKeyData.random(length: 16).bytes;

    final secretKey = await pbkdf2.deriveKey(
      secretKey: crypt.SecretKey(utf8.encode(password)),
      nonce: salt,
    );

    final algorithm = crypt.AesGcm.with256bits();
    final secretBox = await algorithm.encrypt(
      data,
      secretKey: secretKey,
    );

    // البنية في الرأس: [4 بايت Magic 'LOBK'] + [16 بايت Salt] + [12 بايت Nonce/IV] + [16 بايت MAC] + [Ciphertext]
    final magic = utf8.encode('LOBK'); // Law Office Backup Key
    final builder = BytesBuilder();
    builder.add(magic);
    builder.add(salt);
    builder.add(secretBox.nonce);
    builder.add(secretBox.mac.bytes);
    builder.add(secretBox.cipherText);

    return builder.toBytes();
  }

  Future<Uint8List> _decryptData(Uint8List encryptedData, String password) async {
    if (encryptedData.length < 48) {
      throw Exception('ملف النسخة الاحتياطية تالف أو غير صالح');
    }

    final magic = utf8.decode(encryptedData.sublist(0, 4));
    if (magic != 'LOBK') {
      throw Exception('صيغة ملف النسخة الاحتياطية غير متوافقة');
    }

    final salt = encryptedData.sublist(4, 20);
    final nonce = encryptedData.sublist(20, 32);
    final macBytes = encryptedData.sublist(32, 48);
    final cipherText = encryptedData.sublist(48);

    final pbkdf2 = crypt.Pbkdf2(
      macAlgorithm: crypt.Hmac.sha256(),
      iterations: 100000,
      bits: 256,
    );

    final secretKey = await pbkdf2.deriveKey(
      secretKey: crypt.SecretKey(utf8.encode(password)),
      nonce: salt,
    );

    final algorithm = crypt.AesGcm.with256bits();
    try {
      final decrypted = await algorithm.decrypt(
        crypt.SecretBox(
          cipherText,
          nonce: nonce,
          mac: crypt.Mac(macBytes),
        ),
        secretKey: secretKey,
      );
      return Uint8List.fromList(decrypted);
    } catch (_) {
      throw Exception('كلمة مرور فك التشفير غير صحيحة، أو الأرشيف تالف');
    }
  }

  Future<Directory> _getBackupDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    final backupDir = Directory(p.join(appDir.path, 'backups'));
    if (!await backupDir.exists()) {
      await backupDir.create(recursive: true);
    }
    return backupDir;
  }

  Future<Directory> _getRestoredDocumentsDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    final docsDir = Directory(p.join(appDir.path, 'restored_documents'));
    if (!await docsDir.exists()) {
      await docsDir.create(recursive: true);
    }
    return docsDir;
  }
}
