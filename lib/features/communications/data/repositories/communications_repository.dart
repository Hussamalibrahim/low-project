import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/database/app_database.dart';

class CommunicationWithRelations {
  final Communication communication;
  final Client? client;
  final Case? caseItem;
  final Contact? contact;

  CommunicationWithRelations({
    required this.communication,
    this.client,
    this.caseItem,
    this.contact,
  });
}

class CommunicationsRepository {
  final AppDatabase _db;

  CommunicationsRepository(this._db);

  Stream<List<CommunicationWithRelations>> watchCommunications() {
    final query = _db.select(_db.communications).join([
      leftOuterJoin(
          _db.clients, _db.clients.id.equalsExp(_db.communications.clientId)),
      leftOuterJoin(
          _db.cases, _db.cases.id.equalsExp(_db.communications.caseId)),
      leftOuterJoin(
          _db.contacts, _db.contacts.id.equalsExp(_db.communications.contactId)),
    ])..where(_db.communications.deletedAt.isNull());

    query.orderBy([OrderingTerm.desc(_db.communications.communicationDate)]);

    return query.watch().map((rows) {
      return rows.map((r) {
        return CommunicationWithRelations(
          communication: r.readTable(_db.communications),
          client: r.readTableOrNull(_db.clients),
          caseItem: r.readTableOrNull(_db.cases),
          contact: r.readTableOrNull(_db.contacts),
        );
      }).toList();
    });
  }

  Future<String> recordCommunication({
    String? clientId,
    String? caseId,
    String? contactId,
    required String communicationType,
    required int communicationDate,
    required String summary,
    String? result,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final id = const Uuid().v4();

    await _db.into(_db.communications).insert(
          CommunicationsCompanion.insert(
            id: id,
            clientId: Value(clientId),
            caseId: Value(caseId),
            contactId: Value(contactId),
            communicationType: communicationType,
            communicationDate: communicationDate,
            summary: summary.trim(),
            result: Value(result?.trim()),
            createdAt: now,
          ),
        );

    return id;
  }
}

