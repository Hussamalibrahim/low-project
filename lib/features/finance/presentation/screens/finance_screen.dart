import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_empty_state.dart';
import '../../../cases/presentation/providers/cases_provider.dart';
import '../../../clients/presentation/providers/clients_provider.dart';
import '../providers/finance_provider.dart';

class FinanceScreen extends ConsumerStatefulWidget {
  const FinanceScreen({super.key});

  @override
  ConsumerState<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends ConsumerState<FinanceScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showRecordPaymentDialog(BuildContext context) {
    final amountCtrl = TextEditingController();
    final receiptCtrl = TextEditingController();
    final notesCtrl = TextEditingController();
    String currency = 'SYP';
    String method = 'CASH';
    String? selectedClientId;
    String? selectedCaseId;

    final clientsAsync = ref.read(allClientsStreamProvider);
    final casesAsync = ref.read(allCasesStreamProvider);

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (dialogCtx, setDialogState) => AlertDialog(
          title: const Text('تسجيل دفعة مقبوضة من موكل'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                clientsAsync.when(
                  data: (clients) => DropdownButtonFormField<String>(
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
                  loading: () => const LinearProgressIndicator(),
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
                  controller: amountCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'المبلغ المسدد *',
                    hintText: 'مثال: 500,000',
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  isExpanded: true,
                  initialValue: currency,
                  decoration: const InputDecoration(labelText: 'العملة'),
                  items: const [
                    DropdownMenuItem(value: 'SYP', child: Text('ليرة سورية (SYP)')),
                    DropdownMenuItem(value: 'USD', child: Text('دولار أمريكي (USD)')),
                    DropdownMenuItem(value: 'EUR', child: Text('يورو (EUR)')),
                  ],
                  onChanged: (v) => setDialogState(() => currency = v!),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: method,
                  decoration: const InputDecoration(labelText: 'طريقة الدفع'),
                  items: const [
                    DropdownMenuItem(value: 'CASH', child: Text('نقداً (كاش)')),
                    DropdownMenuItem(
                        value: 'BANK_TRANSFER', child: Text('حوالة بنكية')),
                    DropdownMenuItem(value: 'CHECK', child: Text('شيك')),
                  ],
                  onChanged: (v) => setDialogState(() => method = v!),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: receiptCtrl,
                  decoration: const InputDecoration(
                    labelText: 'رقم سند القبض / الإيصال',
                    hintText: 'رقم الإيصال الدفتري إن وجد',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: notesCtrl,
                  decoration: const InputDecoration(
                    labelText: 'ملاحظات',
                    hintText: 'دفعة أتعاب مرحلة أولى / مرافعة...',
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
                if (selectedClientId == null || amountCtrl.text.trim().isEmpty) {
                  return;
                }
                final amountMinor = CurrencyFormatter.parseToMinorUnits(
                  amountCtrl.text,
                  currency: currency,
                );

                await ref.read(financeRepositoryProvider).recordPayment(
                      clientId: selectedClientId!,
                      caseId: selectedCaseId,
                      amount: amountMinor,
                      currency: currency,
                      paymentDate: DateTime.now().millisecondsSinceEpoch,
                      paymentMethod: method,
                      receiptNumber: receiptCtrl.text.trim(),
                      notes: notesCtrl.text.trim(),
                    );

                if (ctx.mounted) Navigator.of(ctx).pop();
              },
              child: const Text('تسجيل الدفعة'),
            ),
          ],
        ),
      ),
    );
  }

