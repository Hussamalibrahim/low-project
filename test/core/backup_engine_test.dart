import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:law_office/core/backup/backup_engine.dart';
import 'package:law_office/core/database/app_database.dart';

void main() {
  late AppDatabase db;
  late BackupEngine backupEngine;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    backupEngine = BackupEngine(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('BackupEngine Encryption & Decryption Tests', () {
    test('encrypts and decrypts payload correctly using password (AES-256-GCM + PBKDF2)', () async {
      const originalText = 'سرية بيانات مكتب المحاماة بدمشق - ملفات ووثائق قانونية سرية للغاية';
      final originalBytes = Uint8List.fromList(utf8.encode(originalText));
      const password = 'LawOfficeSuperSecretKey@2026!';

      final encrypted = await backupEngine.encryptDataForTesting(originalBytes, password);
      expect(encrypted.length, greaterThan(originalBytes.length));
      expect(encrypted.sublist(0, 4), utf8.encode('LOBK'));

      final decrypted = await backupEngine.decryptDataForTesting(encrypted, password);
      final decryptedText = utf8.decode(decrypted);

      expect(decryptedText, equals(originalText));
    });

    test('fails decryption when supplied with incorrect password', () async {
      const originalText = 'وثيقة قانونية حساسة';
      final originalBytes = Uint8List.fromList(utf8.encode(originalText));

      final encrypted = await backupEngine.encryptDataForTesting(originalBytes, 'correctPassword123');

      expect(
        () async => await backupEngine.decryptDataForTesting(encrypted, 'wrongPassword999'),
        throwsA(isA<Exception>()),
      );
    });

    test('fails decryption if data is tampered or corrupted', () async {
      const originalText = 'عقد تسوية ومخالصة تامة';
      final originalBytes = Uint8List.fromList(utf8.encode(originalText));
      const password = 'StrongPassword!#456';

      final encrypted = await backupEngine.encryptDataForTesting(originalBytes, password);
      // Corrupt a byte in ciphertext
      encrypted[encrypted.length - 1] ^= 0xFF;

      expect(
        () async => await backupEngine.decryptDataForTesting(encrypted, password),
        throwsA(isA<Exception>()),
      );
    });
  });
}

