import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/database_provider.dart';
import '../../data/repositories/tasks_repository.dart';

final tasksRepositoryProvider = Provider<TasksRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return TasksRepository(db);
});

final taskStatusFilterProvider = StateProvider<String?>((ref) => null);
final taskPriorityFilterProvider = StateProvider<String?>((ref) => null);

final allTasksStreamProvider = StreamProvider<List<TaskWithRelations>>((ref) {
  final repo = ref.watch(tasksRepositoryProvider);
  final status = ref.watch(taskStatusFilterProvider);
  final priority = ref.watch(taskPriorityFilterProvider);

  return repo.watchAllTasks(
    statusFilter: status,
    priorityFilter: priority,
  );
});

final overdueTasksStreamProvider =
    StreamProvider<List<TaskWithRelations>>((ref) {
  final repo = ref.watch(tasksRepositoryProvider);
  return repo.watchAllTasks(onlyOverdue: true);
});

final caseTasksStreamProvider =
    StreamProvider.family<List<Task>, String>((ref, caseId) {
  final repo = ref.watch(tasksRepositoryProvider);
  return repo.watchCaseTasks(caseId);
});
