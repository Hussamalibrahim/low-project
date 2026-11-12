import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/database_provider.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_empty_state.dart';
import '../../../cases/presentation/providers/cases_provider.dart';
import '../../../clients/presentation/providers/clients_provider.dart';
import '../../data/repositories/communications_repository.dart';

final communicationsRepositoryProvider =
    Provider<CommunicationsRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return CommunicationsRepository(db);
});

final allCommunicationsStreamProvider =
    StreamProvider<List<CommunicationWithRelations>>((ref) {
  final repo = ref.watch(communicationsRepositoryProvider);
  return repo.watchCommunications();
});

class CommunicationsScreen extends ConsumerWidget {
  const CommunicationsScreen({super.key});

  void _showAddCommunicationDialog(BuildContext context, WidgetRef ref) {
    final summaryCtrl = TextEditingController();
    final resultCtrl = TextEditingController();
    String type = 'PHONE_CALL';
    String? selectedClientId;
    String? selectedCaseId;

    final clientsAsync = ref.read(allClientsStreamProvider);
    final casesAsync = ref.read(allCasesStreamProvider);

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (dialogCtx, setDialogState) => AlertDialog(
          title: const Text('تسجيل اتصال أو مقابلة'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: type,
                  decoration: const InputDecoration(labelText: 'نوع التواصل'),
                  items: const [
                    DropdownMenuItem(
                        value: 'PHONE_CALL', child: Text('اتصال هاتفي')),
                    DropdownMenuItem(
                        value: 'OFFICE_MEETING', child: Text('مقابلة في المكتب')),
                    DropdownMenuItem(
                        value: 'COURT_MEETING', child: Text('لقاء في المحكمة')),
                    DropdownMenuItem(value: 'MESSAGE', child: Text('رسالة نصية / واتساب')),
                    DropdownMenuItem(value: 'EMAIL', child: Text('بريد إلكتروني')),
                  ],
                  onChanged: (v) => setDialogState(() => type = v!),
                ),
                const SizedBox(height: 12),
                clientsAsync.when(
                  data: (clients) => DropdownButtonFormField<String>(
                    isExpanded: true,
                    initialValue: selectedClientId,
                    decoration:
                        const InputDecoration(labelText: 'الموكل (اختياري)'),
                    items: [
                      const DropdownMenuItem(
                          value: null, child: Text('بدون تحديد موكل')),
                      ...clients.map((cl) => DropdownMenuItem(
                            value: cl.id,
                            child: Text(cl.fullName,
                                overflow: TextOverflow.ellipsis),
                          )),
                    ],
                    onChanged: (v) => setDialogState(() => selectedClientId = v),
                  ),
                  loading: () => const SizedBox(),
                  error: (_, s) => const SizedBox(),
                ),
                const SizedBox(height: 12),
                casesAsync.when(
                  data: (cases) => DropdownButtonFormField<String>(
                    isExpanded: true,
                    initialValue: selectedCaseId,
                    decoration:
                        const InputDecoration(labelText: 'القضية (اختياري)'),
                    items: [
                      const DropdownMenuItem(
                          value: null, child: Text('بدون تحديد قضية')),
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
                  loading: () => const SizedBox(),
                  error: (_, s) => const SizedBox(),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: summaryCtrl,
                  maxLines: 3,
                  style: const TextStyle(height: 1.4, fontSize: 14),
                  decoration: const InputDecoration(
                    labelText: 'موجز ما دار في المحادثة *',
                    hintText: 'تفاصيل الحديث والمطالب...',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: resultCtrl,
                  decoration: const InputDecoration(
                    labelText: 'النتيجة أو المخرجات والاتفاق',
                    hintText: 'تم الاتفاق على الحضور / تزويدنا بالأوراق...',
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
                if (summaryCtrl.text.trim().isEmpty) return;
                await ref
                    .read(communicationsRepositoryProvider)
                    .recordCommunication(
                      clientId: selectedClientId,
                      caseId: selectedCaseId,
                      communicationType: type,
                      communicationDate: DateTime.now().millisecondsSinceEpoch,
                      summary: summaryCtrl.text.trim(),
                      result: resultCtrl.text.trim(),
                    );
                if (ctx.mounted) Navigator.of(ctx).pop();
              },
              child: const Text('حفظ في السجل'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final commsAsync = ref.watch(allCommunicationsStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('سجل الاتصالات والمقابلات'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddCommunicationDialog(context, ref),
        icon: const Icon(Icons.add_call),
        label: const Text('تسجيل اتصال / مقابلة'),
      ),
      body: commsAsync.when(
        data: (comms) {
          if (comms.isEmpty) {
            return AppEmptyState(
              icon: Icons.phone_in_talk_outlined,
              title: 'لا توجد اتصالات أو مقابلات مسجلة',
              subtitle:
                  'سجل مكالماتك ومقابلاتك مع الموكلين والخصوم والخبراء ومخرجات كل لقاء',
              actionLabel: 'تسجيل اتصال جديد',
              onAction: () => _showAddCommunicationDialog(context, ref),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
            itemCount: comms.length,
            itemBuilder: (context, index) {
              final c = comms[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                _getCommIcon(c.communication.communicationType),
                                color: theme.colorScheme.primary,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _getCommTypeArabic(
                                    c.communication.communicationType),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            AppDateFormatter.formatTimestampWithTime(
                                c.communication.communicationDate),
                            style:
                                TextStyle(fontSize: 12, color: theme.hintColor),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (c.client != null) ...[
                        Text(
                          'الموكل: ${c.client!.fullName}',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 2),
                      ],
                      if (c.caseItem != null) ...[
                        Text(
                          'القضية: ${c.caseItem!.title}',
                          style: TextStyle(
                            fontSize: 12,
                            color: theme.colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(height: 4),
                      ],
                      Text(
                        c.communication.summary,
                        style: const TextStyle(fontSize: 13),
                      ),
                      if (c.communication.result != null &&
                          c.communication.result!.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.green.withAlpha(20),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'المخرجات: ${c.communication.result!}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('خطأ: $e')),
      ),
    );
  }

  IconData _getCommIcon(String type) {
    switch (type) {
      case 'PHONE_CALL':
        return Icons.phone;
      case 'OFFICE_MEETING':
        return Icons.meeting_room;
      case 'COURT_MEETING':
        return Icons.balance;
      case 'MESSAGE':
        return Icons.chat_bubble_outline;
      case 'EMAIL':
        return Icons.email_outlined;
      default:
        return Icons.phone_in_talk;
    }
  }

  String _getCommTypeArabic(String type) {
    switch (type) {
      case 'PHONE_CALL':
        return 'اتصال هاتفي';
      case 'OFFICE_MEETING':
        return 'مقابلة في المكتب';
      case 'COURT_MEETING':
        return 'لقاء في المحكمة';
      case 'MESSAGE':
        return 'رسالة نصية';
      case 'EMAIL':
        return 'بريد إلكتروني';
      default:
        return 'تواصل';
    }
  }
}