  void _showRecordExpenseDialog(BuildContext context) {
    final amountCtrl = TextEditingController();
    final recipientCtrl = TextEditingController();
    final notesCtrl = TextEditingController();
    String category = 'COURT_FEES';
    String currency = 'SYP';
    String? selectedCaseId;

    final casesAsync = ref.read(allCasesStreamProvider);

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (dialogCtx, setDialogState) => AlertDialog(
          title: const Text('تسجيل مصروف قضائي أو مكتبي'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: category,
                  decoration: const InputDecoration(labelText: 'بند المصروف *'),
                  items: const [
                    DropdownMenuItem(
                        value: 'COURT_FEES', child: Text('رسوم قضائية وتأمينات')),
                    DropdownMenuItem(
                        value: 'EXPERTISE', child: Text('أتعاب خبراء ومعاينة')),
                    DropdownMenuItem(
                        value: 'NOTIFICATION', child: Text('أجور تبليغ وإنذارات')),
                    DropdownMenuItem(
                        value: 'TRANSPORT', child: Text('انتقال ومواصلات')),
                    DropdownMenuItem(
                        value: 'OFFICE', child: Text('مصاريف مكتبية ومطبوعات')),
                    DropdownMenuItem(value: 'OTHER', child: Text('أخرى')),
                  ],
                  onChanged: (v) => setDialogState(() => category = v!),
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
                          value: null, child: Text('بدون قضية (مصروف مكتبي عام)')),
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
                  controller: amountCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'مبلغ المصروف *',
                    hintText: 'مثال: 75,000',
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  isExpanded: true,
                  initialValue: currency,
                  decoration: const InputDecoration(labelText: 'العملة'),
                  items: const [
                    DropdownMenuItem(value: 'SYP', child: Text('ليرة سورية (SYP)')),
                    DropdownMenuItem(value: 'USD', child: Text('دولار أمريكي (USD)')),
                    DropdownMenuItem(value: 'EUR', child: Text('يورو (EUR)')),
                  ],
                  onChanged: (v) => setDialogState(() => currency = v!),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: recipientCtrl,
                  decoration: const InputDecoration(
                    labelText: 'الجهة أو الشخص المستلم',
                    hintText: 'صندوق المحكمة / الخبير / المباشر القضائي',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: notesCtrl,
                  decoration: const InputDecoration(
                    labelText: 'بيان وتفاصيل المصروف',
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
                if (amountCtrl.text.trim().isEmpty) return;
                final amountMinor = CurrencyFormatter.parseToMinorUnits(
                  amountCtrl.text,
                  currency: currency,
                );

                await ref.read(financeRepositoryProvider).recordExpense(
                      caseId: selectedCaseId,
                      category: category,
                      amount: amountMinor,
                      currency: currency,
                      expenseDate: DateTime.now().millisecondsSinceEpoch,
                      recipient: recipientCtrl.text.trim(),
                      notes: notesCtrl.text.trim(),
                    );

                if (ctx.mounted) Navigator.of(ctx).pop();
              },
              child: const Text('تسجيل المصروف'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final paymentsAsync = ref.watch(allPaymentsStreamProvider);
    final expensesAsync = ref.watch(allExpensesStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('المالية والحسابات'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'المقبوضات والدفعات'),
            Tab(text: 'المصاريف القضائية'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_tabController.index == 0) {
            _showRecordPaymentDialog(context);
          } else {
            _showRecordExpenseDialog(context);
          }
        },
        icon: const Icon(Icons.add),
        label: Text(_tabController.index == 0 ? 'قبض دفعة' : 'تسجيل مصروف'),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // 1. المقبوضات
          paymentsAsync.when(
            data: (payments) {
              if (payments.isEmpty) {
                return AppEmptyState(
                  icon: Icons.account_balance_wallet_outlined,
                  title: 'لا توجد دفعات مقبوضة مسجلة',
                  subtitle: 'اضغط على زر قبض دفعة لتسجيل أتعاب أو دفعات موكل',
                  actionLabel: 'قبض دفعة جديدة',
                  onAction: () => _showRecordPaymentDialog(context),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
                itemCount: payments.length,
                itemBuilder: (context, index) {
                  final p = payments[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: AppCard(
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.green.withAlpha(25),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.arrow_downward,
                                color: Colors.green),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      p.client.fullName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      CurrencyFormatter.format(p.payment.amount,
                                          currency: p.payment.currency),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(
                                      'التاريخ: ${AppDateFormatter.formatTimestamp(p.payment.paymentDate)} • ${p.payment.paymentMethod}',
                                      style: TextStyle(
                                          fontSize: 12, color: theme.hintColor),
                                    ),
                                    if (p.payment.receiptNumber != null) ...[
                                      const SizedBox(width: 8),
                                      Text(
                                        'سند: ${p.payment.receiptNumber!}',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: theme.colorScheme.primary),
                                      ),
                                    ],
                                  ],
                                ),
                                if (p.caseItem != null) ...[
                                  const SizedBox(height: 2),
                                  Text(
                                    'القضية: أساس ${p.caseItem!.caseNumber} - ${p.caseItem!.title}',
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: theme.colorScheme.secondary),
                                  ),
                                ],
                              ],
                            ),
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

          // 2. المصاريف
          expensesAsync.when(
            data: (expenses) {
              if (expenses.isEmpty) {
                return AppEmptyState(
                  icon: Icons.receipt_long_outlined,
                  title: 'لا توجد مصاريف مسجلة',
                  subtitle: 'سجل المصاريف القضائية ورسوم المحاكم وأجور التبليغ',
                  actionLabel: 'تسجيل مصروف جديد',
                  onAction: () => _showRecordExpenseDialog(context),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  final e = expenses[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: AppCard(
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.red.withAlpha(25),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.arrow_upward,
                                color: Colors.red),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _getExpenseCategoryArabic(
                                          e.expense.category),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      CurrencyFormatter.format(e.expense.amount,
                                          currency: e.expense.currency),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'التاريخ: ${AppDateFormatter.formatTimestamp(e.expense.expenseDate)}${e.expense.recipient != null ? " • المستلم: ${e.expense.recipient!}" : ""}',
                                  style: TextStyle(
                                      fontSize: 12, color: theme.hintColor),
                                ),
                                if (e.caseItem != null) ...[
                                  const SizedBox(height: 2),
                                  Text(
                                    'القضية: أساس ${e.caseItem!.caseNumber} - ${e.caseItem!.title}',
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: theme.colorScheme.secondary),
                                  ),
                                ],
                              ],
                            ),
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
        ],
      ),
    );
  }

  String _getExpenseCategoryArabic(String cat) {
    switch (cat) {
      case 'COURT_FEES':
        return 'رسوم قضائية وتأمينات';
      case 'EXPERTISE':
        return 'أتعاب خبراء ومعاينة';
      case 'NOTIFICATION':
        return 'أجور تبليغ وإنذار';
      case 'TRANSPORT':
        return 'انتقال ومواصلات';
      case 'OFFICE':
        return 'مصاريف مكتبية';
      default:
        return 'مصروف آخر';
    }
  }
}
