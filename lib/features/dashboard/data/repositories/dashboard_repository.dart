import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/database/app_database.dart';

class DashboardAgendaItem {
  final String id;
  final String title;
  final String clientName;
  final String? clientId;
  final String caseType;
  final String? caseNumber;
  final String? caseId;
  final DateTime dateTime;
  final bool isHearing;
  final String status;
  final String? courtName;

  DashboardAgendaItem({
    required this.id,
    required this.title,
    required this.clientName,
    this.clientId,
    required this.caseType,
    this.caseNumber,
    this.caseId,
    required this.dateTime,
    required this.isHearing,
    required this.status,
    this.courtName,
  });
}

class DashboardStats {
  final int totalCases;
  final int activeCases;
  final int pendingCases;
  final int closedCases;
  final int archivedCases;
  final int todayHearingsCount;
  final int upcomingHearingsCount;
  final int overdueTasksCount;
  final int pendingTasksCount;
  final int totalClientsCount;
  final int totalDocumentsCount;
  final int totalPaymentsSyp;
  final int totalExpensesSyp;
  final List<Hearing> todayHearings;
  final List<Task> urgentTasks;
  final List<Client> recentClients;
  final List<Document> recentDocuments;
  final List<AuditLog> recentActivities;

  DashboardStats({
    required this.totalCases,
    required this.activeCases,
    required this.pendingCases,
    required this.closedCases,
    required this.archivedCases,
    required this.todayHearingsCount,
    required this.upcomingHearingsCount,
    required this.overdueTasksCount,
    required this.pendingTasksCount,
    required this.totalClientsCount,
    required this.totalDocumentsCount,
    required this.totalPaymentsSyp,
    required this.totalExpensesSyp,
    required this.todayHearings,
    required this.urgentTasks,
    required this.recentClients,
    required this.recentDocuments,
    required this.recentActivities,
  });
}

class DashboardRepository {
  final AppDatabase _db;

  DashboardRepository(this._db);

  Stream<DashboardStats> watchDashboardStats() {
    // نراقب التغييرات في جداول القضايا والجلسات والمهام لحساب الإحصائيات الحية
    return _db.select(_db.cases).watch().asyncMap((_) async {
      final now = DateTime.now();
      final startOfToday =
          DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;
      final endOfToday = DateTime(now.year, now.month, now.day, 23, 59, 59)
          .millisecondsSinceEpoch;

      final allCases = await (_db.select(_db.cases)
            ..where((tbl) => tbl.deletedAt.isNull()))
          .get();

      int total = 0;
      int active = 0;
      int pending = 0;
      int closed = 0;
      int archived = 0;

      for (final c in allCases) {
        total++;
        if (c.status == 'OPEN') active++;
        if (c.status == 'PENDING' || c.status == 'ON_HOLD') pending++;
        if (c.status == 'CLOSED' || c.status == 'EXECUTION') closed++;
        if (c.status == 'ARCHIVED') archived++;
      }

      // جلسات اليوم
      final todayHearings = await (_db.select(_db.hearings)
            ..where((tbl) =>
                tbl.deletedAt.isNull() &
                tbl.hearingDate.isBiggerOrEqualValue(startOfToday) &
                tbl.hearingDate.isSmallerOrEqualValue(endOfToday))
            ..orderBy([(tbl) => OrderingTerm.asc(tbl.hearingDate)]))
          .get();

      // جلسات قادمة
      final upcomingHearings = await (_db.select(_db.hearings)
            ..where((tbl) =>
                tbl.deletedAt.isNull() &
                tbl.hearingDate.isBiggerThanValue(endOfToday)))
          .get();

      // مهام متأخرة وعاجلة
      final overdueTasks = await (_db.select(_db.tasks)
            ..where((tbl) =>
                tbl.deletedAt.isNull() &
                tbl.status.equals('COMPLETED').not() &
                tbl.dueDate.isSmallerThanValue(now.millisecondsSinceEpoch))
            ..orderBy([(tbl) => OrderingTerm.asc(tbl.dueDate)]))
          .get();

      final pendingTasks = await (_db.select(_db.tasks)
            ..where((tbl) =>
                tbl.deletedAt.isNull() & tbl.status.equals('COMPLETED').not()))
          .get();

      // الموكلون
      final clients = await (_db.select(_db.clients)
            ..where((tbl) => tbl.deletedAt.isNull())
            ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)])
            ..limit(5))
          .get();

      final totalClientsCount = (await (_db.select(_db.clients)
                ..where((tbl) => tbl.deletedAt.isNull()))
              .get())
          .length;

