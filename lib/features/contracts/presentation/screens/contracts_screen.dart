import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/database_provider.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_empty_state.dart';
import '../../../../shared/widgets/app_status_badge.dart';
import '../../../clients/presentation/providers/clients_provider.dart';
import '../../data/repositories/contracts_repository.dart';

final contractsRepositoryProvider = Provider<ContractsRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return ContractsRepository(db);
});

final allContractsStreamProvider =
    StreamProvider<List<ContractWithRelations>>((ref) {
  final repo = ref.watch(contractsRepositoryProvider);
  return repo.watchAllContracts();
});

class ContractsScreen extends ConsumerWidget {
  const ContractsScreen({super.key});

  void _showAddContractDialog(BuildContext context, WidgetRef ref) {
    final numCtrl = TextEditingController();
    final authorityCtrl = TextEditingController(text: 'كاتب العدل بدمشق');
    final notesCtrl = TextEditingController();
    String type = 'SPECIAL_POA';
    String? selectedClientId;
    DateTime issueDate = DateTime.now();
    DateTime? expiryDate;

    final clientsAsync = ref.read(allClientsStreamProvider);

    clientsAsync.whenData((clients) {
      if (clients.isNotEmpty) selectedClientId = clients.first.id;

      showDialog(
        context: context,
        builder: (ctx) => StatefulBuilder(
          builder: (dialogCtx, setDialogState) => AlertDialog(
            title: const Text('توثيق سند توكيل أو عقد'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    initialValue: selectedClientId,
                    decoration: const InputDecoration(labelText: 'الموكل *'),
                    items: clients
                        .map((cl) => DropdownMenuItem(
                              value: cl.id,
                              child: Text(cl.fullName),
                            ))
                        .toList(),
                    onChanged: (v) => setDialogState(() => selectedClientId = v),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: type,
                    decoration: const InputDecoration(labelText: 'نوع السند / العقد'),
                    items: const [
                      DropdownMenuItem(
                          value: 'SPECIAL_POA', child: Text('سند توكيل خاص بالدعوى')),
                      DropdownMenuItem(
                          value: 'GENERAL_POA', child: Text('سند توكيل عام قضائي')),
                      DropdownMenuItem(
                          value: 'LEGAL_SERVICES', child: Text('عقد تقديم خدمات قانونية')),
                      DropdownMenuItem(
                          value: 'SETTLEMENT', child: Text('عقد صلح وتسوية')),
                    ],
                    onChanged: (v) => setDialogState(() => type = v!),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: numCtrl,
                    decoration: const InputDecoration(
                      labelText: 'رقم السند أو التوثيق *',
                      hintText: 'رقم السجل / التوثيق العدلي',
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: authorityCtrl,
                    decoration: const InputDecoration(
                      labelText: 'جهة الإصدار / التوثيق',
                      hintText: 'كاتب العدل بدمشق / نقابة المحامين',
                    ),
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    title: const Text('تاريخ الإصدار / التوكيل'),
                    subtitle: Text(AppDateFormatter.formatDate(issueDate)),
                    trailing: const Icon(Icons.event),
                    onTap: () async {
                      final d = await showDatePicker(
                        context: dialogCtx,
                        initialDate: issueDate,
                        firstDate: DateTime(1990),
                        lastDate: DateTime(2035),
                      );
                      if (d != null) {
                        setDialogState(() => issueDate = d);
                      }
                    },
                  ),
                  ListTile(
                    title: const Text('تاريخ الانتهاء'),
                    subtitle: Text(expiryDate != null
                        ? AppDateFormatter.formatDate(expiryDate!)
                        : 'غير محدد (ساري المفعول)'),
                    trailing: const Icon(Icons.event_available),
                    onTap: () async {
                      final d = await showDatePicker(
                        context: dialogCtx,
                        initialDate: DateTime.now().add(const Duration(days: 365)),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2040),
                      );
                      if (d != null) {
                        setDialogState(() => expiryDate = d);
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: notesCtrl,
                    decoration: const InputDecoration(
                      labelText: 'ملاحظات إضافية',
                      hintText: 'أي تفاصيل خاصة بالسند...',
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
                  if (selectedClientId == null || numCtrl.text.trim().isEmpty) {
                    return;
                  }
                  await ref.read(contractsRepositoryProvider).createContract(
                        clientId: selectedClientId!,
                        documentNumber: numCtrl.text.trim(),
                        contractType: type,
                        issuingAuthority: authorityCtrl.text.trim(),
                        issueDate: issueDate.millisecondsSinceEpoch,
                        expiryDate: expiryDate?.millisecondsSinceEpoch,
                        notes: notesCtrl.text.trim().isEmpty ? null : notesCtrl.text.trim(),
                      );
                  if (ctx.mounted) Navigator.of(ctx).pop();
                },
                child: const Text('حفظ السند'),
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final contractsAsync = ref.watch(allContractsStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('سندات التوكيل والعقود'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddContractDialog(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('توثيق سند جديد'),
      ),
      body: contractsAsync.when(
        data: (contracts) {
          if (contracts.isEmpty) {
            return AppEmptyState(
              icon: Icons.assignment_outlined,
              title: 'لا توجد سندات توكيل أو عقود مسجلة',
              subtitle: 'سجل وكالات المحامين العامة والخاصة لسهولة مراجعتها وإدارتها',
              actionLabel: 'توثيق سند جديد',
              onAction: () => _showAddContractDialog(context, ref),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
            itemCount: contracts.length,
            itemBuilder: (context, index) {
              final item = contracts[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _getContractTypeArabic(item.contract.contractType),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          AppStatusBadge(
                            label: item.contract.status == 'ACTIVE'
                                ? 'ساري المفعول'
                                : 'منتهي',
                            color: item.contract.status == 'ACTIVE'
                                ? Colors.green
                                : Colors.red,
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'الموكل: ${item.client.fullName}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            'رقم التوثيق: ${item.contract.documentNumber}',
                            style: TextStyle(
                              fontSize: 12,
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (item.contract.issuingAuthority != null) ...[
                            const SizedBox(width: 8),
                            Text(
                              '• ${item.contract.issuingAuthority!}',
                              style: TextStyle(
                                  fontSize: 12, color: theme.hintColor),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'تاريخ التوثيق: ${AppDateFormatter.formatTimestamp(item.contract.issueDate)}',
                        style: TextStyle(fontSize: 12, color: theme.hintColor),
                      ),
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

  String _getContractTypeArabic(String type) {
    switch (type) {
      case 'SPECIAL_POA':
        return 'سند توكيل خاص بالدعوى';
      case 'GENERAL_POA':
        return 'سند توكيل عام قضائي';
      case 'LEGAL_SERVICES':
        return 'عقد تقديم خدمات قانونية';
      case 'SETTLEMENT':
        return 'عقد صلح وتسوية';
      default:
        return 'عقد / سند';
    }
  }
}
