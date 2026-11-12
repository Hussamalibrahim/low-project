import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/database/app_database.dart';

class ClientFinancialSummary {
  final int totalAgreed;
  final int totalPaid;
  final int balanceRemaining;
  final String currency;

  ClientFinancialSummary({
    required this.totalAgreed,
    required this.totalPaid,
    required this.balanceRemaining,
    required this.currency,
  });
}

class CaseFinancialSummary {
  final int totalAgreed;
  final int totalPaid;
  final int totalExpenses;
  final int balanceRemaining;
  final String currency;

  CaseFinancialSummary({
    required this.totalAgreed,
    required this.totalPaid,
    required this.totalExpenses,
    required this.balanceRemaining,
    required this.currency,
  });
}

class PaymentWithRelations {
  final Payment payment;
  final Client client;
  final Case? caseItem;

  PaymentWithRelations({
    required this.payment,
    required this.client,
    this.caseItem,
  });
}

class ExpenseWithRelations {
  final Expense expense;
  final Case? caseItem;
  final Document? document;

  ExpenseWithRelations({
    required this.expense,
    this.caseItem,
    this.document,
  });
}

class FinanceRepository {
  final AppDatabase _db;

  FinanceRepository(this._db);

  // --- 1. اتفاقيات الأتعاب (Fee Agreements) ---

