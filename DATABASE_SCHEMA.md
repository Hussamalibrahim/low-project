# مخطط وقواعد بيانات نظام إدارة مكتب المحاماة (DATABASE_SCHEMA.md)
## وثيقة التصميم الشامل لقاعدة البيانات (SQLite + Drift ORM)

### 1. معايير التصميم وقواعد النزاهة
- **محرك البيانات:** SQLite مع Drift ORM.
- **تفعيل القيود:** تفعيل المفاتيح الأجنبية `PRAGMA foreign_keys = ON;`.
- **المعرفات الأساسية:** استخدام سلاسل UUID نصية فريدة (v4) لجميع السجلات لتسهيل المزامنة والنسخ والاستعادة دون تضارب المعرفات التلقائية.
- **الحذف المنطقي (Soft Deletion):** حقل `deleted_at` لجميع السجلات الرئيسية القابلة للاسترجاع (الموكلون، القضايا، المستندات، الجلسات، المهام، المعاملات المالية).
- **التوقيتات الموحدة:** تخزين التواريخ والأوقات بتنسيق UTC ISO-8601 (`created_at`, `updated_at`).
- **الدقة المالية:** تخزين المبالغ المالية بأعداد صحيحة دقيقة (Integer Minor Units أو قروش/وحدات دقيقة) لمنع أخطاء الحساب العشري للعملات (ليرة سورية، دولار أمريكي، يورو).
- **الفهرسة المحسّنة (Indexing):** فهارس مركبة وفهارس نصية لتسريع البحث بالاسم، رقم القضية، الرقم الوطني، وتواريخ الجلسات.
- **تخزين المستندات:** عدم تخزين المحتوى الثنائي (BLOB) للمستندات الكبيرة داخل SQLite، بل تخزين مسارها وبياناتها الوصفية ومعرف URI الخاص بـ SAF.

---

### 2. الجداول والعلاقات الأساسية

#### أ. الموكلون وجهات الاتصال (Clients & Contacts)
1. **`clients` (الموكلون):**
   - `id`: TEXT (UUID, PK)
   - `client_type`: TEXT ('INDIVIDUAL', 'COMPANY')
   - `full_name`: TEXT (NOT NULL)
   - `national_id`: TEXT (NULLABLE, Indexed)
   - `phone`: TEXT (NOT NULL)
   - `phone_secondary`: TEXT (NULLABLE)
   - `email`: TEXT (NULLABLE)
   - `address`: TEXT (NULLABLE)
   - `occupation`: TEXT (NULLABLE)
   - `company_name`: TEXT (NULLABLE)
   - `commercial_record`: TEXT (NULLABLE)
   - `notes`: TEXT (NULLABLE)
   - `created_at`: INTEGER (NOT NULL)
   - `updated_at`: INTEGER (NOT NULL)
   - `deleted_at`: INTEGER (NULLABLE)

2. **`courts` (المحاكم والمجمعات القضائية):**
   - `id`: TEXT (UUID, PK)
   - `name`: TEXT (NOT NULL) - مثل: "قصر العدل بدمشق - محكمة البداية المدنية"
   - `court_type`: TEXT (NOT NULL) - 'CIVIL', 'CRIMINAL', 'COMMERCIAL', 'LABOR', 'SHARIA', 'APPEAL', 'CASSATION', 'ADMINISTRATIVE', 'EXECUTION'
   - `governorate`: TEXT (NOT NULL) - دمشق، ريف دمشق، ...
   - `city`: TEXT (NOT NULL)
   - `address`: TEXT (NULLABLE)
   - `phone`: TEXT (NULLABLE)
   - `notes`: TEXT (NULLABLE)
   - `created_at`: INTEGER (NOT NULL)

3. **`contacts` (جهات الاتصال المهنية):**
   - `id`: TEXT (UUID, PK)
   - `name`: TEXT (NOT NULL)
   - `category`: TEXT (NOT NULL) - 'LAWYER', 'EXPERT', 'WITNESS', 'TRANSLATOR', 'OFFICIAL', 'NOTARY', 'OTHER'
   - `phone`: TEXT (NULLABLE)
   - `phone_secondary`: TEXT (NULLABLE)
   - `email`: TEXT (NULLABLE)
   - `address`: TEXT (NULLABLE)
   - `organization`: TEXT (NULLABLE)
   - `notes`: TEXT (NULLABLE)
   - `created_at`: INTEGER (NOT NULL)
   - `deleted_at`: INTEGER (NULLABLE)

