import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  Clients,
  Courts,
  Contacts,
  Cases,
  CaseClients,
  CaseParties,
  FolderLinks,
  Documents,
  CaseDocuments,
  DocumentTextIndex,
  Hearings,
  CaseProcedures,
  Tasks,
  FeeAgreements,
  Payments,
  Expenses,
  Contracts,
  Communications,
  LegalReferences,
  AuditLogs,
  BackupHistory,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (details) async {
          // تفعيل التحقق الصارم من المفاتيح الأجنبية في SQLite
          await customStatement('PRAGMA foreign_keys = ON;');
        },
        onCreate: (m) async {
          await m.createAll();
          // لا يتم إضافة أي محاكم افتراضية لتبدأ القائمة فارغة تماماً
          // تهيئة نماذج وصيغ قانونية أولية
          await _seedInitialLegalTemplates();
        },
      );

  Future<void> _seedInitialLegalTemplates() async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final initialTemplates = [
      LegalReferencesCompanion.insert(
        id: const Uuid().v4(),
        title: 'صيغة استدعاء دعوى تثبيت بيع عقار',
        referenceType: 'TEMPLATE',
        category: 'عقاري',
        fullText: '''لدى محكمة البداية المدنية الموقرة بدمشق
الجهة المدعية: [...] يمثلها المحامي [...]
الجهة المدعى عليها: [...]
موضوع الدعوى: تثبيت بيع عقاري وتسجيله بالسجل العقاري.
الوقائع:
1. يملك المدعى عليه تمام العقار رقم (...) من المنطقة العقارية (...) بدمشق.
2. بموجب عقد بيع قطعي مؤرخ في (...) اشترى موكلي من المدعى عليه العقار المذكور لقاء ثمن قدره (...) سدد منه (...).
الطلبات:
1. وضع إشارة الدعوى على صحيفة العقار رقم (...) لدى السجل العقاري بدمشق.
2. الحكم بتثبيت البيع وتسجيل العقار على اسم الجهة المدعية بعد سداد الرصيد إن وجد.''',
        isVerified: const Value(1),
        source: const Value('مجموعة صيغ الدعاوى القضائية السورية'),
        createdAt: now,
      ),
      LegalReferencesCompanion.insert(
        id: const Uuid().v4(),
        title: 'صيغة إنذار عدلي بإخلاء مأجور لعلة عدم دفع الأجرة',
        referenceType: 'TEMPLATE',
        category: 'عقاري / إيجار',
        fullText: '''بواسطة السيد الكاتب العدل بدمشق المحترم
المنذِر: [...] المقيم في دمشق - يمثله المحامي [...]
المنذَر إليه: [...] المقيم في المأجور الكائن في [...]
الموضوع: إنذار بدفع الأجور المستحقة وإلا الإخلاء وفق قانون الإيجار.
الوقائع:
تستأجر من المنذر العقار المأجور الكائن في (...) ببدل إيجار شهري/سنوي قدره (...).
وحيث أنك تخلفت عن سداد الأجور المستحقة عن الفترة من (...) إلى (...) ومجموعها (...).
لذلك نلفت نظرك إلى وجوب المبادرة لسداد كامل المبلغ خلال مهلة ثلاثين يوماً من تبلغك هذا الإنذار وإلا سنضطر لرفع دعوى الإخلاء.''',
        isVerified: const Value(1),
        source: const Value('مجموعة صيغ الإنذارات العدلية السورية'),
        createdAt: now,
      ),
    ];

    for (final template in initialTemplates) {
      await into(legalReferences).insert(template);
    }
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'law_office.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
