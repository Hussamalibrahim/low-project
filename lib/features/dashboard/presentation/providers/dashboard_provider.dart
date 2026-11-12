import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/database_provider.dart';
import '../../data/repositories/dashboard_repository.dart';

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return DashboardRepository(db);
});

final dashboardStatsStreamProvider = StreamProvider<DashboardStats>((ref) {
  final repo = ref.watch(dashboardRepositoryProvider);
  return repo.watchDashboardStats();
});

/// التاريخ المحدد حالياً في تقويم الواجهة الرئيسية
final selectedCalendarDateProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

/// جدول الأعمال والإشعارات اليومية للتاريخ المحدد
final dashboardAgendaStreamProvider =
    StreamProvider.family<List<DashboardAgendaItem>, DateTime>((ref, date) {
  final repo = ref.watch(dashboardRepositoryProvider);
  return repo.watchAgendaForDate(date);
});

/// الأيام التي تحتوي على أحداث في الشهر المعروض
final dashboardDaysWithEventsStreamProvider =
    StreamProvider.family<Set<int>, DateTime>((ref, month) {
  final repo = ref.watch(dashboardRepositoryProvider);
  return repo.watchDaysWithEvents(month);
});
