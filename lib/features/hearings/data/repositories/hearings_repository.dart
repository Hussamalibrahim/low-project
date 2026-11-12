import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/database/app_database.dart';

class HearingWithCase {
  final Hearing hearing;
  final Case caseItem;
  final Court? court;

  HearingWithCase({
    required this.hearing,
    required this.caseItem,
    this.court,
  });
}

class HearingsRepository {
  final AppDatabase _db;

  HearingsRepository(this._db);

  Stream<List<HearingWithCase>> watchAllHearings({DateTime? date}) {
    final query = _db.select(_db.hearings).join([
      innerJoin(_db.cases, _db.cases.id.equalsExp(_db.hearings.caseId)),
      leftOuterJoin(_db.courts, _db.courts.id.equalsExp(_db.hearings.courtId)),
    ])..where(_db.hearings.deletedAt.isNull() & _db.cases.deletedAt.isNull());

    if (date != null) {
      final startOfDay =
          DateTime(date.year, date.month, date.day).millisecondsSinceEpoch;
      final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59)
          .millisecondsSinceEpoch;
      query.where(_db.hearings.hearingDate.isBiggerOrEqualValue(startOfDay) &
          _db.hearings.hearingDate.isSmallerOrEqualValue(endOfDay));
    }

    query.orderBy([OrderingTerm.asc(_db.hearings.hearingDate)]);

    return query.watch().map((rows) {
      return rows.map((r) {
        return HearingWithCase(
          hearing: r.readTable(_db.hearings),
          caseItem: r.readTable(_db.cases),
          court: r.readTableOrNull(_db.courts),
        );
      }).toList();
    });
  }

  Stream<List<Hearing>> watchCaseHearings(String caseId) {
    return (_db.select(_db.hearings)
          ..where((tbl) => tbl.caseId.equals(caseId) & tbl.deletedAt.isNull())
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.hearingDate)]))
        .watch();
  }

  Future<String> addHearing({
    required String caseId,
    String? courtId,
    required int hearingDate,
    required String hearingType,
    String status = 'SCHEDULED',
    String? decision,
    String? postponementReason,
    int? nextHearingDate,
    String? lawyerNotes,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final id = const Uuid().v4();

    await _db.into(_db.hearings).insert(
          HearingsCompanion.insert(
            id: id,
            caseId: caseId,
            courtId: Value(courtId),
            hearingDate: hearingDate,
            hearingType: hearingType,
            status: Value(status),
            decision: Value(decision?.trim()),
            postponementReason: Value(postponementReason?.trim()),
            nextHearingDate: Value(nextHearingDate),
            lawyerNotes: Value(lawyerNotes?.trim()),
            createdAt: now,
          ),
        );

    // تسجيل التدقيق
    await _db.into(_db.auditLogs).insert(
          AuditLogsCompanion.insert(
            id: const Uuid().v4(),
            timestamp: now,
            action: 'CREATE',
            entityType: 'CASE',
            entityId: Value(caseId),
            details: 'تسجيل جلسة محاكمة جديدة بتاريخ: ${DateTime.fromMillisecondsSinceEpoch(hearingDate)}',
          ),
        );

    return id;
  }

  Future<void> updateHearingDecision({
    required String id,
    required String status,
    String? decision,
    String? postponementReason,
    int? nextHearingDate,
    String? lawyerNotes,
  }) async {
    await (_db.update(_db.hearings)..where((tbl) => tbl.id.equals(id))).write(
      HearingsCompanion(
        status: Value(status),
        decision: Value(decision?.trim()),
        postponementReason: Value(postponementReason?.trim()),
        nextHearingDate: Value(nextHearingDate),
        lawyerNotes: Value(lawyerNotes?.trim()),
      ),
    );
  }

  /// تأجيل جلسة محاكمة وتحديد موعد جديد مع ذكر سبب التأجيل
  Future<void> postponeHearing({
    required String hearingId,
    required String caseId,
    String? courtId,
    required int newHearingDate,
    required String reason,
    String? hearingType,
  }) async {
    await updateHearingDecision(
      id: hearingId,
      status: 'POSTPONED',
      postponementReason: reason,
      nextHearingDate: newHearingDate,
    );

    await addHearing(
      caseId: caseId,
      courtId: courtId,
      hearingDate: newHearingDate,
      hearingType: hearingType ?? 'جلسة محاكمة',
      status: 'SCHEDULED',
      lawyerNotes: 'تأجلت عن الجلسة السابقة لعلة: $reason',
    );
  }

  // --- الإجراءات والمعاملات القضائية (Case Procedures) ---

  Stream<List<CaseProcedure>> watchCaseProcedures(String caseId) {
    return (_db.select(_db.caseProcedures)
          ..where((tbl) => tbl.caseId.equals(caseId) & tbl.deletedAt.isNull())
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.procedureDate)]))
        .watch();
  }

  Future<String> addProcedure({
    required String caseId,
    required int procedureDate,
    required String title,
    required String procedureType,
    String? description,
    String? result,
    String? documentId,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final id = const Uuid().v4();

    await _db.into(_db.caseProcedures).insert(
          CaseProceduresCompanion.insert(
            id: id,
            caseId: caseId,
            procedureDate: procedureDate,
            title: title.trim(),
            procedureType: procedureType,
            description: Value(description?.trim()),
            result: Value(result?.trim()),
            documentId: Value(documentId),
            createdAt: now,
          ),
        );

    return id;
  }
}

