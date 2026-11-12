import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_empty_state.dart';
import '../../../../shared/widgets/app_status_badge.dart';
import '../../../cases/presentation/providers/cases_provider.dart';
import '../../../clients/presentation/providers/clients_provider.dart';
import '../../data/repositories/tasks_repository.dart';
import '../providers/tasks_provider.dart';

class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  void _showAddTaskDialog(BuildContext context, WidgetRef ref) {
    final titleCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    DateTime dueDate = DateTime.now().add(const Duration(days: 2));
    String priority = 'MEDIUM';
    String? selectedCaseId;

    final casesAsync = ref.read(allCasesStreamProvider);

    casesAsync.whenData((cases) {
      showDialog(
        context: context,
        builder: (ctx) => StatefulBuilder(
          builder: (dialogCtx, setDialogState) => AlertDialog(
            title: const Text('إضافة مهمة جديدة'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleCtrl,
                    decoration: const InputDecoration(
                      labelText: 'عنوان المهمة *',
                      hintText: 'مثال: إيداع مذكرة / دفع رسم / استخراج صورة طبق الأصل',
                    ),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: priority,
                    decoration: const InputDecoration(labelText: 'الأولوية'),
                    items: const [
                      DropdownMenuItem(value: 'LOW', child: Text('منخفضة')),
                      DropdownMenuItem(value: 'MEDIUM', child: Text('متوسطة')),
                      DropdownMenuItem(value: 'HIGH', child: Text('عالية')),
                      DropdownMenuItem(value: 'URGENT', child: Text('عاجلة جداً')),
                    ],
                    onChanged: (v) => setDialogState(() => priority = v!),
                  ),
                  const SizedBox(height: 12),
                  if (cases.isNotEmpty)
                    DropdownButtonFormField<String>(
                      initialValue: selectedCaseId,
                      decoration: const InputDecoration(labelText: 'ربط بقضية (اختياري)'),
                      items: [
                        const DropdownMenuItem(
                            value: null, child: Text('بدون قضية')),
                        ...cases.map((c) => DropdownMenuItem(
                              value: c.id,
                              child: Text(
                                'أساس ${c.caseNumber} - ${c.title}',
                                overflow: TextOverflow.ellipsis,
                              ),
                            )),
                      ],
                      onChanged: (v) => setDialogState(() => selectedCaseId = v),
                    ),
                  const SizedBox(height: 12),
                  ListTile(
                    title: const Text('تاريخ الاستحقاق'),
                    subtitle: Text(AppDateFormatter.formatDateTime(dueDate)),
                    trailing: const Icon(Icons.event),
                    onTap: () async {
                      final d = await showDatePicker(
                        context: dialogCtx,
                        initialDate: dueDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2035),
                      );
                      if (d != null) {
                        setDialogState(() => dueDate = d);
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: descCtrl,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      labelText: 'تفاصيل إضافية',
                      hintText: 'ملاحظات وتفاصيل لتنفيذ المهمة...',
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('إلغاء'),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (titleCtrl.text.trim().isEmpty) return;
                  await ref.read(tasksRepositoryProvider).createTask(
                        title: titleCtrl.text.trim(),
                        description: descCtrl.text.trim(),
                        caseId: selectedCaseId,
                        priority: priority,
                        dueDate: dueDate.millisecondsSinceEpoch,
                      );
                  if (ctx.mounted) Navigator.of(ctx).pop();
                },
                child: const Text('إضافة المهمة'),
              ),
            ],
          ),
        ),
      );
    });
  }

  void _showEditTaskDialog(
      BuildContext context, WidgetRef ref, TaskWithRelations t) {
    final titleCtrl = TextEditingController(text: t.task.title);
    final descCtrl = TextEditingController(text: t.task.description ?? '');
    DateTime dueDate = DateTime.fromMillisecondsSinceEpoch(t.task.dueDate);
    String priority = t.task.priority;
    String? selectedCaseId = t.task.caseId;
    String? selectedClientId = t.task.clientId;

    final cases = ref.read(allCasesStreamProvider).value ?? [];
    final clients = ref.read(allClientsStreamProvider).value ?? [];

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (dialogCtx, setDialogState) => AlertDialog(
          title: const Text('تعديل المهمة القضائية'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: titleCtrl,
                  decoration: const InputDecoration(
                    labelText: 'عنوان المهمة *',
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: priority,
                  decoration: const InputDecoration(labelText: 'الأولوية'),
                  items: const [
                    DropdownMenuItem(value: 'LOW', child: Text('منخفضة')),
                    DropdownMenuItem(value: 'MEDIUM', child: Text('متوسطة')),
                    DropdownMenuItem(value: 'HIGH', child: Text('عالية')),
                    DropdownMenuItem(
                        value: 'URGENT', child: Text('عاجلة جداً')),
                  ],
                  onChanged: (v) => setDialogState(() => priority = v!),
                ),
                const SizedBox(height: 12),
                if (clients.isNotEmpty)
                  DropdownButtonFormField<String?>(
                    value: selectedClientId,
                    decoration:
                        const InputDecoration(labelText: 'ربط بموكل (اختياري)'),
                    items: [
                      const DropdownMenuItem(
                          value: null, child: Text('بدون موكل')),
                      ...clients.map((c) => DropdownMenuItem(
                            value: c.id,
                            child: Text(
                              c.fullName,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )),
                    ],
                    onChanged: (v) =>
                        setDialogState(() => selectedClientId = v),
                  ),
                const SizedBox(height: 12),
                if (cases.isNotEmpty)
                  DropdownButtonFormField<String?>(
                    value: selectedCaseId,
                    decoration:
                        const InputDecoration(labelText: 'ربط بقضية (اختياري)'),
                    items: [
                      const DropdownMenuItem(
                          value: null, child: Text('بدون قضية')),
                      ...cases.map((c) => DropdownMenuItem(
                            value: c.id,
                            child: Text(
                              c.title,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )),
                    ],
                    onChanged: (v) => setDialogState(() => selectedCaseId = v),
                  ),
                const SizedBox(height: 12),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('تاريخ الاستحقاق'),
                  subtitle: Text(AppDateFormatter.formatDate(dueDate)),
                  trailing: const Icon(Icons.event),
                  onTap: () async {
                    final d = await showDatePicker(
                      context: dialogCtx,
                      initialDate: dueDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2035),
                    );
                    if (d != null) {
                      setDialogState(() => dueDate = d);
                    }
                  },
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: descCtrl,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'ملاحظات وتفاصيل',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (titleCtrl.text.trim().isEmpty) return;
                await ref.read(tasksRepositoryProvider).updateTask(
                      id: t.task.id,
                      title: titleCtrl.text.trim(),
                      description: descCtrl.text.trim(),
                      caseId: selectedCaseId,
                      clientId: selectedClientId,
                      dueDate: dueDate.millisecondsSinceEpoch,
                      priority: priority,
                    );
                if (ctx.mounted) Navigator.of(ctx).pop();
              },
              child: const Text('حفظ التعديلات'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final tasksAsync = ref.watch(allTasksStreamProvider);
    final selectedStatus = ref.watch(taskStatusFilterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('المهام والمهل القانونية'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddTaskDialog(context, ref),
        icon: const Icon(Icons.add_task),
        label: const Text('إضافة مهمة'),
      ),
      body: Column(
        children: [
          // شريط التصفية
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                FilterChip(
                  label: const Text('الكل'),
                  selected: selectedStatus == null,
                  onSelected: (_) =>
                      ref.read(taskStatusFilterProvider.notifier).state = null,
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text('قيد الانتظار'),
                  selected: selectedStatus == 'PENDING',
                  onSelected: (_) => ref
                      .read(taskStatusFilterProvider.notifier)
                      .state = 'PENDING',
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text('المكتملة'),
                  selected: selectedStatus == 'COMPLETED',
                  onSelected: (_) => ref
                      .read(taskStatusFilterProvider.notifier)
                      .state = 'COMPLETED',
                ),
              ],
            ),
          ),
          Expanded(
            child: tasksAsync.when(
              data: (tasks) {
                if (tasks.isEmpty) {
                  return AppEmptyState(
                    icon: Icons.task_outlined,
                    title: 'لا توجد مهام مسجلة',
                    subtitle: 'اضغط على زر إضافة مهمة لجدولة مهامك القضائية والمكتبية',
                    actionLabel: 'إضافة مهمة جديدة',
                    onAction: () => _showAddTaskDialog(context, ref),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 80),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final t = tasks[index];
                    final isCompleted = t.task.status == 'COMPLETED';
                    final isOverdue = !isCompleted &&
                        t.task.dueDate < DateTime.now().millisecondsSinceEpoch;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: AppCard(
                        onTap: () => _showEditTaskDialog(context, ref, t),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: isCompleted,
                              onChanged: (val) {
                                ref.read(tasksRepositoryProvider).updateTaskStatus(
                                      t.task.id,
                                      (val ?? false) ? 'COMPLETED' : 'PENDING',
                                    );
                              },
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          t.task.title,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            decoration: isCompleted
                                                ? TextDecoration.lineThrough
                                                : null,
                                            color: isCompleted
                                                ? theme.hintColor
                                                : null,
                                          ),
                                        ),
                                      ),
                                      AppStatusBadge(
                                        label: _getPriorityLabel(t.task.priority),
                                        color: _getPriorityColor(t.task.priority),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  if (t.caseItem != null) ...[
                                    Text(
                                      'قضية: ${t.caseItem!.title}',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: theme.colorScheme.primary),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 2),
                                  ],
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today,
                                        size: 12,
                                        color: isOverdue
                                            ? Colors.red
                                            : theme.hintColor,
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          isOverdue
                                              ? 'الاستحقاق: ${AppDateFormatter.formatTimestamp(t.task.dueDate)} (متأخرة)'
                                              : 'الاستحقاق: ${AppDateFormatter.formatTimestamp(t.task.dueDate)}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: isOverdue
                                                ? Colors.red
                                                : theme.hintColor,
                                            fontWeight: isOverdue
                                                ? FontWeight.bold
                                                : null,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit_outlined,
                                  size: 18, color: Colors.blue),
                              tooltip: 'تعديل المهمة',
                              onPressed: () =>
                                  _showEditTaskDialog(context, ref, t),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline,
                                  size: 18, color: Colors.grey),
                              tooltip: 'حذف',
                              onPressed: () {
                                ref
                                    .read(tasksRepositoryProvider)
                                    .deleteTask(t.task.id);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('خطأ: $e')),
            ),
          ),
        ],
      ),
    );
  }

  String _getPriorityLabel(String priority) {
    switch (priority) {
      case 'URGENT':
        return 'عاجلة جداً';
      case 'HIGH':
        return 'عالية';
      case 'MEDIUM':
        return 'متوسطة';
      case 'LOW':
        return 'منخفضة';
      default:
        return priority;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'URGENT':
        return Colors.red;
      case 'HIGH':
        return Colors.deepOrange;
      case 'MEDIUM':
        return Colors.amber.shade800;
      case 'LOW':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
