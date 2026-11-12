import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/database/app_database.dart';

class ContractWithRelations {
  final Contract contract;
  final Client client;
  final Case? caseItem;
  final Document? document;

  ContractWithRelations({
    required this.contract,
    required this.client,
    this.caseItem,
    this.document,
  });
}

class ContractsRepository {
  final AppDatabase _db;

  ContractsRepository(this._db);

  Stream<List<ContractWithRelations>> watchAllContracts() {
    final query = _db.select(_db.contracts).join([
      innerJoin(_db.clients, _db.clients.id.equalsExp(_db.contracts.clientId)),
      leftOuterJoin(_db.cases, _db.cases.id.equalsExp(_db.contracts.caseId)),
      leftOuterJoin(
          _db.documents, _db.documents.id.equalsExp(_db.contracts.documentId)),
    ])..where(_db.contracts.deletedAt.isNull());

    query.orderBy([OrderingTerm.desc(_db.contracts.issueDate)]);

    return query.watch().map((rows) {
      return rows.map((r) {
        return ContractWithRelations(
          contract: r.readTable(_db.contracts),
          client: r.readTable(_db.clients),
          caseItem: r.readTableOrNull(_db.cases),
          document: r.readTableOrNull(_db.documents),
        );
      }).toList();
    });
  }

  Future<String> createContract({
    required String clientId,
    String? caseId,
    required String documentNumber,
    required String contractType,
    String? issuingAuthority,
    required int issueDate,
    int? expiryDate,
    String status = 'ACTIVE',
    String? documentId,
    String? notes,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final id = const Uuid().v4();

    await _db.into(_db.contracts).insert(
          ContractsCompanion.insert(
            id: id,
            clientId: clientId,
            caseId: Value(caseId),
            documentNumber: documentNumber.trim(),
            contractType: contractType,
            issuingAuthority: Value(issuingAuthority?.trim()),
            issueDate: issueDate,
            expiryDate: Value(expiryDate),
            status: Value(status),
            documentId: Value(documentId),
            notes: Value(notes?.trim()),
            createdAt: now,
          ),
        );

    return id;
  }
}

