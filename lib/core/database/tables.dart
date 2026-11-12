import 'package:drift/drift.dart';

// 1. الموكلون
class Clients extends Table {
  TextColumn get id => text()(); // UUID v4
  TextColumn get clientType => text()(); // 'INDIVIDUAL', 'COMPANY'
  TextColumn get fullName => text()();
  TextColumn get nationalId => text().nullable()();
  TextColumn get phone => text()();
  TextColumn get phoneSecondary => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get occupation => text().nullable()();
  TextColumn get companyName => text().nullable()();
  TextColumn get commercialRecord => text().nullable()();
  TextColumn get notes => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
  IntColumn get deletedAt => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// 2. المحاكم
class Courts extends Table {
  TextColumn get id => text()(); // UUID v4
  TextColumn get name => text()();
  TextColumn get courtType => text()();
  TextColumn get governorate => text()();
  TextColumn get city => text()();
  TextColumn get address => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get notes => text().nullable()();
  IntColumn get createdAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

// 3. جهات الاتصال
class Contacts extends Table {
  TextColumn get id => text()(); // UUID v4
  TextColumn get name => text()();
  TextColumn get category => text()(); // 'LAWYER', 'EXPERT', 'WITNESS', 'TRANSLATOR', 'OFFICIAL', 'NOTARY', 'OTHER'
  TextColumn get phone => text().nullable()();
  TextColumn get phoneSecondary => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get organization => text().nullable()();
  TextColumn get notes => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get deletedAt => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// 4. القضايا
class Cases extends Table {
  TextColumn get id => text()(); // UUID v4
  TextColumn get caseNumber => text()(); // رقم الأساس
  IntColumn get caseYear => integer()(); // سنة الأساس
  TextColumn get title => text()();
  TextColumn get caseType => text()();
  TextColumn get courtId => text().nullable().references(Courts, #id)();
  TextColumn get circuit => text().nullable()(); // الغرفة / الدائرة
  TextColumn get stage => text()(); // صلح، بداية، استئناف، نقض، تنفيذ
  IntColumn get registrationDate => integer().nullable()();
  TextColumn get subject => text().nullable()();
  IntColumn get claimAmount => integer().nullable()(); // Minor units
  TextColumn get currency => text().withDefault(const Constant('SYP'))();
  TextColumn get status => text()(); // 'OPEN', 'PENDING', 'ON_HOLD', 'APPEALED', 'EXECUTION', 'CLOSED', 'ARCHIVED'
  TextColumn get outcome => text().nullable()();
  IntColumn get closingDate => integer().nullable()();
  TextColumn get notes => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
  IntColumn get deletedAt => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// 5. ربط الموكلين بالقضايا (Many-to-Many)
class CaseClients extends Table {
  TextColumn get id => text()();
  TextColumn get caseId => text().references(Cases, #id, onDelete: KeyAction.cascade)();
  TextColumn get clientId => text().references(Clients, #id, onDelete: KeyAction.restrict)();
  TextColumn get role => text()(); // 'PLAINTIFF', 'DEFENDANT', 'APPELLANT'...
  IntColumn get createdAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

// 6. أطراف الدعوى والخصوم
class CaseParties extends Table {
  TextColumn get id => text()();
  TextColumn get caseId => text().references(Cases, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text()();
  TextColumn get role => text()(); // 'OPPONENT', 'THIRD_PARTY'...
  TextColumn get lawyerName => text().nullable()();
  TextColumn get lawyerPhone => text().nullable()();
  TextColumn get notes => text().nullable()();
  IntColumn get createdAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

// 7. المجلدات المرتبطة بنظام SAF
class FolderLinks extends Table {
  TextColumn get id => text()();
  TextColumn get uriString => text().unique()();
  TextColumn get displayName => text()();
  TextColumn get pathHint => text().nullable()();
  IntColumn get isAccessible => integer().withDefault(const Constant(1))();
  IntColumn get lastScannedAt => integer().nullable()();
  TextColumn get scanStatus => text().withDefault(const Constant('IDLE'))();
  TextColumn get notes => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get deletedAt => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// 8. المستندات المفهرسة
class Documents extends Table {
  TextColumn get id => text()();
  TextColumn get folderLinkId => text().nullable().references(FolderLinks, #id, onDelete: KeyAction.setNull)();
  TextColumn get fileName => text()();
  TextColumn get uriString => text()();
  TextColumn get mimeType => text()();
  TextColumn get extension => text()();
  IntColumn get fileSize => integer()();
  IntColumn get lastModified => integer()();
  TextColumn get sha256Hash => text().nullable()();
  TextColumn get category => text()(); // 'POA', 'CONTRACT', 'CLAIM_STATEMENT', 'DEFENSE_MEMO', 'JUDGMENT', 'DECISION', 'EVIDENCE', 'ID_DOCUMENT', 'RECEIPT', 'OTHER'
  IntColumn get isAvailable => integer().withDefault(const Constant(1))();
  IntColumn get hasExtractedText => integer().withDefault(const Constant(0))();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
  IntColumn get deletedAt => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// 9. ربط المستندات بالقضايا (Many-to-Many)
class CaseDocuments extends Table {
  TextColumn get id => text()();
  TextColumn get caseId => text().references(Cases, #id, onDelete: KeyAction.cascade)();
  TextColumn get documentId => text().references(Documents, #id, onDelete: KeyAction.cascade)();
  TextColumn get relationNote => text().nullable()();
  IntColumn get createdAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

// 10. فهرس النصوص المستخرجة
class DocumentTextIndex extends Table {
  TextColumn get id => text()();
  TextColumn get documentId => text().references(Documents, #id, onDelete: KeyAction.cascade).unique()();
  TextColumn get extractedText => text()();
  TextColumn get normalizedText => text()();
  TextColumn get extractionMethod => text()(); // 'EMBEDDED_PDF', 'OCR', 'DOCX_TEXT', 'MANUAL'
  IntColumn get indexedAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

// 11. الجلسات
class Hearings extends Table {
  TextColumn get id => text()();
  TextColumn get caseId => text().references(Cases, #id, onDelete: KeyAction.cascade)();
  TextColumn get courtId => text().nullable().references(Courts, #id, onDelete: KeyAction.setNull)();
  IntColumn get hearingDate => integer()();
  TextColumn get hearingType => text()();
  TextColumn get status => text().withDefault(const Constant('SCHEDULED'))(); // 'SCHEDULED', 'ATTENDED', 'POSTPONED', 'CANCELLED'
  TextColumn get decision => text().nullable()();
  TextColumn get postponementReason => text().nullable()();
  IntColumn get nextHearingDate => integer().nullable()();
  TextColumn get lawyerNotes => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get deletedAt => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// 12. الإجراءات والمعاملات القضائية
class CaseProcedures extends Table {
  TextColumn get id => text()();
  TextColumn get caseId => text().references(Cases, #id, onDelete: KeyAction.cascade)();
  IntColumn get procedureDate => integer()();
  TextColumn get title => text()();
  TextColumn get procedureType => text()();
  TextColumn get description => text().nullable()();
  TextColumn get result => text().nullable()();
  TextColumn get documentId => text().nullable().references(Documents, #id, onDelete: KeyAction.setNull)();
  IntColumn get createdAt => integer()();
  IntColumn get deletedAt => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// 13. المهام
class Tasks extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get caseId => text().nullable().references(Cases, #id, onDelete: KeyAction.setNull)();
  TextColumn get clientId => text().nullable().references(Clients, #id, onDelete: KeyAction.setNull)();
  TextColumn get priority => text()(); // 'LOW', 'MEDIUM', 'HIGH', 'URGENT'
  TextColumn get status => text().withDefault(const Constant('PENDING'))(); // 'PENDING', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED'
  IntColumn get dueDate => integer()();
  IntColumn get reminderTime => integer().nullable()();
  IntColumn get completedAt => integer().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get deletedAt => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// 14. اتفاقيات الأتعاب
class FeeAgreements extends Table {
  TextColumn get id => text()();
  TextColumn get clientId => text().references(Clients, #id, onDelete: KeyAction.restrict)();
  TextColumn get caseId => text().nullable().references(Cases, #id, onDelete: KeyAction.setNull)();
  IntColumn get agreedAmount => integer()(); // Minor units
  TextColumn get currency => text().withDefault(const Constant('SYP'))();
  TextColumn get agreementType => text()(); // 'LUMP_SUM', 'PER_STAGE', 'CONTINGENCY'
  IntColumn get agreementDate => integer()();
  TextColumn get notes => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get deletedAt => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// 15. الدفعات المالية
class Payments extends Table {
  TextColumn get id => text()();
  TextColumn get feeAgreementId => text().nullable().references(FeeAgreements, #id, onDelete: KeyAction.setNull)();
  TextColumn get clientId => text().references(Clients, #id, onDelete: KeyAction.restrict)();
  TextColumn get caseId => text().nullable().references(Cases, #id, onDelete: KeyAction.setNull)();
  IntColumn get amount => integer()(); // Minor units
  TextColumn get currency => text().withDefault(const Constant('SYP'))();
  IntColumn get paymentDate => integer()();
  TextColumn get paymentMethod => text()(); // 'CASH', 'BANK_TRANSFER', 'CHECK'
  TextColumn get receiptNumber => text().nullable()();
  TextColumn get notes => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get deletedAt => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// 16. المصاريف
class Expenses extends Table {
  TextColumn get id => text()();
  TextColumn get caseId => text().nullable().references(Cases, #id, onDelete: KeyAction.setNull)();
  TextColumn get category => text()(); // 'COURT_FEES', 'EXPERTISE', 'NOTIFICATION', 'TRANSPORT', 'OFFICE', 'OTHER'
  IntColumn get amount => integer()(); // Minor units
  TextColumn get currency => text().withDefault(const Constant('SYP'))();
  IntColumn get expenseDate => integer()();
  TextColumn get recipient => text().nullable()();
  TextColumn get documentId => text().nullable().references(Documents, #id, onDelete: KeyAction.setNull)();
  TextColumn get notes => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get deletedAt => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// 17. العقود والوكالات
class Contracts extends Table {
  TextColumn get id => text()();
  TextColumn get clientId => text().references(Clients, #id, onDelete: KeyAction.restrict)();
  TextColumn get caseId => text().nullable().references(Cases, #id, onDelete: KeyAction.setNull)();
  TextColumn get documentNumber => text()(); // رقم التوثيق
  TextColumn get contractType => text()(); // 'GENERAL_POA', 'SPECIAL_POA', 'LEGAL_SERVICES', 'SETTLEMENT', 'OTHER'
  TextColumn get issuingAuthority => text().nullable()(); // كاتب العدل بدمشق...
  IntColumn get issueDate => integer()();
  IntColumn get expiryDate => integer().nullable()();
  TextColumn get status => text().withDefault(const Constant('ACTIVE'))(); // 'ACTIVE', 'EXPIRED', 'REVOKED'
  TextColumn get documentId => text().nullable().references(Documents, #id, onDelete: KeyAction.setNull)();
  TextColumn get notes => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get deletedAt => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// 18. سجل الاتصالات والمقابلات
class Communications extends Table {
  TextColumn get id => text()();
  TextColumn get clientId => text().nullable().references(Clients, #id, onDelete: KeyAction.setNull)();
  TextColumn get caseId => text().nullable().references(Cases, #id, onDelete: KeyAction.setNull)();
  TextColumn get contactId => text().nullable().references(Contacts, #id, onDelete: KeyAction.setNull)();
  TextColumn get communicationType => text()(); // 'PHONE_CALL', 'OFFICE_MEETING', 'COURT_MEETING', 'MESSAGE', 'EMAIL'
  IntColumn get communicationDate => integer()();
  TextColumn get summary => text()();
  TextColumn get result => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get deletedAt => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// 19. المكتبة القانونية
class LegalReferences extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get referenceType => text()(); // 'LAW', 'LEGISLATIVE_DECREE', 'CASSATION_PRECEDENT', 'SHARIA_RULING', 'TEMPLATE', 'REFERENCE_NOTE'
  TextColumn get lawNumber => text().nullable()();
  IntColumn get year => integer().nullable()();
  TextColumn get issuingAuthority => text().nullable()();
  TextColumn get category => text()();
  TextColumn get fullText => text()();
  TextColumn get source => text().nullable()();
  IntColumn get isVerified => integer().withDefault(const Constant(1))();
  IntColumn get createdAt => integer()();
  IntColumn get deletedAt => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// 20. سجل التدقيق
class AuditLogs extends Table {
  TextColumn get id => text()();
  IntColumn get timestamp => integer()();
  TextColumn get action => text()(); // 'CREATE', 'UPDATE', 'DELETE', 'RESTORE', 'BACKUP', 'RESTORE_BACKUP', 'LOGIN', 'SETTINGS_CHANGE'
  TextColumn get entityType => text()(); // 'CLIENT', 'CASE', 'DOCUMENT', 'FINANCE', 'SYSTEM'
  TextColumn get entityId => text().nullable()();
  TextColumn get details => text()();
  TextColumn get ipOrDevice => text().withDefault(const Constant('LOCAL_DEVICE'))();

  @override
  Set<Column> get primaryKey => {id};
}

// 21. سجل النسخ الاحتياطي
class BackupHistory extends Table {
  TextColumn get id => text()();
  TextColumn get backupName => text()();
  TextColumn get filePath => text()();
  IntColumn get fileSize => integer()();
  TextColumn get backupType => text()(); // 'DAILY', 'WEEKLY', 'MONTHLY', 'MANUAL'
  IntColumn get isEncrypted => integer().withDefault(const Constant(1))();
  IntColumn get documentsCount => integer()();
  TextColumn get sha256Checksum => text()();
  IntColumn get uploadedToDrive => integer().withDefault(const Constant(0))();
  TextColumn get driveFileId => text().nullable()();
  IntColumn get createdAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