---

#### ب. القضايا والأطراف (Cases & Parties)
4. **`cases` (الدعاوى والقضايا):**
   - `id`: TEXT (UUID, PK)
   - `case_number`: TEXT (NOT NULL) - رقم الأساس أو الدعوى
   - `case_year`: INTEGER (NOT NULL) - سنة الدعوى
   - `title`: TEXT (NOT NULL) - موضوع أو اسم الدعوى
   - `case_type`: TEXT (NOT NULL) - مدني، جزائي، تجاري، عمالي، عقاري، شرعي، إداري، تنفيذي...
   - `court_id`: TEXT (FK -> courts.id, NULLABLE)
   - `circuit`: TEXT (NULLABLE) - الغرفة أو الدائرة (مثلاً: الغرفة الخامسة)
   - `stage`: TEXT (NOT NULL) - درجة التقاضي: صلح، بداية، استئناف، نقض، تنفيذ
   - `registration_date`: INTEGER (NULLABLE)
   - `subject`: TEXT (NULLABLE) - وقائع الدعوى والطلبات
   - `claim_amount`: INTEGER (NULLABLE) - المبلغ المدعى به (بأصغر وحدة)
   - `currency`: TEXT (DEFAULT 'SYP')
   - `status`: TEXT (NOT NULL) - 'OPEN', 'PENDING', 'ON_HOLD', 'APPEALED', 'EXECUTION', 'CLOSED', 'ARCHIVED'
   - `outcome`: TEXT (NULLABLE) - منطوق الحكم أو النتيجة
   - `closing_date`: INTEGER (NULLABLE)
   - `notes`: TEXT (NULLABLE)
   - `created_at`: INTEGER (NOT NULL)
   - `updated_at`: INTEGER (NOT NULL)
   - `deleted_at`: INTEGER (NULLABLE)

5. **`case_clients` (علاقة متعدد لمتعدد بين القضايا والموكلين):**
   - `id`: TEXT (UUID, PK)
   - `case_id`: TEXT (FK -> cases.id, ON DELETE CASCADE)
   - `client_id`: TEXT (FK -> clients.id, ON DELETE RESTRICT)
   - `role`: TEXT (NOT NULL) - 'PLAINTIFF' (مدعي)، 'DEFENDANT' (مدعى عليه)، 'APPELLANT' (مستأنف)...
   - `created_at`: INTEGER (NOT NULL)

6. **`case_parties` (أطراف الدعوى والخصوم):**
   - `id`: TEXT (UUID, PK)
   - `case_id`: TEXT (FK -> cases.id, ON DELETE CASCADE)
   - `name`: TEXT (NOT NULL) - اسم الخصم أو الطرف الآخر
   - `role`: TEXT (NOT NULL) - 'OPPONENT' (خصم أصلي)، 'THIRD_PARTY' (مدخل/ضامن)...
   - `lawyer_name`: TEXT (NULLABLE) - محامي الخصم
   - `lawyer_phone`: TEXT (NULLABLE)
   - `notes`: TEXT (NULLABLE)
   - `created_at`: INTEGER (NOT NULL)

---

#### ج. إدارة الملفات والمجلدات (File & Document Management)
7. **`folder_links` (المجلدات المرتبطة بنظام SAF):**
   - `id`: TEXT (UUID, PK)
   - `uri_string`: TEXT (NOT NULL, UNIQUE) - المعرف الدائم للـ SAF Tree URI
   - `display_name`: TEXT (NOT NULL) - اسم المجلد الظاهر
   - `path_hint`: TEXT (NULLABLE)
   - `is_accessible`: INTEGER (DEFAULT 1) - هل إذن الوصول لا زال سارياً
   - `last_scanned_at`: INTEGER (NULLABLE)
   - `scan_status`: TEXT ('IDLE', 'SCANNING', 'ERROR')
   - `notes`: TEXT (NULLABLE)
   - `created_at`: INTEGER (NOT NULL)
   - `deleted_at`: INTEGER (NULLABLE)

