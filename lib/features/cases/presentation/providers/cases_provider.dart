import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/database_provider.dart';
import '../../data/repositories/cases_repository.dart';

final casesRepositoryProvider = Provider<CasesRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return CasesRepository(db);
});

final caseSearchQueryProvider = StateProvider<String>((ref) => '');
final caseStatusFilterProvider = StateProvider<String?>((ref) => null);
final caseTypeFilterProvider = StateProvider<String?>((ref) => null);

final allCasesStreamProvider = StreamProvider<List<Case>>((ref) {
  final repo = ref.watch(casesRepositoryProvider);
  final search = ref.watch(caseSearchQueryProvider);
  final status = ref.watch(caseStatusFilterProvider);
  final type = ref.watch(caseTypeFilterProvider);

  return repo.watchAllCases(
    searchQuery: search,
    statusFilter: status,
    typeFilter: type,
    includeArchived: false,
  );
});

final caseListItemsStreamProvider = StreamProvider<List<CaseListItem>>((ref) {
  final repo = ref.watch(casesRepositoryProvider);
  final search = ref.watch(caseSearchQueryProvider);
  final status = ref.watch(caseStatusFilterProvider);
  final type = ref.watch(caseTypeFilterProvider);

  return repo.watchCaseListItems(
    searchQuery: search,
    statusFilter: status,
    typeFilter: type,
  );
});

final archivedCasesStreamProvider = StreamProvider<List<Case>>((ref) {
  final repo = ref.watch(casesRepositoryProvider);
  final search = ref.watch(caseSearchQueryProvider);

  return repo.watchAllCases(
    searchQuery: search,
    statusFilter: 'ARCHIVED',
    includeArchived: true,
  );
});

final caseWithDetailsProvider =
    FutureProvider.family<CaseWithDetails?, String>((ref, caseId) {
  final repo = ref.watch(casesRepositoryProvider);
  return repo.getCaseWithDetails(caseId);
});

final allCourtsProvider = FutureProvider<List<Court>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.courts)..orderBy([(tbl) => OrderingTerm.asc(tbl.name)]))
      .get();
});

final caseNotificationsStreamProvider =
    StreamProvider.family<List<CaseProcedure>, String>((ref, caseId) {
  final repo = ref.watch(casesRepositoryProvider);
  return repo.watchCaseNotifications(caseId);
});

final caseConcludedStagesStreamProvider =
    StreamProvider.family<List<CaseProcedure>, String>((ref, caseId) {
  final repo = ref.watch(casesRepositoryProvider);
  return repo.watchConcludedStages(caseId);
});