      // المستندات الحديثة
      final recentDocs = await (_db.select(_db.documents)
            ..where((tbl) => tbl.deletedAt.isNull())
            ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)])
            ..limit(5))
          .get();

      final totalDocsCount = (await (_db.select(_db.documents)
                ..where((tbl) => tbl.deletedAt.isNull()))
              .get())
          .length;

      // المالية الحية بالليرة السورية
      final payments = await (_db.select(_db.payments)
            ..where((tbl) =>
                tbl.currency.equals('SYP') & tbl.deletedAt.isNull()))
          .get();
      final totalPaid = payments.fold<int>(0, (sum, p) => sum + p.amount);

      final expenses = await (_db.select(_db.expenses)
            ..where((tbl) =>
                tbl.currency.equals('SYP') & tbl.deletedAt.isNull()))
          .get();
      final totalExp = expenses.fold<int>(0, (sum, e) => sum + e.amount);

      // سجل التدقيق الحديث
      final audit = await (_db.select(_db.auditLogs)
            ..orderBy([(tbl) => OrderingTerm.desc(tbl.timestamp)])
            ..limit(6))
          .get();

      return DashboardStats(
        totalCases: total,
        activeCases: active,
        pendingCases: pending,
        closedCases: closed,
        archivedCases: archived,
        todayHearingsCount: todayHearings.length,
        upcomingHearingsCount: upcomingHearings.length,
        overdueTasksCount: overdueTasks.length,
        pendingTasksCount: pendingTasks.length,
        totalClientsCount: totalClientsCount,
        totalDocumentsCount: totalDocsCount,
        totalPaymentsSyp: totalPaid,
        totalExpensesSyp: totalExp,
        todayHearings: todayHearings,
        urgentTasks: overdueTasks.take(4).toList(),
        recentClients: clients,
        recentDocuments: recentDocs,
        recentActivities: audit,
      );
    });
  }

  /// مراقبة جدول الأعمال والمواعيد (جلسات ومهام) ليوم محدد، مع اسم الموكل ونوع القضية
  Stream<List<DashboardAgendaItem>> watchAgendaForDate(DateTime date) {
    final startOfDay =
        DateTime(date.year, date.month, date.day).millisecondsSinceEpoch;
    final endOfDay =
        DateTime(date.year, date.month, date.day, 23, 59, 59).millisecondsSinceEpoch;

    return _db
        .customSelect('SELECT 1', readsFrom: {_db.hearings, _db.tasks})
        .watch()
        .asyncMap((_) async {
      final List<DashboardAgendaItem> items = [];

      // 1. جلسات المحاكمة لهذا اليوم
      final dayHearings = await (_db.select(_db.hearings)
            ..where((tbl) =>
                tbl.deletedAt.isNull() &
                tbl.hearingDate.isBiggerOrEqualValue(startOfDay) &
                tbl.hearingDate.isSmallerOrEqualValue(endOfDay))
            ..orderBy([(tbl) => OrderingTerm.asc(tbl.hearingDate)]))
          .get();

      for (final h in dayHearings) {
        final caseItem = await (_db.select(_db.cases)
              ..where((tbl) => tbl.id.equals(h.caseId) & tbl.deletedAt.isNull()))
            .getSingleOrNull();
        if (caseItem == null) continue;

        // جلب الموكل المرتبط بالدعوى
        final clientLink = await (_db.select(_db.caseClients)
              ..where((tbl) => tbl.caseId.equals(caseItem.id)))
            .get();

        String clientName = 'موكل غير محدد';
        String? clientId;
        if (clientLink.isNotEmpty) {
          final client = await (_db.select(_db.clients)
                ..where((tbl) => tbl.id.equals(clientLink.first.clientId)))
              .getSingleOrNull();
          if (client != null) {
            clientName = client.fullName;
            clientId = client.id;
          }
        }

        // جلب المحكمة
        String? courtName;
        final courtId = h.courtId ?? caseItem.courtId;
        if (courtId != null) {
          final court = await (_db.select(_db.courts)
                ..where((tbl) => tbl.id.equals(courtId)))
              .getSingleOrNull();
          courtName = court?.name;
        }

        items.add(DashboardAgendaItem(
          id: h.id,
          title: h.hearingType,
          clientName: clientName,
          clientId: clientId,
          caseType: caseItem.caseType,
          caseNumber: caseItem.caseNumber,
          caseId: caseItem.id,
          dateTime: DateTime.fromMillisecondsSinceEpoch(h.hearingDate),
          isHearing: true,
          status: h.status,
          courtName: courtName,
        ));
      }

      // 2. المهام والإجراءات القضائية المستحقة لهذا اليوم
      final dayTasks = await (_db.select(_db.tasks)
            ..where((tbl) =>
                tbl.deletedAt.isNull() &
                tbl.dueDate.isBiggerOrEqualValue(startOfDay) &
                tbl.dueDate.isSmallerOrEqualValue(endOfDay))
            ..orderBy([(tbl) => OrderingTerm.asc(tbl.dueDate)]))
          .get();

      for (final t in dayTasks) {
        String clientName = 'مهمة مكتبية';
        String? clientId = t.clientId;
        String caseType = 'إجراء / عمل قضائي';
        String? caseNumber;

        if (t.caseId != null) {
          final caseItem = await (_db.select(_db.cases)
                ..where((tbl) => tbl.id.equals(t.caseId!) & tbl.deletedAt.isNull()))
              .getSingleOrNull();
          if (caseItem != null) {
            caseType = caseItem.caseType;
            caseNumber = caseItem.caseNumber;
            if (clientId == null) {
              final clientLink = await (_db.select(_db.caseClients)
                    ..where((tbl) => tbl.caseId.equals(caseItem.id)))
                  .get();
              if (clientLink.isNotEmpty) {
                clientId = clientLink.first.clientId;
              }
            }
          }
        }

        if (clientId != null) {
          final client = await (_db.select(_db.clients)
                ..where((tbl) => tbl.id.equals(clientId!)))
              .getSingleOrNull();
          if (client != null) {
            clientName = client.fullName;
          }
        }

        items.add(DashboardAgendaItem(
          id: t.id,
          title: t.title,
          clientName: clientName,
          clientId: clientId,
          caseType: caseType,
          caseNumber: caseNumber,
          caseId: t.caseId,
          dateTime: DateTime.fromMillisecondsSinceEpoch(t.dueDate),
          isHearing: false,
          status: t.status,
        ));
      }

      items.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      return items;
    });
  }

  /// مراقبة الأيام التي تحتوي على مواعيد أو جلسات في الشهر المحدد لوضع نقاط دلالية
  Stream<Set<int>> watchDaysWithEvents(DateTime month) {
    final startOfMonth =
        DateTime(month.year, month.month, 1).millisecondsSinceEpoch;
    final endOfMonth =
        DateTime(month.year, month.month + 1, 0, 23, 59, 59).millisecondsSinceEpoch;

    return _db
        .customSelect('SELECT 1', readsFrom: {_db.hearings, _db.tasks})
        .watch()
        .asyncMap((_) async {
      final hearings = await (_db.select(_db.hearings)
            ..where((tbl) =>
                tbl.deletedAt.isNull() &
                tbl.hearingDate.isBiggerOrEqualValue(startOfMonth) &
                tbl.hearingDate.isSmallerOrEqualValue(endOfMonth)))
          .get();

      final tasks = await (_db.select(_db.tasks)
            ..where((tbl) =>
                tbl.deletedAt.isNull() &
                tbl.dueDate.isBiggerOrEqualValue(startOfMonth) &
                tbl.dueDate.isSmallerOrEqualValue(endOfMonth)))
          .get();

      final Set<int> days = {};
      for (final h in hearings) {
        days.add(DateTime.fromMillisecondsSinceEpoch(h.hearingDate).day);
      }
      for (final t in tasks) {
        days.add(DateTime.fromMillisecondsSinceEpoch(t.dueDate).day);
      }
      return days;
    });
  }

  /// إضافة سريعة لمهمة أو جلسة من التقويم بالصفحة الرئيسية
  Future<void> addQuickEvent({
    required DateTime date,
    required String title,
    required bool isHearing,
    String? clientId,
    String? caseId,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    if (isHearing && caseId != null) {
      await _db.into(_db.hearings).insert(
            HearingsCompanion.insert(
              id: const Uuid().v4(),
              caseId: caseId,
              hearingDate: date.millisecondsSinceEpoch,
              hearingType: title.trim(),
              status: const Value('SCHEDULED'),
              createdAt: now,
            ),
          );
    } else {
      await _db.into(_db.tasks).insert(
            TasksCompanion.insert(
              id: const Uuid().v4(),
              caseId: Value(caseId),
              clientId: Value(clientId),
              title: title.trim(),
              priority: 'MEDIUM',
              dueDate: date.millisecondsSinceEpoch,
              status: const Value('PENDING'),
              createdAt: now,
            ),
          );
    }
  }
}