8. **`documents` (المستندات والوثائق المفهرسة):**
   - `id`: TEXT (UUID, PK)
   - `folder_link_id`: TEXT (FK -> folder_links.id, NULLABLE)
   - `file_name`: TEXT (NOT NULL)
   - `uri_string`: TEXT (NOT NULL) - URI المباشر للملف
   - `mime_type`: TEXT (NOT NULL)
   - `extension`: TEXT (NOT NULL)
   - `file_size`: INTEGER (NOT NULL)
   - `last_modified`: INTEGER (NOT NULL)
   - `sha256_hash`: TEXT (NULLABLE) - يتم حسابه عند الحاجة
   - `category`: TEXT (NOT NULL) - 'POA', 'CONTRACT', 'CLAIM_STATEMENT', 'DEFENSE_MEMO', 'JUDGMENT', 'DECISION', 'EVIDENCE', 'ID_DOCUMENT', 'RECEIPT', 'OTHER'
   - `is_available`: INTEGER (DEFAULT 1) - متاح أم مفقود في القرص
   - `has_extracted_text`: INTEGER (DEFAULT 0)
   - `created_at`: INTEGER (NOT NULL)
   - `updated_at`: INTEGER (NOT NULL)
   - `deleted_at`: INTEGER (NULLABLE)

9. **`case_documents` (ربط المستند بعدة قضايا - Many-to-Many):**
   - `id`: TEXT (UUID, PK)
   - `case_id`: TEXT (FK -> cases.id, ON DELETE CASCADE)
   - `document_id`: TEXT (FK -> documents.id, ON DELETE CASCADE)
   - `relation_note`: TEXT (NULLABLE)
   - `created_at`: INTEGER (NOT NULL)
   - UNIQUE (case_id, document_id)

10. **`document_text_index` (فهرس النصوص والبحث الكامل المحلي):**
    - `id`: TEXT (UUID, PK)
    - `document_id`: TEXT (FK -> documents.id, ON DELETE CASCADE, UNIQUE)
    - `extracted_text`: TEXT (NOT NULL)
    - `normalized_text`: TEXT (NOT NULL) - نص معالج وموحد لأشكال الألف والهمزات والتاء المربوطة
    - `extraction_method`: TEXT ('EMBEDDED_PDF', 'OCR', 'DOCX_TEXT', 'MANUAL')
    - `indexed_at`: INTEGER (NOT NULL)

---

#### د. الجلسات والإجراءات والمهام (Hearings, Procedures & Tasks)
11. **`hearings` (جلسات المحاكمة):**
    - `id`: TEXT (UUID, PK)
    - `case_id`: TEXT (FK -> cases.id, ON DELETE CASCADE)
    - `court_id`: TEXT (FK -> courts.id, NULLABLE)
    - `hearing_date`: INTEGER (NOT NULL) - تاريخ ووقت الجلسة
    - `hearing_type`: TEXT (NOT NULL) - مرافعة، استجواب، شهادة شهود، تقرير خبرة، نطق بالحكم...
    - `status`: TEXT ('SCHEDULED', 'ATTENDED', 'POSTPONED', 'CANCELLED')
    - `decision`: TEXT (NULLABLE) - قرار المحكمة في الجلسة
    - `postponement_reason`: TEXT (NULLABLE) - سبب التأجيل
    - `next_hearing_date`: INTEGER (NULLABLE) - موعد الجلسة القادمة
    - `lawyer_notes`: TEXT (NULLABLE)
    - `created_at`: INTEGER (NOT NULL)
    - `deleted_at`: INTEGER (NULLABLE)

12. **`case_procedures` (الإجراءات والمعاملات القضائية):**
    - `id`: TEXT (UUID, PK)
    - `case_id`: TEXT (FK -> cases.id, ON DELETE CASCADE)
    - `procedure_date`: INTEGER (NOT NULL)
    - `title`: TEXT (NOT NULL) - تقديم مذكرة، قيد طعن، تبليغ إنذار عدلي، طلب تنفيذ، حجز احتياطي...
    - `procedure_type`: TEXT (NOT NULL)
    - `description`: TEXT (NULLABLE)
    - `result`: TEXT (NULLABLE)
    - `document_id`: TEXT (FK -> documents.id, NULLABLE)
    - `created_at`: INTEGER (NOT NULL)
    - `deleted_at`: INTEGER (NULLABLE)