  Stream<List<FeeAgreement>> watchClientFeeAgreements(String clientId) {
    return (_db.select(_db.feeAgreements)
          ..where((tbl) =>
              tbl.clientId.equals(clientId) & tbl.deletedAt.isNull())
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.agreementDate)]))
        .watch();
  }

  Future<String> createFeeAgreement({
    required String clientId,
    String? caseId,
    required int agreedAmount,
    String currency = 'SYP',
    required String agreementType,
    required int agreementDate,
    String? notes,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final id = const Uuid().v4();

    await _db.into(_db.feeAgreements).insert(
          FeeAgreementsCompanion.insert(
            id: id,
            clientId: clientId,
            caseId: Value(caseId),
            agreedAmount: agreedAmount,
            currency: Value(currency),
            agreementType: agreementType,
            agreementDate: agreementDate,
            notes: Value(notes?.trim()),
            createdAt: now,
          ),
        );

    // تسجيل التدقيق
    await _db.into(_db.auditLogs).insert(
          AuditLogsCompanion.insert(
            id: const Uuid().v4(),
            timestamp: now,
            action: 'CREATE',
            entityType: 'FINANCE',
            entityId: Value(id),
            details: 'تسجيل اتفاقية أتعاب جديدة بقيمة $agreedAmount $currency',
          ),
        );

    return id;
  }

  // --- 2. الدفعات والمقبوضات (Payments) ---

  Stream<List<PaymentWithRelations>> watchAllPayments() {
    final query = _db.select(_db.payments).join([
      innerJoin(_db.clients, _db.clients.id.equalsExp(_db.payments.clientId)),
      leftOuterJoin(_db.cases, _db.cases.id.equalsExp(_db.payments.caseId)),
    ])..where(_db.payments.deletedAt.isNull());

    query.orderBy([OrderingTerm.desc(_db.payments.paymentDate)]);

    return query.watch().map((rows) {
      return rows.map((r) {
        return PaymentWithRelations(
          payment: r.readTable(_db.payments),
          client: r.readTable(_db.clients),
          caseItem: r.readTableOrNull(_db.cases),
        );
      }).toList();
    });
  }

  Future<String> recordPayment({
    String? feeAgreementId,
    required String clientId,
    String? caseId,
    required int amount,
    String currency = 'SYP',
    required int paymentDate,
    required String paymentMethod,
    String? receiptNumber,
    String? notes,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final id = const Uuid().v4();

    await _db.into(_db.payments).insert(
          PaymentsCompanion.insert(
            id: id,
            feeAgreementId: Value(feeAgreementId),
            clientId: clientId,
            caseId: Value(caseId),
            amount: amount,
            currency: Value(currency),
            paymentDate: paymentDate,
            paymentMethod: paymentMethod,
            receiptNumber: Value(receiptNumber?.trim()),
            notes: Value(notes?.trim()),
            createdAt: now,
          ),
        );

    // تسجيل التدقيق
    await _db.into(_db.auditLogs).insert(
          AuditLogsCompanion.insert(
            id: const Uuid().v4(),
            timestamp: now,
            action: 'CREATE',
            entityType: 'FINANCE',
            entityId: Value(id),
            details: 'تسجيل دفعة مقبوضة بقيمة $amount $currency (سند قبض: ${receiptNumber ?? '-'})',
          ),
        );

    return id;
  }

  // --- 3. المصاريف القضائية والمكتبية (Expenses) ---

  Stream<List<ExpenseWithRelations>> watchAllExpenses() {
    final query = _db.select(_db.expenses).join([
      leftOuterJoin(_db.cases, _db.cases.id.equalsExp(_db.expenses.caseId)),
      leftOuterJoin(
          _db.documents, _db.documents.id.equalsExp(_db.expenses.documentId)),
    ])..where(_db.expenses.deletedAt.isNull());

    query.orderBy([OrderingTerm.desc(_db.expenses.expenseDate)]);

    return query.watch().map((rows) {
      return rows.map((r) {
        return ExpenseWithRelations(
          expense: r.readTable(_db.expenses),
          caseItem: r.readTableOrNull(_db.cases),
          document: r.readTableOrNull(_db.documents),
        );
      }).toList();
    });
  }

  Future<String> recordExpense({
    String? caseId,
    required String category,
    required int amount,
    String currency = 'SYP',
    required int expenseDate,
    String? recipient,
    String? documentId,
    String? notes,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final id = const Uuid().v4();

    await _db.into(_db.expenses).insert(
          ExpensesCompanion.insert(
            id: id,
            caseId: Value(caseId),
            category: category,
            amount: amount,
            currency: Value(currency),
            expenseDate: expenseDate,
            recipient: Value(recipient?.trim()),
            documentId: Value(documentId),
            notes: Value(notes?.trim()),
            createdAt: now,
          ),
        );

    // تسجيل التدقيق
    await _db.into(_db.auditLogs).insert(
          AuditLogsCompanion.insert(
            id: const Uuid().v4(),
            timestamp: now,
            action: 'CREATE',
            entityType: 'FINANCE',
            entityId: Value(id),
            details: 'تسجيل مصروف بقيمة $amount $currency ($category)',
          ),
        );

    return id;
  }

  // --- 4. الملخصات والأرصدة (Summaries & Balances) ---

  Future<ClientFinancialSummary> getClientFinancialSummary(String clientId,
      {String currency = 'SYP'}) async {
    // مجموع الاتفاقيات
    final agreements = await (_db.select(_db.feeAgreements)
          ..where((tbl) =>
              tbl.clientId.equals(clientId) &
              tbl.currency.equals(currency) &
              tbl.deletedAt.isNull()))
        .get();

    final totalAgreed =
        agreements.fold<int>(0, (sum, a) => sum + a.agreedAmount);

    // مجموع الدفعات
    final payments = await (_db.select(_db.payments)
          ..where((tbl) =>
              tbl.clientId.equals(clientId) &
              tbl.currency.equals(currency) &
              tbl.deletedAt.isNull()))
        .get();

    final totalPaid = payments.fold<int>(0, (sum, p) => sum + p.amount);

    return ClientFinancialSummary(
      totalAgreed: totalAgreed,
      totalPaid: totalPaid,
      balanceRemaining: totalAgreed - totalPaid,
      currency: currency,
    );
  }

  Future<CaseFinancialSummary> getCaseFinancialSummary(String caseId,
      {String currency = 'SYP'}) async {
    final agreements = await (_db.select(_db.feeAgreements)
          ..where((tbl) =>
              tbl.caseId.equals(caseId) &
              tbl.currency.equals(currency) &
              tbl.deletedAt.isNull()))
        .get();
    final totalAgreed =
        agreements.fold<int>(0, (sum, a) => sum + a.agreedAmount);

    final payments = await (_db.select(_db.payments)
          ..where((tbl) =>
              tbl.caseId.equals(caseId) &
              tbl.currency.equals(currency) &
              tbl.deletedAt.isNull()))
        .get();
    final totalPaid = payments.fold<int>(0, (sum, p) => sum + p.amount);

    final expenses = await (_db.select(_db.expenses)
          ..where((tbl) =>
              tbl.caseId.equals(caseId) &
              tbl.currency.equals(currency) &
              tbl.deletedAt.isNull()))
        .get();
    final totalExpenses = expenses.fold<int>(0, (sum, e) => sum + e.amount);

    return CaseFinancialSummary(
      totalAgreed: totalAgreed,
      totalPaid: totalPaid,
      totalExpenses: totalExpenses,
      balanceRemaining: totalAgreed - totalPaid,
      currency: currency,
    );
  }
}

