import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../cases/presentation/providers/cases_provider.dart';
import '../../../finance/data/repositories/finance_repository.dart';
import '../../../finance/presentation/providers/finance_provider.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  Future<void> _exportCasesToCsv(BuildContext context, WidgetRef ref) async {
    final cases = await ref.read(casesRepositoryProvider).watchAllCases().first;
    final rows = <List<dynamic>>[
      ['رقم الأساس', 'السنة', 'موضوع الدعوى', 'نوع الدعوى', 'الحالة', 'المرحلة', 'المبلغ المدعى به', 'العملة']
    ];

    for (final c in cases) {
      rows.add([
        c.caseNumber,
        c.caseYear,
        c.title,
        c.caseType,
        c.status,
        c.stage,
        c.claimAmount ?? 0,
        c.currency,
      ]);
    }

    final csvString = const ListToCsvConverter().convert(rows);
    final tempDir = await getTemporaryDirectory();
    final file = File(p.join(tempDir.path, 'تقرير_القضايا_${DateTime.now().millisecondsSinceEpoch}.csv'));
    await file.writeAsString(csvString);

    await Share.shareXFiles([XFile(file.path)], text: 'تقرير قضايا مكتب المحاماة');
  }

  Future<void> _exportFinanceToCsv(BuildContext context, WidgetRef ref) async {
    final payments = await ref.read(financeRepositoryProvider).watchAllPayments().first;
    final rows = <List<dynamic>>[
      ['اسم الموكل', 'المبلغ', 'العملة', 'تاريخ الدفعة', 'طريقة الدفع', 'رقم الإيصال']
    ];

    for (final pItem in payments) {
      rows.add([
        pItem.client.fullName,
        pItem.payment.amount,
        pItem.payment.currency,
        AppDateFormatter.formatTimestamp(pItem.payment.paymentDate),
        pItem.payment.paymentMethod,
        pItem.payment.receiptNumber ?? '-',
      ]);
    }

    final csvString = const ListToCsvConverter().convert(rows);
    final tempDir = await getTemporaryDirectory();
    final file = File(p.join(tempDir.path, 'تقرير_المقبوضات_${DateTime.now().millisecondsSinceEpoch}.csv'));
    await file.writeAsString(csvString);

    await Share.shareXFiles([XFile(file.path)], text: 'تقرير المقبوضات المالية');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final casesAsync = ref.watch(allCasesStreamProvider);
    final paymentsAsync = ref.watch(allPaymentsStreamProvider);
    final expensesAsync = ref.watch(allExpensesStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('التقارير والإحصاءات'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // تصدير التقارير
          Text(
            'تصدير السجلات والتقارير',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _exportCasesToCsv(context, ref),
                  icon: const Icon(Icons.table_chart_outlined, color: Colors.green),
                  label: const Text('تصدير القضايا (CSV)'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _exportFinanceToCsv(context, ref),
                  icon: const Icon(Icons.file_download_outlined, color: Colors.teal),
                  label: const Text('تصدير المالية (CSV)'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // إحصائيات القضايا
          Text(
            'توزيع القضايا حسب الحالة',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          casesAsync.when(
            data: (cases) {
              final Map<String, int> counts = {};
              for (final c in cases) {
                counts[c.status] = (counts[c.status] ?? 0) + 1;
              }

              return AppCard(
                child: Column(
                  children: counts.entries.map((e) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(e.key, style: const TextStyle(fontWeight: FontWeight.w600)),
                          Text('${e.value} قضية', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              );
            },
            loading: () => const LinearProgressIndicator(),
            error: (e, _) => Text('خطأ: $e'),
          ),
          const SizedBox(height: 24),

          // الأداء المالي
          Text(
            'ملخص التدفقات المالية',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          paymentsAsync.when(
            data: (payments) {
              return expensesAsync.when(
                data: (expenses) {
                  final int totalIn = payments.fold<int>(0, (int s, PaymentWithRelations p) => s + p.payment.amount);
                  final int totalOut = expenses.fold<int>(0, (int s, ExpenseWithRelations e) => s + e.expense.amount);
                  final int net = totalIn - totalOut;

                  return AppCard(
                    child: Column(
                      children: [
                        _buildRow('إجمالي المقبوضات المسجلة', CurrencyFormatter.format(totalIn), Colors.green),
                        const Divider(),
                        _buildRow('إجمالي المصاريف القضائية', CurrencyFormatter.format(totalOut), Colors.red),
                        const Divider(),
                        _buildRow('صافي الدخل التقديري', CurrencyFormatter.format(net), net >= 0 ? Colors.blue : Colors.red),
                      ],
                    ),
                  );
                },
                loading: () => const SizedBox(),
                error: (_, s) => const SizedBox(),
              );
            },
            loading: () => const LinearProgressIndicator(),
            error: (e, _) => Text('خطأ: $e'),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }
}
