import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:law_office/core/database/app_database.dart';
import 'package:law_office/features/clients/data/repositories/clients_repository.dart';

void main() {
  late AppDatabase db;
  late ClientsRepository clientsRepo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    clientsRepo = ClientsRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('AppDatabase & ClientsRepository Tests', () {
    test('creates client and retrieves it successfully', () async {
      final clientId = await clientsRepo.createClient(
        fullName: 'سامر الحلبي',
        clientType: 'INDIVIDUAL',
        nationalId: '01010101010',
        phone: '0933111222',
        address: 'دمشق - المزة فيلات شرقية',
      );

      final client = await clientsRepo.getClientById(clientId);
      expect(client, isNotNull);
      expect(client!.fullName, 'سامر الحلبي');
      expect(client.nationalId, '01010101010');
      expect(client.deletedAt, isNull);
    });

    test('detects duplicate national IDs', () async {
      await clientsRepo.createClient(
        fullName: 'محمد دمشقي',
        clientType: 'INDIVIDUAL',
        nationalId: '02020202020',
        phone: '0944111222',
      );

      final isDuplicate = await clientsRepo.checkNationalIdExists('02020202020');
      expect(isDuplicate, isTrue);

      final isNotDuplicate = await clientsRepo.checkNationalIdExists('09999999999');
      expect(isNotDuplicate, isFalse);
    });

    test('soft deletes client without destroying audit logs', () async {
      final clientId = await clientsRepo.createClient(
        fullName: 'خالد النجار',
        clientType: 'INDIVIDUAL',
        phone: '0955111222',
      );

      await clientsRepo.deleteClient(clientId, 'خالد النجار');

      // Should not appear in active clients list
      final activeClients = await clientsRepo.watchAllClients().first;
      expect(activeClients.any((c) => c.id == clientId), isFalse);

      // Record still exists in DB with deletedAt set
      final deletedClient = await (db.select(db.clients)
            ..where((tbl) => tbl.id.equals(clientId)))
          .getSingleOrNull();
      expect(deletedClient, isNotNull);
      expect(deletedClient!.deletedAt, isNotNull);
    });
  });
}
