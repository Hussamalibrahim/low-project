import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_status_badge.dart';
import '../../../hearings/data/repositories/hearings_repository.dart';
import '../../../hearings/presentation/providers/hearings_provider.dart';
import '../../../tasks/data/repositories/tasks_repository.dart';
import '../../../tasks/presentation/providers/tasks_provider.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hearingsAsync = ref.watch(allHearingsStreamProvider);
    final tasksAsync = ref.watch(allTasksStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('التقويم القضائي الموحد'),
      ),
      body: Column(
        children: [
          // شريط اختيار التاريخ والأيام
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: theme.brightness == Brightness.dark
                  ? const Color(0xFF1E293B)
                  : Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: theme.brightness == Brightness.dark
                      ? const Color(0xFF334155)
                      : const Color(0xFFE2E8F0),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () {
                    setState(() {
                      _selectedDate =
                          _selectedDate.subtract(const Duration(days: 1));
                    });
                  },
                ),
                InkWell(
                  onTap: () async {
                    final d = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2035),
                    );
                    if (d != null) {
                      setState(() => _selectedDate = d);
                    }
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_month, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text(
                        AppDateFormatter.formatDate(_selectedDate),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () {
                    setState(() {
                      _selectedDate =
                          _selectedDate.add(const Duration(days: 1));
                    });
                  },
                ),
              ],
            ),
          ),

          // قائمة أحداث اليوم المحدد (جلسات + مهام)
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // 1. جلسات اليوم
                Text(
                  'جلسات المحاكمة لهذا اليوم',
                  style: theme.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                hearingsAsync.when(
                  data: (List<HearingWithCase> hearings) {
                    final dayHearings = hearings.where((h) {
                      final hDate = DateTime.fromMillisecondsSinceEpoch(
                          h.hearing.hearingDate);
                      return hDate.year == _selectedDate.year &&
                          hDate.month == _selectedDate.month &&
                          hDate.day == _selectedDate.day;
                    }).toList();

                    if (dayHearings.isEmpty) {
                      return const AppCard(
                        child: Text('لا توجد جلسات محاكمة مجدولة في هذا اليوم'),
                      );
                    }

                    return Column(
                      children: dayHearings.map((h) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: AppCard(
                            onTap: () =>
                                context.push('/cases/${h.caseItem.id}'),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.teal.withAlpha(25),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(Icons.event_seat,
                                      color: Colors.teal),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'أساس ${h.caseItem.caseNumber} / ${h.caseItem.caseYear} - ${h.hearing.hearingType}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'الوقت: ${AppDateFormatter.formatTime(DateTime.fromMillisecondsSinceEpoch(h.hearing.hearingDate))} • ${h.court?.name ?? "المحكمة"}',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: theme.hintColor),
                                      ),
                                    ],
                                  ),
                                ),
                                AppStatusBadge(label: h.hearing.status),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                  loading: () => const LinearProgressIndicator(),
                  error: (e, _) => Text('خطأ: $e'),
                ),
                const SizedBox(height: 20),

                // 2. مهام اليوم
                Text(
                  'المهام والمواعيد المستحقة لهذا اليوم',
                  style: theme.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                tasksAsync.when(
                  data: (List<TaskWithRelations> tasks) {
                    final dayTasks = tasks.where((t) {
                      final tDate =
                          DateTime.fromMillisecondsSinceEpoch(t.task.dueDate);
                      return tDate.year == _selectedDate.year &&
                          tDate.month == _selectedDate.month &&
                          tDate.day == _selectedDate.day;
                    }).toList();

                    if (dayTasks.isEmpty) {
                      return const AppCard(
                        child: Text('لا توجد مهام مستحقة في هذا اليوم'),
                      );
                    }

                    return Column(
                      children: dayTasks.map((t) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: AppCard(
                            onTap: () => context.push('/tasks'),
                            child: Row(
                              children: [
                                const Icon(Icons.check_circle_outline,
                                    color: Colors.amber),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(t.task.title,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      if (t.caseItem != null)
                                        Text(
                                          'قضية: ${t.caseItem!.title}',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: theme.hintColor),
                                        ),
                                    ],
                                  ),
                                ),
                                AppStatusBadge(
                                  label: t.task.priority,
                                  color: Colors.amber.shade800,
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                  loading: () => const LinearProgressIndicator(),
                  error: (e, _) => Text('خطأ: $e'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
