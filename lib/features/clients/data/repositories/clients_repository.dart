import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/utils/arabic_normalizer.dart';

class ClientsRepository {
  final AppDatabase _db;

  ClientsRepository(this._db);

  Stream<List<Client>> watchAllClients({String? searchQuery}) {
    final query = _db.select(_db.clients)
      ..where((tbl) => tbl.deletedAt.isNull())
      ..orderBy([(tbl) => OrderingTerm.asc(tbl.fullName)]);

    return query.watch().map((list) {
      if (searchQuery == null || searchQuery.trim().isEmpty) {
        return list;
      }
      return list.where((client) {
        final matchesName =
            ArabicNormalizer.contains(client.fullName, searchQuery);
        final matchesPhone = client.phone.contains(searchQuery) ||
            (client.phoneSecondary?.contains(searchQuery) ?? false);
        final matchesNationalId =
            client.nationalId?.contains(searchQuery) ?? false;
        final matchesCompany = client.companyName != null &&
            ArabicNormalizer.contains(client.companyName!, searchQuery);

        return matchesName ||
            matchesPhone ||
            matchesNationalId ||
            matchesCompany;
      }).toList();
    });
  }

  Future<List<Client>> getAllClients() {
    return (_db.select(_db.clients)
          ..where((tbl) => tbl.deletedAt.isNull())
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.fullName)]))
        .get();
  }

  Future<Client?> getClientById(String id) {
    return (_db.select(_db.clients)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  /// التحقق من منع التكرار بالرقم الوطني
  Future<bool> checkNationalIdExists(String nationalId,
      {String? excludeClientId}) async {
    final query = _db.select(_db.clients)
      ..where((tbl) =>
          tbl.nationalId.equals(nationalId) & tbl.deletedAt.isNull());
    if (excludeClientId != null) {
      query.where((tbl) => tbl.id.equals(excludeClientId).not());
    }
    final existing = await query.getSingleOrNull();
    return existing != null;
  }

  Future<String> createClient({
    required String clientType,
    required String fullName,
    String? nationalId,
    required String phone,
    String? phoneSecondary,
    String? email,
    String? address,
    String? occupation,
    String? companyName,
    String? commercialRecord,
    String? notes,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final id = const Uuid().v4();

    await _db.into(_db.clients).insert(
          ClientsCompanion.insert(
            id: id,
            clientType: clientType,
            fullName: fullName.trim(),
            nationalId: Value(nationalId?.trim()),
            phone: phone.trim(),
            phoneSecondary: Value(phoneSecondary?.trim()),
            email: Value(email?.trim()),
            address: Value(address?.trim()),
            occupation: Value(occupation?.trim()),
            companyName: Value(companyName?.trim()),
            commercialRecord: Value(commercialRecord?.trim()),
            notes: Value(notes?.trim()),
            createdAt: now,
            updatedAt: now,
          ),
        );

    // تسجيل في سجل التدقيق
    await _db.into(_db.auditLogs).insert(
          AuditLogsCompanion.insert(
            id: const Uuid().v4(),
            timestamp: now,
            action: 'CREATE',
            entityType: 'CLIENT',
            entityId: Value(id),
            details: 'إضافة موكل جديد: $fullName',
          ),
        );

    return id;
  }

  Future<void> updateClient({
    required String id,
    required String clientType,
    required String fullName,
    String? nationalId,
    required String phone,
    String? phoneSecondary,
    String? email,
    String? address,
    String? occupation,
    String? companyName,
    String? commercialRecord,
    String? notes,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;

    await (_db.update(_db.clients)..where((tbl) => tbl.id.equals(id))).write(
      ClientsCompanion(
        clientType: Value(clientType),
        fullName: Value(fullName.trim()),
        nationalId: Value(nationalId?.trim()),
        phone: Value(phone.trim()),
        phoneSecondary: Value(phoneSecondary?.trim()),
        email: Value(email?.trim()),
        address: Value(address?.trim()),
        occupation: Value(occupation?.trim()),
        companyName: Value(companyName?.trim()),
        commercialRecord: Value(commercialRecord?.trim()),
        notes: Value(notes?.trim()),
        updatedAt: Value(now),
      ),
    );

    // تسجيل في سجل التدقيق
    await _db.into(_db.auditLogs).insert(
          AuditLogsCompanion.insert(
            id: const Uuid().v4(),
            timestamp: now,
            action: 'UPDATE',
            entityType: 'CLIENT',
            entityId: Value(id),
            details: 'تعديل بيانات الموكل: $fullName',
          ),
        );
  }

  Future<void> deleteClient(String id, String clientName) async {
    final now = DateTime.now().millisecondsSinceEpoch;

    // حذف منطقي (Soft Delete)
    await (_db.update(_db.clients)..where((tbl) => tbl.id.equals(id))).write(
      ClientsCompanion(
        deletedAt: Value(now),
        updatedAt: Value(now),
      ),
    );

    // تسجيل في سجل التدقيق
    await _db.into(_db.auditLogs).insert(
          AuditLogsCompanion.insert(
            id: const Uuid().v4(),
            timestamp: now,
            action: 'DELETE',
            entityType: 'CLIENT',
            entityId: Value(id),
            details: 'أرشفة/حذف الموكل: $clientName',
          ),
        );
  }

  /// جلب القضايا المرتبطة بالموكل
  Stream<List<Case>> watchClientCases(String clientId) {
    final query = _db.select(_db.cases).join([
      innerJoin(
        _db.caseClients,
        _db.caseClients.caseId.equalsExp(_db.cases.id),
      ),
    ])
      ..where(_db.caseClients.clientId.equals(clientId) &
          _db.cases.deletedAt.isNull())
      ..orderBy([OrderingTerm.desc(_db.cases.caseYear)]);

    return query.watch().map((rows) {
      return rows.map((row) => row.readTable(_db.cases)).toList();
    });
  }

  /// جلب المعاملات المالية المرتبطة بالموكل
  Stream<List<Payment>> watchClientPayments(String clientId) {
    return (_db.select(_db.payments)
          ..where((tbl) =>
              tbl.clientId.equals(clientId) & tbl.deletedAt.isNull())
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.paymentDate)]))
        .watch();
  }
}