13. **`tasks` (المهام والتنبيهات المجدولة):**
    - `id`: TEXT (UUID, PK)
    - `title`: TEXT (NOT NULL)
    - `description`: TEXT (NULLABLE)
    - `case_id`: TEXT (FK -> cases.id, NULLABLE, ON DELETE SET NULL)
    - `client_id`: TEXT (FK -> clients.id, NULLABLE, ON DELETE SET NULL)
    - `priority`: TEXT ('LOW', 'MEDIUM', 'HIGH', 'URGENT')
    - `status`: TEXT ('PENDING', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED')
    - `due_date`: INTEGER (NOT NULL)
    - `reminder_time`: INTEGER (NULLABLE)
    - `completed_at`: INTEGER (NULLABLE)
    - `created_at`: INTEGER (NOT NULL)
    - `deleted_at`: INTEGER (NULLABLE)

---

#### هـ. الحسابات والمالية (Financial Management)
14. **`fee_agreements` (اتفاقيات الأتعاب القانونية):**
    - `id`: TEXT (UUID, PK)
    - `client_id`: TEXT (FK -> clients.id, ON DELETE RESTRICT)
    - `case_id`: TEXT (FK -> cases.id, NULLABLE, ON DELETE SET NULL)
    - `agreed_amount`: INTEGER (NOT NULL) - المبلغ الكلي المتفق عليه (Minor Units)
    - `currency`: TEXT (DEFAULT 'SYP')
    - `agreement_type`: TEXT ('LUMP_SUM', 'PER_STAGE', 'CONTINGENCY')
    - `agreement_date`: INTEGER (NOT NULL)
    - `notes`: TEXT (NULLABLE)
    - `created_at`: INTEGER (NOT NULL)
    - `deleted_at`: INTEGER (NULLABLE)

15. **`payments` (الدفعات المقبوضة من الموكلين):**
    - `id`: TEXT (UUID, PK)
    - `fee_agreement_id`: TEXT (FK -> fee_agreements.id, NULLABLE)
    - `client_id`: TEXT (FK -> clients.id, ON DELETE RESTRICT)
    - `case_id`: TEXT (FK -> cases.id, NULLABLE)
    - `amount`: INTEGER (NOT NULL) - الدفعة المسددة
    - `currency`: TEXT (DEFAULT 'SYP')
    - `payment_date`: INTEGER (NOT NULL)
    - `payment_method`: TEXT ('CASH', 'BANK_TRANSFER', 'CHECK')
    - `receipt_number`: TEXT (NULLABLE)
    - `notes`: TEXT (NULLABLE)
    - `created_at`: INTEGER (NOT NULL)
    - `deleted_at`: INTEGER (NULLABLE)

16. **`expenses` (المصاريف القضائية والمكتبية):**
    - `id`: TEXT (UUID, PK)
    - `case_id`: TEXT (FK -> cases.id, NULLABLE)
    - `category`: TEXT (NOT NULL) - 'COURT_FEES', 'EXPERTISE', 'NOTIFICATION', 'TRANSPORT', 'OFFICE', 'OTHER'
    - `amount`: INTEGER (NOT NULL)
    - `currency`: TEXT (DEFAULT 'SYP')
    - `expense_date`: INTEGER (NOT NULL)
    - `recipient`: TEXT (NULLABLE) - الجهة المستلمة (صندوق المحكمة، خبير...)
    - `document_id`: TEXT (FK -> documents.id, NULLABLE) - إيصال الدفع
    - `notes`: TEXT (NULLABLE)
    - `created_at`: INTEGER (NOT NULL)
    - `deleted_at`: INTEGER (NULLABLE)

---

#### و. العقود، الوكالات، والاتصالات (Contracts, PoA & Communications)
17. **`contracts` (العقود والوكالات):**
    - `id`: TEXT (UUID, PK)
    - `client_id`: TEXT (FK -> clients.id, ON DELETE RESTRICT)
    - `case_id`: TEXT (FK -> cases.id, NULLABLE)
    - `document_number`: TEXT (NOT NULL) - رقم التوثيق أو رقم سند التوكيل
    - `contract_type`: TEXT ('GENERAL_POA', 'SPECIAL_POA', 'LEGAL_SERVICES', 'SETTLEMENT', 'OTHER')
    - `issuing_authority`: TEXT (NULLABLE) - كاتب العدل بدمشق...
    - `issue_date`: INTEGER (NOT NULL)
    - `expiry_date`: INTEGER (NULLABLE)
    - `status`: TEXT ('ACTIVE', 'EXPIRED', 'REVOKED')
    - `document_id`: TEXT (FK -> documents.id, NULLABLE)
    - `notes`: TEXT (NULLABLE)
    - `created_at`: INTEGER (NOT NULL)
    - `deleted_at`: INTEGER (NULLABLE)

18. **`communications` (سجل الاتصالات والمقابلات):**
    - `id`: TEXT (UUID, PK)
    - `client_id`: TEXT (FK -> clients.id, NULLABLE)
    - `case_id`: TEXT (FK -> cases.id, NULLABLE)
    - `contact_id`: TEXT (FK -> contacts.id, NULLABLE)
    - `communication_type`: TEXT ('PHONE_CALL', 'OFFICE_MEETING', 'COURT_MEETING', 'MESSAGE', 'EMAIL')
    - `communication_date`: INTEGER (NOT NULL)
    - `summary`: TEXT (NOT NULL)
    - `result`: TEXT (NULLABLE)
    - `created_at`: INTEGER (NOT NULL)
    - `deleted_at`: INTEGER (NULLABLE)

---

#### ز. المكتبة القانونية وسجل التدقيق والنسخ (Legal Library, Audit & Backups)
19. **`legal_references` (المكتبة القانونية السورية):**
    - `id`: TEXT (UUID, PK)
    - `title`: TEXT (NOT NULL)
    - `reference_type`: TEXT ('LAW', 'LEGISLATIVE_DECREE', 'CASSATION_PRECEDENT', 'SHARIA_RULING', 'TEMPLATE', 'REFERENCE_NOTE')
    - `law_number`: TEXT (NULLABLE) - رقم القانون أو المرسوم
    - `year`: INTEGER (NULLABLE)
    - `issuing_authority`: TEXT (NULLABLE) - مجلس الشعب، رئاسة الجمهورية، محكمة النقض...
    - `category`: TEXT (NOT NULL) - مدني، جزائي، أصول محاكمات، تجاري، أحوال شخصية...
    - `full_text`: TEXT (NOT NULL)
    - `source`: TEXT (NULLABLE) - الجريدة الرسمية، مجلة المحامون...
    - `is_verified`: INTEGER (DEFAULT 1)
    - `created_at`: INTEGER (NOT NULL)
    - `deleted_at`: INTEGER (NULLABLE)

20. **`audit_logs` (سجل التدقيق والحركات):**
    - `id`: TEXT (UUID, PK)
    - `timestamp`: INTEGER (NOT NULL)
    - `action`: TEXT (NOT NULL) - 'CREATE', 'UPDATE', 'DELETE', 'RESTORE', 'BACKUP', 'RESTORE_BACKUP', 'LOGIN', 'SETTINGS_CHANGE'
    - `entity_type`: TEXT (NOT NULL) - 'CLIENT', 'CASE', 'DOCUMENT', 'FINANCE', 'SYSTEM'
    - `entity_id`: TEXT (NULLABLE)
    - `details`: TEXT (NOT NULL)
    - `ip_or_device`: TEXT (DEFAULT 'LOCAL_DEVICE')

21. **`backup_history` (سجل النسخ الاحتياطي):**
    - `id`: TEXT (UUID, PK)
    - `backup_name`: TEXT (NOT NULL)
    - `file_path`: TEXT (NOT NULL)
    - `file_size`: INTEGER (NOT NULL)
    - `backup_type`: TEXT ('DAILY', 'WEEKLY', 'MONTHLY', 'MANUAL')
    - `is_encrypted`: INTEGER (DEFAULT 1)
    - `documents_count`: INTEGER (NOT NULL)
    - `sha256_checksum`: TEXT (NOT NULL)
    - `uploaded_to_drive`: INTEGER (DEFAULT 0)
    - `drive_file_id`: TEXT (NULLABLE)
    - `created_at`: INTEGER (NOT NULL)
