import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_empty_state.dart';
import '../../../../shared/widgets/app_status_badge.dart';
import '../providers/cases_provider.dart';

class CasesScreen extends ConsumerWidget {
  const CasesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final caseItemsAsync = ref.watch(caseListItemsStreamProvider);
    final selectedStatus = ref.watch(caseStatusFilterProvider);

    final statusList = [
      (label: 'الكل', value: null),
      (label: 'قيد النظر', value: 'OPEN'),
      (label: 'معلقة', value: 'PENDING'),
      (label: 'طعن', value: 'APPEALED'),
      (label: 'قيد التنفيذ', value: 'EXECUTION'),
      (label: 'مفصولة', value: 'CLOSED'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('سجل القضايا والموكلين'),
        actions: [
          IconButton(
            icon: const Icon(Icons.archive_outlined),
            tooltip: 'أرشيف القضايا',
            onPressed: () => context.push('/archive'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/cases/new'),
        icon: const Icon(Icons.add),
        label: const Text('قيد قضية جديدة'),
      ),
      body: Column(
        children: [
          // شريط البحث الذكي (بحث باسم الموكل، نوع القضية، الخصم، رقم الأساس)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              onChanged: (val) =>
                  ref.read(caseSearchQueryProvider.notifier).state = val,
              decoration: InputDecoration(
                hintText: 'بحث باسم الموكل، نوع القضية، الخصم، أو الأساس...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () =>
                      ref.read(caseSearchQueryProvider.notifier).state = '',
                ),
              ),
            ),
          ),

          // شرائح التصفية حسب الحالة
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: statusList.map((item) {
                final isSelected = selectedStatus == item.value;
                return Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: FilterChip(
                    label: Text(item.label),
                    selected: isSelected,
                    onSelected: (_) {
                      ref.read(caseStatusFilterProvider.notifier).state =
                          isSelected ? null : item.value;
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 6),

          // قائمة القضايا المرتكزة على الموكل
          Expanded(
            child: caseItemsAsync.when(
              data: (caseItems) {
                if (caseItems.isEmpty) {
                  return AppEmptyState(
                    icon: Icons.gavel_outlined,
                    title: 'لا توجد قضايا مسجلة',
                    subtitle: 'اضغط على زر قيد قضية جديدة لإضافة موكل ودعوى',
                    actionLabel: 'قيد قضية جديدة',
                    onAction: () => context.push('/cases/new'),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
                  itemCount: caseItems.length,
                  itemBuilder: (context, index) {
                    final item = caseItems[index];
                    final c = item.caseItem;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: AppCard(
                        onTap: () => context.push('/cases/${c.id}'),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 1. السطر الأول: اسم الموكل وصفته (مدعي / مدعى عليه) والحالة
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      const Icon(Icons.person,
                                          color: Colors.blue, size: 22),
                                      const SizedBox(width: 8),
                                      Flexible(
                                        child: Text(
                                          item.clientName,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 3),
                                        decoration: BoxDecoration(
                                          color: item.clientRole == 'مدعي'
                                              ? Colors.blue.withAlpha(25)
                                              : Colors.orange.withAlpha(25),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          border: Border.all(
                                            color: item.clientRole == 'مدعي'
                                                ? Colors.blue.withAlpha(60)
                                                : Colors.orange.withAlpha(60),
                                          ),
                                        ),
                                        child: Text(
                                          item.clientRole,
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: item.clientRole == 'مدعي'
                                                ? Colors.blue.shade800
                                                : Colors.orange.shade800,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                AppStatusBadge(
                                  label: _getStatusArabic(c.status),
                                  color: _getStatusColor(c.status),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),

                            // 2. السطر الثاني: نوع الدعوى وبجانبها موعد ونوع الجلسة القادمة
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary
                                        .withAlpha(20),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    c.caseType,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                ),
                                if (item.nextHearingDate != null) ...[
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: Colors.amber.withAlpha(25),
                                        borderRadius:
                                            BorderRadius.circular(6),
                                        border: Border.all(
                                            color: Colors.amber.withAlpha(60)),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.event_seat,
                                              size: 14, color: Colors.amber),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              'الجلسة: ${AppDateFormatter.formatTimestamp(item.nextHearingDate)}${item.nextHearingType != null && item.nextHearingType!.isNotEmpty ? ' (${item.nextHearingType})' : ''}',
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.amber.shade900,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('خطأ في تحميل القضايا: $err')),
            ),
          ),
        ],
      ),
    );
  }

  String _getStatusArabic(String status) {
    switch (status) {
      case 'OPEN':
        return 'قيد النظر';
      case 'PENDING':
      case 'ON_HOLD':
        return 'معلقة';
      case 'APPEALED':
        return 'طعن';
      case 'EXECUTION':
        return 'قيد التنفيذ';
      case 'CLOSED':
      case 'ARCHIVED':
        return 'مفصولة';
      default:
        return 'قيد النظر';
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'OPEN':
        return Colors.blue;
      case 'PENDING':
      case 'ON_HOLD':
        return Colors.amber.shade800;
      case 'APPEALED':
        return Colors.purple;
      case 'EXECUTION':
        return Colors.teal;
      case 'CLOSED':
      case 'ARCHIVED':
        return Colors.blueGrey;
      default:
        return Colors.blue;
    }
  }
}
