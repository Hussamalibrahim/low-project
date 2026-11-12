import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/database/app_database.dart';

class TaskWithRelations {
  final Task task;
  final Case? caseItem;
  final Client? client;

  TaskWithRelations({
    required this.task,
    this.caseItem,
    this.client,
  });
}

class TasksRepository {
  final AppDatabase _db;

  TasksRepository(this._db);

  Stream<List<TaskWithRelations>> watchAllTasks({
    String? statusFilter,
    String? priorityFilter,
    bool onlyOverdue = false,
  }) {
    final query = _db.select(_db.tasks).join([
      leftOuterJoin(_db.cases, _db.cases.id.equalsExp(_db.tasks.caseId)),
      leftOuterJoin(_db.clients, _db.clients.id.equalsExp(_db.tasks.clientId)),
    ])..where(_db.tasks.deletedAt.isNull());

    if (statusFilter != null && statusFilter.isNotEmpty) {
      query.where(_db.tasks.status.equals(statusFilter));
    }

    if (priorityFilter != null && priorityFilter.isNotEmpty) {
      query.where(_db.tasks.priority.equals(priorityFilter));
    }

    if (onlyOverdue) {
      final now = DateTime.now().millisecondsSinceEpoch;
      query.where(_db.tasks.dueDate.isSmallerThanValue(now) &
          _db.tasks.status.equals('COMPLETED').not());
    }

    query.orderBy([OrderingTerm.asc(_db.tasks.dueDate)]);

    return query.watch().map((rows) {
      return rows.map((r) {
        return TaskWithRelations(
          task: r.readTable(_db.tasks),
          caseItem: r.readTableOrNull(_db.cases),
          client: r.readTableOrNull(_db.clients),
        );
      }).toList();
    });
  }

  Stream<List<Task>> watchCaseTasks(String caseId) {
    return (_db.select(_db.tasks)
          ..where((tbl) => tbl.caseId.equals(caseId) & tbl.deletedAt.isNull())
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.dueDate)]))
        .watch();
  }

  Future<String> createTask({
    required String title,
    String? description,
    String? caseId,
    String? clientId,
    String priority = 'MEDIUM',
    required int dueDate,
    int? reminderTime,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final id = const Uuid().v4();

    await _db.into(_db.tasks).insert(
          TasksCompanion.insert(
            id: id,
            title: title.trim(),
            description: Value(description?.trim()),
            caseId: Value(caseId),
            clientId: Value(clientId),
            priority: priority,
            status: const Value('PENDING'),
            dueDate: dueDate,
            reminderTime: Value(reminderTime),
            createdAt: now,
          ),
        );

    return id;
  }

  Future<void> updateTaskStatus(String id, String status) async {
    final isCompleted = status == 'COMPLETED';
    final now = isCompleted ? DateTime.now().millisecondsSinceEpoch : null;

    await (_db.update(_db.tasks)..where((tbl) => tbl.id.equals(id))).write(
      TasksCompanion(
        status: Value(status),
        completedAt: Value(now),
      ),
    );
  }

  Future<void> updateTask({
    required String id,
    required String title,
    String? description,
    String? caseId,
    String? clientId,
    int? dueDate,
    String? priority,
  }) async {
    await (_db.update(_db.tasks)..where((tbl) => tbl.id.equals(id))).write(
      TasksCompanion(
        title: Value(title),
        description: Value(description),
        caseId: Value(caseId),
        clientId: Value(clientId),
        dueDate: dueDate != null ? Value(dueDate) : const Value.absent(),
        priority: priority != null ? Value(priority) : const Value.absent(),
      ),
    );
  }

  Future<void> deleteTask(String id) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await (_db.update(_db.tasks)..where((tbl) => tbl.id.equals(id))).write(
      TasksCompanion(deletedAt: Value(now)),
    );
  }
}

