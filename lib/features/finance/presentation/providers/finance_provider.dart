import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/database_provider.dart';
import '../../data/repositories/finance_repository.dart';

final financeRepositoryProvider = Provider<FinanceRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return FinanceRepository(db);
});

final allPaymentsStreamProvider =
    StreamProvider<List<PaymentWithRelations>>((ref) {
  final repo = ref.watch(financeRepositoryProvider);
  return repo.watchAllPayments();
});

final allExpensesStreamProvider =
    StreamProvider<List<ExpenseWithRelations>>((ref) {
  final repo = ref.watch(financeRepositoryProvider);
  return repo.watchAllExpenses();
});

final clientFinancialSummaryProvider = FutureProvider.family<
    ClientFinancialSummary,
    ({String clientId, String currency})>((ref, arg) {
  final repo = ref.watch(financeRepositoryProvider);
  return repo.getClientFinancialSummary(arg.clientId, currency: arg.currency);
});

final caseFinancialSummaryProvider = FutureProvider.family<CaseFinancialSummary,
    ({String caseId, String currency})>((ref, arg) {
  final repo = ref.watch(financeRepositoryProvider);
  return repo.getCaseFinancialSummary(arg.caseId, currency: arg.currency);
});
