import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_confirm_dialog.dart';
import '../../../finance/presentation/providers/finance_provider.dart';
import '../providers/clients_provider.dart';

class ClientDetailsScreen extends ConsumerWidget {
  final String clientId;

  const ClientDetailsScreen({super.key, required this.clientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final clientAsync = ref.watch(clientByIdProvider(clientId));
    final casesAsync = ref.watch(clientCasesStreamProvider(clientId));
    final paymentsAsync = ref.watch(clientPaymentsStreamProvider(clientId));
    final finSummaryAsync = ref.watch(
        clientFinancialSummaryProvider((clientId: clientId, currency: 'SYP')));

    return clientAsync.when(
      data: (client) {
        if (client == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('تفاصيل الموكل')),
            body: const Center(child: Text('الموكل غير موجود')),
          );
        }

        final isCompany = client.clientType == 'COMPANY';

        return Scaffold(
          appBar: AppBar(
            title: Text(client.fullName),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                tooltip: 'تعديل بيانات الموكل',
                onPressed: () => context.push('/clients/${client.id}/edit'),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                tooltip: 'أرشفة / حذف الموكل',
                onPressed: () async {
                  final ok = await AppConfirmDialog.show(
                    context,
                    title: 'حذف الموكل',
                    message:
                        'هل تريد أرشفة/حذف الموكل ${client.fullName}؟ ستبقى القضايا والمستندات المرتبطة به محفوظة.',
                    confirmLabel: 'حذف',
                    isDestructive: true,
                  );
                  if (ok) {
                    await ref
                        .read(clientsRepositoryProvider)
                        .deleteClient(client.id, client.fullName);
                    if (context.mounted) context.pop();
                  }
                },
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // بطاقة الموكل الرئيسية
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor:
                              isCompany ? Colors.orange : theme.colorScheme.primary,
                          child: Icon(
                            isCompany ? Icons.business : Icons.person,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                client.fullName,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                isCompany ? 'شركة / منشأة' : 'شخص',
                                style: TextStyle(
                                  color: theme.colorScheme.secondary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    _buildInfoRow('رقم الهاتف الأساسي', client.phone),
                    if (client.phoneSecondary != null)
                      _buildInfoRow('هاتف إضافي', client.phoneSecondary!),
                    if (client.nationalId != null)
                      _buildInfoRow('الرقم الوطني', client.nationalId!),
                    if (client.email != null)
                      _buildInfoRow('البريد الإلكتروني', client.email!),
                    if (client.companyName != null)
                      _buildInfoRow('اسم الشركة', client.companyName!),
                    if (client.commercialRecord != null)
                      _buildInfoRow('السجل التجاري', client.commercialRecord!),
                    if (client.address != null)
                      _buildInfoRow('العنوان / الإقامة', client.address!),
                    _buildInfoRow(
                      'تاريخ التسجيل',
                      AppDateFormatter.formatTimestamp(client.createdAt),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // كشف الحساب المالي
              finSummaryAsync.when(
                data: (fin) => AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('كشف الحساب المالي (ليرة سورية)',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Icon(Icons.account_balance_wallet, color: Colors.green),
                        ],
                      ),
                      const Divider(),
                      _buildInfoRow('إجمالي الأتعاب المتفق عليها',
                          CurrencyFormatter.format(fin.totalAgreed)),
                      _buildInfoRow('إجمالي المبالغ المسددة',
                          CurrencyFormatter.format(fin.totalPaid)),
                      _buildInfoRow('الرصيد المتبقي بذمة الموكل',
                          CurrencyFormatter.format(fin.balanceRemaining)),
                    ],
                  ),
                ),
                loading: () => const LinearProgressIndicator(),
                error: (e, _) => const SizedBox(),
              ),
              const SizedBox(height: 16),

              // قضايا الموكل
              Text(
                'الدعاوى والقضايا المرتبطة',
                style: theme.textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              casesAsync.when(
                data: (cases) {
                  if (cases.isEmpty) {
                    return const AppCard(
                        child: Text('لا توجد قضايا مسجلة لهذا الموكل'));
                  }
                  return Column(
                    children: cases.map((c) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: AppCard(
                          onTap: () => context.push('/cases/${c.id}'),
                          child: Row(
                            children: [
                              const Icon(Icons.gavel, color: Colors.indigo),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('أساس ${c.caseNumber} / ${c.caseYear}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text(c.title,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: theme.hintColor)),
                                  ],
                                ),
                              ),
                              const Icon(Icons.arrow_forward_ios,
                                  size: 13, color: Colors.grey),
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
              const SizedBox(height: 16),

              // سجل المقبوضات والدفعات
              Text(
                'سجل الدفعات والمقبوضات',
                style: theme.textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              paymentsAsync.when(
                data: (payments) {
                  if (payments.isEmpty) {
                    return const AppCard(child: Text('لا توجد دفعات مسجلة'));
                  }
                  return Column(
                    children: payments.map((p) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: AppCard(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    CurrencyFormatter.format(p.amount,
                                        currency: p.currency),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  ),
                                  Text(
                                    'التاريخ: ${AppDateFormatter.formatTimestamp(p.paymentDate)} • ${p.paymentMethod}',
                                    style: TextStyle(
                                        fontSize: 11, color: theme.hintColor),
                                  ),
                                ],
                              ),
                              if (p.receiptNumber != null)
                                Text('إيصال: ${p.receiptNumber!}',
                                    style: const TextStyle(fontSize: 12)),
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
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        body: Center(child: Text('خطأ: $e')),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

