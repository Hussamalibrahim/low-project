import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/database_provider.dart';
import '../../data/repositories/hearings_repository.dart';

final hearingsRepositoryProvider = Provider<HearingsRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return HearingsRepository(db);
});

final selectedHearingDateProvider = StateProvider<DateTime?>((ref) => null);

final allHearingsStreamProvider = StreamProvider<List<HearingWithCase>>((ref) {
  final repo = ref.watch(hearingsRepositoryProvider);
  final date = ref.watch(selectedHearingDateProvider);
  return repo.watchAllHearings(date: date);
});

final caseHearingsStreamProvider =
    StreamProvider.family<List<Hearing>, String>((ref, caseId) {
  final repo = ref.watch(hearingsRepositoryProvider);
  return repo.watchCaseHearings(caseId);
});

final caseProceduresStreamProvider =
    StreamProvider.family<List<CaseProcedure>, String>((ref, caseId) {
  final repo = ref.watch(hearingsRepositoryProvider);
  return repo.watchCaseProcedures(caseId);
});
