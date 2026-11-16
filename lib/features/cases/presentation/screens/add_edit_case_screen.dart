import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart' as p;
import '../../../../core/database/app_database.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_status_badge.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../clients/presentation/providers/clients_provider.dart';
import '../../data/repositories/cases_repository.dart';
import '../providers/cases_provider.dart';

class _ClientFormData {
  String? id;
  final TextEditingController nameCtrl = TextEditingController();
  String role = 'PLAINTIFF'; // 'PLAINTIFF' (مدعي) أو 'DEFENDANT' (مدعى عليه)
  bool isDetailsExpanded = false;
  final List<({String type, String number})> phones = [];
  final TextEditingController newPhoneCtrl = TextEditingController();
  String newPhoneType = 'محمول';
  final TextEditingController nationalIdCtrl = TextEditingController();
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController mukhtarCtrl = TextEditingController();

  void dispose() {
    nameCtrl.dispose();
    newPhoneCtrl.dispose();
    nationalIdCtrl.dispose();
    addressCtrl.dispose();
    mukhtarCtrl.dispose();
  }
}

class _OpponentFormData {
  String? id;
  final TextEditingController nameCtrl = TextEditingController();
  String role = 'DEFENDANT'; // 'DEFENDANT' (مدعى عليه) أو 'PLAINTIFF' (مدعي)
  bool isDetailsExpanded = false;
  final List<({String type, String number})> phones = [];
  final TextEditingController newPhoneCtrl = TextEditingController();
  String newPhoneType = 'محمول';
  final TextEditingController nationalIdCtrl = TextEditingController();
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController mukhtarCtrl = TextEditingController();

  void dispose() {
    nameCtrl.dispose();
    newPhoneCtrl.dispose();
    nationalIdCtrl.dispose();
    addressCtrl.dispose();
    mukhtarCtrl.dispose();
  }
}

class _ConcludedStageFormData {
  final TextEditingController courtCtrl = TextEditingController();
  final TextEditingController caseNumCtrl = TextEditingController();
  final TextEditingController yearCtrl =
      TextEditingController(text: (DateTime.now().year - 1).toString());
  final TextEditingController claimBadgeCtrl = TextEditingController();
  final TextEditingController decisionRulingCtrl = TextEditingController();
  final TextEditingController decisionNumCtrl = TextEditingController();
  DateTime? decisionDate;
  DateTime? notificationDate;
  final TextEditingController groundsCtrl = TextEditingController();
  final List<({int date, String action, String? decision})> hearings = [];
  final TextEditingController newHearingActionCtrl = TextEditingController();
  DateTime newHearingDate = DateTime.now().subtract(const Duration(days: 30));

  void dispose() {
    courtCtrl.dispose();
    caseNumCtrl.dispose();
    yearCtrl.dispose();
    claimBadgeCtrl.dispose();
    decisionRulingCtrl.dispose();
    decisionNumCtrl.dispose();
    groundsCtrl.dispose();
    newHearingActionCtrl.dispose();
  }
}

class AddEditCaseScreen extends ConsumerStatefulWidget {
  final String? caseId;

  const AddEditCaseScreen({super.key, this.caseId});

  @override
  ConsumerState<AddEditCaseScreen> createState() => _AddEditCaseScreenState();
}

class _AddEditCaseScreenState extends ConsumerState<AddEditCaseScreen> {
  final _formKey = GlobalKey<FormState>();

  // قوائم الموكلين والخصوم المتعددين
  final List<_ClientFormData> _clients = [];
  final List<_OpponentFormData> _opponents = [];

  // رقم الأساس والمحكمة
  final _caseNumberCtrl = TextEditingController();
  final _caseYearCtrl =
      TextEditingController(text: DateTime.now().year.toString());
  String? _selectedCourtId;

  // نوع الدعوى (يبدأ بما يضيفه المستخدم مع إمكانية إضافة أنواع مخصصة)
  final List<String> _customCaseTypes = [];
  String? _selectedCaseType;

  // الجلسات القضائية
  bool _isHearingsExpanded = false;
  DateTime _newHearingDate = DateTime.now().add(const Duration(days: 7));
  final _newHearingActionCtrl = TextEditingController();
  final List<({String? id, int date, String action, String? status})> _hearings = [];

  // الأعمال والإجراءات القضائية
  bool _isTasksExpanded = false;
  DateTime _newTaskDate = DateTime.now().add(const Duration(days: 3));
  final _newTaskTitleCtrl = TextEditingController();
  final List<({int date, String title})> _tasks = [];

  // إرفاق الملفات مع إمكانية تعديل الاسم
  final List<({String path, String displayName})> _attachedFiles = [];

  // ملاحظاتي
  final _notesCtrl = TextEditingController();

  // الأتعاب والمدفوعات
  final _agreedFeeCtrl = TextEditingController();
  final _paidAmountCtrl = TextEditingController();
  String _selectedCurrency = 'SYP';

  // حالة القضية عند التسجيل (قيد النظر / مفصولة / مطعون بها ومستأنفة)
  String _caseStatus = 'OPEN'; // 'OPEN', 'CLOSED', 'APPEALED'

  // بيانات قرار الفصل إن كانت القضية مفصولة
  DateTime? _resolutionDate;
  final _decisionNumberCtrl = TextEditingController();
  final _decisionRulingCtrl = TextEditingController();

  // بيانات المراحل المفصولة السابقة إن كانت القضية مطعون بها أو مستأنفة (يدعم استئناف وطعن متعدد)
  final List<_ConcludedStageFormData> _pastStages = [];

  bool _isInit = false;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    if (widget.caseId == null) {
      _clients.add(_ClientFormData());
      _opponents.add(_OpponentFormData());
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit && widget.caseId != null) {
      _loadExistingCase();
      _isInit = true;
    }
  }

  Future<void> _loadExistingCase() async {
    final details = await ref
        .read(casesRepositoryProvider)
        .getCaseWithDetails(widget.caseId!);
    if (details != null && mounted) {
      final c = details.caseItem;
      _caseNumberCtrl.text = c.caseNumber == '-' ? '' : c.caseNumber;
      _caseYearCtrl.text = c.caseYear.toString();
      _selectedCourtId = c.courtId;
      _selectedCurrency = c.currency;
      _notesCtrl.text = c.notes ?? '';

      if (!_customCaseTypes.contains(c.caseType)) {
        _customCaseTypes.add(c.caseType);
      }
      _selectedCaseType = c.caseType;

      if (details.clients.isNotEmpty) {
        for (final cl in _clients) {
          cl.dispose();
        }
        _clients.clear();
        for (final cl in details.clients) {
          final cData = _ClientFormData();
          cData.id = cl.id;
          cData.nameCtrl.text = cl.fullName;
          cData.role = details.clientRoles[cl.id] ?? 'PLAINTIFF';
          if (cl.phone.isNotEmpty) {
            cData.phones.addAll(_parsePhones(cl.phone));
          }
          if (cl.phoneSecondary != null && cl.phoneSecondary!.isNotEmpty) {
            cData.phones.addAll(_parsePhones(cl.phoneSecondary!));
          }
          if (cl.address != null && cl.address!.isNotEmpty) {
            final addr = cl.address!;
            if (addr.contains(' • المختار: ')) {
              final p = addr.split(' • المختار: ');
              cData.addressCtrl.text = p[0].replaceFirst('الإقامة: ', '').trim();
              cData.mukhtarCtrl.text = p.length > 1 ? p[1].trim() : '';
            } else {
              cData.addressCtrl.text = addr.replaceFirst('الإقامة: ', '').trim();
            }
          }
          cData.nationalIdCtrl.text = cl.nationalId ?? '';
          _clients.add(cData);
        }
      } else if (_clients.isEmpty) {
        _clients.add(_ClientFormData());
      }

      if (details.parties.isNotEmpty) {
        for (final opp in _opponents) {
          opp.dispose();
        }
        _opponents.clear();
        for (final opp in details.parties) {
          final oData = _OpponentFormData();
          oData.id = opp.id;
          oData.nameCtrl.text = opp.name;
          oData.role = opp.role == 'PLAINTIFF' ? 'PLAINTIFF' : 'DEFENDANT';
          if (opp.lawyerPhone != null && opp.lawyerPhone!.isNotEmpty) {
            oData.phones.addAll(_parsePhones(opp.lawyerPhone!));
          }
          if (opp.notes != null && opp.notes!.isNotEmpty) {
            for (final seg in opp.notes!.split(' • ')) {
              if (seg.startsWith('الرقم الوطني: ')) {
                oData.nationalIdCtrl.text =
                    seg.substring('الرقم الوطني: '.length).trim();
              } else if (seg.startsWith('العنوان: ')) {
                final a = seg.substring('العنوان: '.length).trim();
                if (a.contains(' • المختار: ')) {
                  final p = a.split(' • المختار: ');
                  oData.addressCtrl.text =
                      p[0].replaceFirst('الإقامة: ', '').trim();
                  oData.mukhtarCtrl.text = p.length > 1 ? p[1].trim() : '';
                } else {
                  oData.addressCtrl.text =
                      a.replaceFirst('الإقامة: ', '').trim();
                }
              } else if (seg.startsWith('المختار: ')) {
                oData.mukhtarCtrl.text =
                    seg.substring('المختار: '.length).trim();
              }
            }
          }
          _opponents.add(oData);
        }
      } else if (_opponents.isEmpty) {
        _opponents.add(_OpponentFormData());
      }

      // تحميل كافة الجلسات السابقة والقادمة الخاصة بالقضية
      final dbHearings = await ref
          .read(casesRepositoryProvider)
          .getCaseHearings(widget.caseId!);
      _hearings.clear();
      for (final h in dbHearings) {
        String actionText = h.hearingType;
        if (h.postponementReason != null && h.postponementReason!.isNotEmpty) {
          actionText += ' (تأجيل: ${h.postponementReason})';
        } else if (h.decision != null && h.decision!.isNotEmpty) {
          actionText += ' (القرار: ${h.decision})';
        }
        _hearings.add((
          id: h.id,
          date: h.hearingDate,
          action: actionText,
          status: h.status,
        ));
      }

      setState(() {});
    }
  }

  List<({String type, String number})> _parsePhones(String raw) {
    final list = <({String type, String number})>[];
    if (raw.trim().isEmpty) return list;
    for (final part in raw.split(' • ')) {
      final clean = part.trim();
      if (clean.isEmpty) continue;
      String type = 'محمول';
      if (clean.contains('واتساب')) {
        type = 'واتساب';
      } else if (clean.contains('هاتف')) {
        type = 'هاتف';
      }
      final number = clean.replaceAll(RegExp(r'\s*\([^)]*\)'), '').trim();
      if (number.isNotEmpty) {
        list.add((type: type, number: number));
      }
    }
    return list;
  }

  @override
  void dispose() {
    for (final cl in _clients) {
      cl.dispose();
    }
    for (final opp in _opponents) {
      opp.dispose();
    }
    _caseNumberCtrl.dispose();
    _caseYearCtrl.dispose();
    _newHearingActionCtrl.dispose();
    _newTaskTitleCtrl.dispose();
    _notesCtrl.dispose();
    _agreedFeeCtrl.dispose();
    _paidAmountCtrl.dispose();
    _decisionNumberCtrl.dispose();
    _decisionRulingCtrl.dispose();
    for (final stg in _pastStages) {
      stg.dispose();
    }
    super.dispose();
  }

  void _addHearing() {
    final text = _newHearingActionCtrl.text.trim();
    final action = text.isNotEmpty ? text : 'جلسة';
    setState(() {
      _hearings.add((
        id: null,
        date: _newHearingDate.millisecondsSinceEpoch,
        action: action,
        status: 'SCHEDULED',
      ));
      _newHearingActionCtrl.clear();
      _newHearingDate = _newHearingDate.add(const Duration(days: 14));
    });
  }

  void _addTask() {
    final text = _newTaskTitleCtrl.text.trim();
    final title = text.isNotEmpty ? text : 'إجراء قضائي';
    setState(() {
      _tasks.add((
        date: _newTaskDate.millisecondsSinceEpoch,
        title: title,
      ));
      _newTaskTitleCtrl.clear();
      _newTaskDate = _newTaskDate.add(const Duration(days: 7));
    });
  }

  Future<void> _pickFiles() async {
    try {
      final res = await FilePicker.platform.pickFiles(allowMultiple: true);
      if (res != null) {
        setState(() {
          for (final f in res.paths) {
            if (f != null && !_attachedFiles.any((item) => item.path == f)) {
              _attachedFiles.add((
                path: f,
                displayName: p.basename(f),
              ));
            }
          }
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تعذر اختيار الملفات: $e')),
        );
      }
    }
  }

  Future<void> _renameAttachedFile(int index) async {
    final current = _attachedFiles[index];
    final renameCtrl = TextEditingController(text: current.displayName);

    final newName = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('تعديل اسم الملف المرفق'),
        content: AppTextField(
          controller: renameCtrl,
          label: 'اسم الملف الجديد',
          hint: 'اكتب اسم الملف...',
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              if (renameCtrl.text.trim().isNotEmpty) {
                Navigator.pop(ctx, renameCtrl.text.trim());
              }
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );

    if (newName != null && newName.isNotEmpty && mounted) {
      setState(() {
        _attachedFiles[index] = (path: current.path, displayName: newName);
      });
    }
  }

  Future<void> _showAddCourtDialog() async {
    final nameCtrl = TextEditingController();
    final addressCtrl = TextEditingController(text: 'دمشق - قصر العدل');

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.account_balance, color: Colors.blue),
            SizedBox(width: 8),
            Text('إضافة محكمة المختصة'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextField(
              controller: nameCtrl,
              label: 'اسم المحكمة المختصة *',
              hint: 'مثال: م ب',
              autofocus: true,
            ),
            const SizedBox(height: 12),
            AppTextField(
              controller: addressCtrl,
              label: 'العنوان',
              hint: 'مثال: قصر العدل',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (nameCtrl.text.trim().isEmpty) return;
              final newCourt =
                  await ref.read(casesRepositoryProvider).createCourt(
                        name: nameCtrl.text.trim(),
                        address: addressCtrl.text.trim(),
                      );
              ref.invalidate(allCourtsProvider);
              if (mounted) {
                setState(() => _selectedCourtId = newCourt.id);
                Navigator.pop(ctx);
              }
            },
            child: const Text('حفظ واختيار'),
          ),
        ],
      ),
    );
  }

  Future<void> _showAddCaseTypeDialog() async {
    final typeCtrl = TextEditingController();

    final newType = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('إضافة نوع دعوى جديد'),
        content: AppTextField(
          controller: typeCtrl,
          label: 'نوع الدعوى *',
          hint: 'مثال: تثبيت بيع عقار / إخلاء مأجور / طلاق تعسفي',
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              if (typeCtrl.text.trim().isNotEmpty) {
                Navigator.pop(ctx, typeCtrl.text.trim());
              }
            },
            child: const Text('إضافة'),
          ),
        ],
      ),
    );

    if (newType != null && newType.isNotEmpty && mounted) {
      setState(() {
        if (!_customCaseTypes.contains(newType)) {
          _customCaseTypes.add(newType);
        }
        _selectedCaseType = newType;
      });
    }
  }

  Widget _buildRoleToggle({
    required String currentRole,
    required ValueChanged<String> onChanged,
    required ThemeData theme,
  }) {
    final isDark = theme.brightness == Brightness.dark;
    final unselectedBg = isDark ? const Color(0xFF0F172A) : const Color(0xFFE2E8F0);
    final unselectedFg = isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569);

    return Container(
      decoration: BoxDecoration(
        color: unselectedBg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => onChanged('PLAINTIFF'),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: currentRole == 'PLAINTIFF'
                    ? theme.colorScheme.primary
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'مدعي',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: currentRole == 'PLAINTIFF' ? Colors.white : unselectedFg,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => onChanged('DEFENDANT'),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: currentRole == 'DEFENDANT'
                    ? Colors.red.shade700
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'مدعى عليه',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: currentRole == 'DEFENDANT' ? Colors.white : unselectedFg,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneListSection({
    required ThemeData theme,
    required String title,
    required List<({String type, String number})> phones,
    required TextEditingController newPhoneCtrl,
    required String newPhoneType,
    required ValueChanged<String> onTypeChanged,
    required VoidCallback onAdd,
    required ValueChanged<int> onRemove,
  }) {
    final isDark = theme.brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.phone_outlined,
                size: 18, color: theme.colorScheme.primary),
            const SizedBox(width: 6),
            Text(
              '$title (${phones.length})',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isDark ? Colors.grey.shade700 : Colors.grey.shade400,
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: newPhoneType,
                  isDense: true,
                  items: const [
                    DropdownMenuItem(value: 'محمول', child: Text('محمول')),
                    DropdownMenuItem(value: 'واتساب', child: Text('واتساب')),
                    DropdownMenuItem(value: 'هاتف', child: Text('هاتف')),
                  ],
                  onChanged: (v) {
                    if (v != null) onTypeChanged(v);
                  },
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: SizedBox(
                height: 48,
                child: TextField(
                  controller: newPhoneCtrl,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: '09xxxxxxxx',
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    prefixIcon: Icon(
                      newPhoneType == 'واتساب'
                          ? Icons.chat
                          : (newPhoneType == 'هاتف'
                              ? Icons.phone
                              : Icons.phone_android),
                      size: 18,
                    ),
                  ),
                  onSubmitted: (_) => onAdd(),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton.filled(
              icon: const Icon(Icons.add, size: 20),
              tooltip: 'إضافة رقم هاتف',
              onPressed: onAdd,
            ),
          ],
        ),
        if (phones.isNotEmpty) ...[
          const SizedBox(height: 10),
          ...phones.asMap().entries.map((entry) {
            final idx = entry.key;
            final item = entry.value;
            final isWhatsApp = item.type == 'واتساب';
            final isLandline = item.type == 'هاتف';
            return Container(
              margin: const EdgeInsets.only(bottom: 6),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: isWhatsApp
                    ? Colors.green.withAlpha(20)
                    : (isLandline
                        ? Colors.indigo.withAlpha(20)
                        : Colors.blue.withAlpha(20)),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isWhatsApp
                      ? Colors.green.withAlpha(60)
                      : (isLandline
                          ? Colors.indigo.withAlpha(60)
                          : Colors.blue.withAlpha(60)),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isWhatsApp
                        ? Icons.chat
                        : (isLandline ? Icons.phone : Icons.phone_android),
                    size: 18,
                    color: isWhatsApp
                        ? Colors.green
                        : (isLandline ? Colors.indigo : Colors.blue),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: (isWhatsApp
                              ? Colors.green
                              : (isLandline ? Colors.indigo : Colors.blue))
                          .withAlpha(30),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      item.type,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: isWhatsApp
                            ? Colors.green.shade800
                            : (isLandline
                                ? Colors.indigo.shade800
                                : Colors.blue.shade800),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      item.number,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline,
                        size: 20, color: Colors.red),
                    tooltip: 'حذف هذا الرقم',
                    onPressed: () => onRemove(idx),
                  ),
                ],
              ),
            );
          }),
        ],
      ],
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    // جمع تلقائي لأي رقم كتبه المستخدم في حقل الهاتف الجديد ولم يضغط الزر +
    for (final cl in _clients) {
      if (cl.newPhoneCtrl.text.trim().isNotEmpty) {
        cl.phones.add((
          type: cl.newPhoneType,
          number: cl.newPhoneCtrl.text.trim(),
        ));
        cl.newPhoneCtrl.clear();
      }
    }
    for (final opp in _opponents) {
      if (opp.newPhoneCtrl.text.trim().isNotEmpty) {
        opp.phones.add((
          type: opp.newPhoneType,
          number: opp.newPhoneCtrl.text.trim(),
        ));
        opp.newPhoneCtrl.clear();
      }
    }

    // استخراج الموكلين الصالحين
    final clientInputs = _clients
        .where((cl) => cl.nameCtrl.text.trim().isNotEmpty)
        .map((cl) {
      final phoneFirst = cl.phones.isNotEmpty
          ? '${cl.phones.first.number} (${cl.phones.first.type})'
          : null;
      final phoneSec = cl.phones.length > 1
          ? cl.phones
              .sublist(1)
              .map((p) => '${p.number} (${p.type})')
              .join(' • ')
          : null;
      return CaseClientInput(
        id: cl.id,
        name: cl.nameCtrl.text.trim(),
        role: cl.role,
        phone: phoneFirst,
        phoneSecondary: phoneSec,
        nationalId: cl.nationalIdCtrl.text.trim().isNotEmpty
            ? cl.nationalIdCtrl.text.trim()
            : null,
        address: cl.addressCtrl.text.trim().isNotEmpty
            ? cl.addressCtrl.text.trim()
            : null,
        mukhtar: cl.mukhtarCtrl.text.trim().isNotEmpty
            ? cl.mukhtarCtrl.text.trim()
            : null,
      );
    }).toList();

    if (clientInputs.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى كتابة اسم موكل واحد على الأقل (حقل إجباري)'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // استخراج الخصوم
    final opponentInputs = _opponents
        .where((opp) => opp.nameCtrl.text.trim().isNotEmpty)
        .map((opp) {
      final resolvedPhone = opp.phones.isNotEmpty
          ? opp.phones.map((p) => '${p.number} (${p.type})').join(' • ')
          : null;
      return CaseOpponentInput(
        id: opp.id,
        name: opp.nameCtrl.text.trim(),
        role: opp.role,
        phone: resolvedPhone,
        nationalId: opp.nationalIdCtrl.text.trim().isNotEmpty
            ? opp.nationalIdCtrl.text.trim()
            : null,
        address: opp.addressCtrl.text.trim().isNotEmpty
            ? opp.addressCtrl.text.trim()
            : null,
        mukhtar: opp.mukhtarCtrl.text.trim().isNotEmpty
            ? opp.mukhtarCtrl.text.trim()
            : null,
      );
    }).toList();

    setState(() => _isSubmitting = true);

    try {
      final agreedMinor = _agreedFeeCtrl.text.trim().isNotEmpty
          ? CurrencyFormatter.parseToMinorUnits(_agreedFeeCtrl.text,
              currency: _selectedCurrency)
          : null;

      final paidMinor = _paidAmountCtrl.text.trim().isNotEmpty
          ? CurrencyFormatter.parseToMinorUnits(_paidAmountCtrl.text,
              currency: _selectedCurrency)
          : null;

      final year = int.tryParse(_caseYearCtrl.text) ?? DateTime.now().year;

      if (widget.caseId != null) {
        await ref.read(casesRepositoryProvider).updateFullLegalCase(
              caseId: widget.caseId!,
              clients: clientInputs,
              opponents: opponentInputs,
              caseNumber: _caseNumberCtrl.text.trim(),
              caseYear: year,
              caseType: _selectedCaseType ?? 'دعوى عامة',
              courtId: _selectedCourtId,
              notes: _notesCtrl.text.trim(),
              agreedAmount: agreedMinor,
              paidAmount: paidMinor,
              currency: _selectedCurrency,
              hearings: _hearings,
            );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم تعديل بيانات القضية بنجاح'),
              backgroundColor: Colors.green,
            ),
          );
          context.pop();
        }
      } else {
        String? outcomeText;
        int? effectiveClosingDate;
        if (_caseStatus == 'CLOSED') {
          effectiveClosingDate = _resolutionDate?.millisecondsSinceEpoch ?? DateTime.now().millisecondsSinceEpoch;
          final parts = <String>[];
          if (_decisionNumberCtrl.text.trim().isNotEmpty) {
            parts.add('رقم قرار الفصل: ${_decisionNumberCtrl.text.trim()}');
          }
          if (_decisionRulingCtrl.text.trim().isNotEmpty) {
            parts.add(_decisionRulingCtrl.text.trim());
          }
          outcomeText = parts.isNotEmpty ? parts.join('\n') : 'فُصلت القضية';
        }

        final pastStagesData = <({
          String courtName,
          String caseNumber,
          int caseYear,
          String? claimBadge,
          String? decisionRuling,
          String? decisionNum,
          int? decisionDate,
          int? notificationDate,
          String? grounds,
          List<({int date, String action, String? decision})> hearings,
        })>[];

        if (_caseStatus == 'APPEALED') {
          for (final stg in _pastStages) {
            if (stg.courtCtrl.text.trim().isNotEmpty ||
                stg.caseNumCtrl.text.trim().isNotEmpty ||
                stg.decisionRulingCtrl.text.trim().isNotEmpty ||
                stg.decisionNumCtrl.text.trim().isNotEmpty ||
                stg.claimBadgeCtrl.text.trim().isNotEmpty ||
                stg.groundsCtrl.text.trim().isNotEmpty ||
                stg.hearings.isNotEmpty) {
              pastStagesData.add((
                courtName: stg.courtCtrl.text.trim().isNotEmpty
                    ? stg.courtCtrl.text.trim()
                    : 'محكمة سابقة',
                caseNumber: stg.caseNumCtrl.text.trim().isNotEmpty
                    ? stg.caseNumCtrl.text.trim()
                    : '-',
                caseYear: int.tryParse(stg.yearCtrl.text.trim()) ??
                    (DateTime.now().year - 1),
                claimBadge: stg.claimBadgeCtrl.text.trim().isNotEmpty
                    ? stg.claimBadgeCtrl.text.trim()
                    : null,
                decisionRuling: stg.decisionRulingCtrl.text.trim().isNotEmpty
                    ? stg.decisionRulingCtrl.text.trim()
                    : null,
                decisionNum: stg.decisionNumCtrl.text.trim().isNotEmpty
                    ? stg.decisionNumCtrl.text.trim()
                    : null,
                decisionDate: stg.decisionDate?.millisecondsSinceEpoch,
                notificationDate: stg.notificationDate?.millisecondsSinceEpoch,
                grounds: stg.groundsCtrl.text.trim().isNotEmpty
                    ? stg.groundsCtrl.text.trim()
                    : null,
                hearings: stg.hearings,
              ));
            }
          }
        }

        await ref.read(casesRepositoryProvider).createFullLegalCase(
              clients: clientInputs,
              opponents: opponentInputs,
              caseNumber: _caseNumberCtrl.text.trim(),
              caseYear: year,
              caseType: _selectedCaseType ?? 'دعوى عامة',
              courtId: _selectedCourtId,
              stage: _caseStatus == 'APPEALED' ? 'استئناف' : 'بداية',
              status: _caseStatus,
              outcome: outcomeText,
              closingDate: effectiveClosingDate,
              pastStages: pastStagesData,
              notes: _notesCtrl.text.trim(),
              initialHearings: _hearings
                  .map((h) => (date: h.date, action: h.action))
                  .toList(),
              initialTasks: _tasks,
              agreedAmount: agreedMinor,
              paidAmount: paidMinor,
              currency: _selectedCurrency,
              attachedNamedFiles: _attachedFiles,
            );
        if (mounted) {
          final title = clientInputs.length > 1
              ? '${clientInputs.first.name} وشركاه'
              : clientInputs.first.name;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('تم إنشاء قضية ($title) بنجاح'),
              backgroundColor: Colors.green,
            ),
          );
          context.pop();
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ أثناء الحفظ: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final courtsAsync = ref.watch(allCourtsProvider);
    final clientsAsync = ref.watch(allClientsStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.caseId == null ? 'قضية جديدة' : 'تعديل القضية'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ================= 1. الموكلون (أصحاب الدعوى - يدعم موكلين متعددين) =================
            SizedBox(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                runSpacing: 4,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.people_alt,
                          size: 20, color: theme.colorScheme.primary),
                      const SizedBox(width: 8),
                      Text(
                        'الموكلون (${_clients.length})',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        final primaryRole = _clients.isNotEmpty ? _clients.first.role : 'PLAINTIFF';
                        _clients.add(_ClientFormData()..role = primaryRole);
                      });
                    },
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('إضافة موكل +'),
                    style: TextButton.styleFrom(
                      visualDensity: VisualDensity.compact,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            ..._clients.asMap().entries.map((entry) {
              final idx = entry.key;
              final cl = entry.value;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.cardTheme.color,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: cl.role == 'PLAINTIFF'
                        ? Colors.blue.withAlpha(60)
                        : Colors.red.withAlpha(60),
                    width: 1.2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'الموكل ${idx + 1}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: theme.hintColor,
                          ),
                        ),
                        Row(
                          children: [
                            if (idx == 0)
                              _buildRoleToggle(
                                currentRole: cl.role,
                                onChanged: (r) {
                                  setState(() {
                                    cl.role = r;
                                    for (final otherCl in _clients) {
                                      otherCl.role = r;
                                    }
                                  });
                                },
                                theme: theme,
                              )
                            else
                              AppStatusBadge(
                                label: cl.role == 'PLAINTIFF' ? 'مدعي' : 'مدعى عليه',
                                color: cl.role == 'PLAINTIFF' ? Colors.blue : Colors.red,
                              ),
                            if (_clients.length > 1) ...[
                              const SizedBox(width: 6),
                              IconButton(
                                icon: const Icon(Icons.delete_outline,
                                    color: Colors.red, size: 20),
                                tooltip: 'حذف هذا الموكل',
                                visualDensity: VisualDensity.compact,
                                onPressed: () {
                                  setState(() {
                                    cl.dispose();
                                    _clients.removeAt(idx);
                                  });
                                },
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    clientsAsync.when(
                      data: (clients) => RawAutocomplete<Client>(
                        textEditingController: cl.nameCtrl,
                        focusNode: FocusNode(),
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text.isEmpty) {
                            return const Iterable<Client>.empty();
                          }
                          return clients.where((Client option) {
                            return option.fullName
                                .contains(textEditingValue.text.trim());
                          });
                        },
                        displayStringForOption: (Client option) => option.fullName,
                        onSelected: (Client selection) {
                          cl.nameCtrl.text = selection.fullName;
                          cl.phones.clear();
                          if (selection.phone.isNotEmpty) {
                            cl.phones.addAll(_parsePhones(selection.phone));
                          }
                          if (selection.phoneSecondary != null &&
                              selection.phoneSecondary!.isNotEmpty) {
                            cl.phones.addAll(_parsePhones(selection.phoneSecondary!));
                          }
                          if (selection.address != null &&
                              selection.address!.isNotEmpty) {
                            final addr = selection.address!;
                            if (addr.contains(' • المختار: ')) {
                              final p = addr.split(' • المختار: ');
                              cl.addressCtrl.text =
                                  p[0].replaceFirst('الإقامة: ', '').trim();
                              cl.mukhtarCtrl.text =
                                  p.length > 1 ? p[1].trim() : '';
                            } else {
                              cl.addressCtrl.text =
                                  addr.replaceFirst('الإقامة: ', '').trim();
                            }
                          }
                          cl.nationalIdCtrl.text = selection.nationalId ?? '';
                          setState(() {});
                        },
                        fieldViewBuilder:
                            (context, controller, focusNode, onEditingComplete) {
                          return AppTextField(
                            controller: controller,
                            focusNode: focusNode,
                            label: 'اسم الموكل الكامل *',
                            hint: 'الاسم الكامل',
                            prefixIcon: Icons.person,
                            validator: (v) => idx == 0 && (v == null || v.trim().isEmpty)
                                ? 'يرجى كتابة اسم الموكل (إجباري)'
                                : null,
                          );
                        },
                        optionsViewBuilder: (context, onSelected, options) {
                          return Align(
                            alignment: Alignment.topRight,
                            child: Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(8),
                              child: ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxHeight: 200, maxWidth: 320),
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount: options.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final Client option = options.elementAt(index);
                                    return ListTile(
                                      leading: const Icon(Icons.person_pin, size: 20),
                                      title: Text(option.fullName),
                                      subtitle: Text(option.phone),
                                      onTap: () => onSelected(option),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      loading: () => AppTextField(
                        controller: cl.nameCtrl,
                        label: 'اسم الموكل الكامل *',
                        hint: 'الاسم الكامل',
                        prefixIcon: Icons.person,
                        validator: (v) => idx == 0 && (v == null || v.trim().isEmpty)
                            ? 'يرجى كتابة اسم الموكل (إجباري)'
                            : null,
                      ),
                      error: (_, __) => AppTextField(
                        controller: cl.nameCtrl,
                        label: 'اسم الموكل الكامل *',
                        hint: 'الاسم الكامل',
                        prefixIcon: Icons.person,
                        validator: (v) => idx == 0 && (v == null || v.trim().isEmpty)
                            ? 'يرجى كتابة اسم الموكل (إجباري)'
                            : null,
                      ),
                    ),
                    const SizedBox(height: 6),

                    // بيانات الموكل الإضافية (هواتف وعناوين)
                    Theme(
                      data: theme.copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        tilePadding: EdgeInsets.zero,
                        dense: true,
                        title: Text(
                          'بيانات الاتصال والعنوان للموكل ${idx + 1}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        initiallyExpanded: cl.isDetailsExpanded,
                        onExpansionChanged: (v) =>
                            setState(() => cl.isDetailsExpanded = v),
                        children: [
                          _buildPhoneListSection(
                            theme: theme,
                            title: 'أرقام هواتف الموكل',
                            phones: cl.phones,
                            newPhoneCtrl: cl.newPhoneCtrl,
                            newPhoneType: cl.newPhoneType,
                            onTypeChanged: (t) =>
                                setState(() => cl.newPhoneType = t),
                            onAdd: () {
                              final num = cl.newPhoneCtrl.text.trim();
                              if (num.isNotEmpty) {
                                setState(() {
                                  cl.phones.add((type: cl.newPhoneType, number: num));
                                  cl.newPhoneCtrl.clear();
                                });
                              }
                            },
                            onRemove: (pIdx) =>
                                setState(() => cl.phones.removeAt(pIdx)),
                          ),
                          const SizedBox(height: 8),
                          AppTextField(
                            controller: cl.nationalIdCtrl,
                            label: 'الرقم الوطني',
                            hint: '11111111111',
                            keyboardType: TextInputType.number,
                            prefixIcon: Icons.badge_outlined,
                          ),
                          const SizedBox(height: 8),
                          AppTextField(
                            controller: cl.addressCtrl,
                            label: 'عنوان الإقامة',
                            hint: 'الميدان',
                            prefixIcon: Icons.home_outlined,
                          ),
                          const SizedBox(height: 8),
                          AppTextField(
                            controller: cl.mukhtarCtrl,
                            label: 'عنوان المختار',
                            hint: 'مختار الميدان',
                            prefixIcon: Icons.location_city_outlined,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 12),

            // ================= 2. الخصوم (الأطراف المقابلة - يدعم خصوماً متعددين) =================
            SizedBox(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                runSpacing: 4,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.shield_outlined,
                          size: 20, color: Colors.red.shade700),
                      const SizedBox(width: 8),
                      Text(
                        'الخصوم (${_opponents.length})',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        final primaryRole = _clients.isNotEmpty ? _clients.first.role : 'PLAINTIFF';
                        final oppRole = (primaryRole == 'PLAINTIFF') ? 'DEFENDANT' : 'PLAINTIFF';
                        _opponents.add(_OpponentFormData()..role = oppRole);
                      });
                    },
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('إضافة خصم +'),
                    style: TextButton.styleFrom(
                      visualDensity: VisualDensity.compact,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            ..._opponents.asMap().entries.map((entry) {
              final idx = entry.key;
              final opp = entry.value;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.cardTheme.color,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: opp.role == 'PLAINTIFF'
                        ? Colors.blue.withAlpha(60)
                        : Colors.red.withAlpha(60),
                    width: 1.2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'الخصم ${idx + 1}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: theme.hintColor,
                          ),
                        ),
                        Row(
                          children: [
                            if (idx == 0)
                              _buildRoleToggle(
                                currentRole: opp.role,
                                onChanged: (r) {
                                  setState(() {
                                    opp.role = r;
                                    for (final otherOpp in _opponents) {
                                      otherOpp.role = r;
                                    }
                                  });
                                },
                                theme: theme,
                              )
                            else
                              AppStatusBadge(
                                label: opp.role == 'PLAINTIFF' ? 'مدعي' : 'مدعى عليه',
                                color: opp.role == 'PLAINTIFF' ? Colors.blue : Colors.red,
                              ),
                            if (_opponents.length > 1) ...[
                              const SizedBox(width: 6),
                              IconButton(
                                icon: const Icon(Icons.delete_outline,
                                    color: Colors.red, size: 20),
                                tooltip: 'حذف هذا الخصم',
                                visualDensity: VisualDensity.compact,
                                onPressed: () {
                                  setState(() {
                                    opp.dispose();
                                    _opponents.removeAt(idx);
                                  });
                                },
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: opp.nameCtrl,
                      label: 'اسم الخصم الكامل',
                      hint: 'الاسم الكامل',
                      prefixIcon: Icons.person_outline,
                    ),
                    const SizedBox(height: 6),

                    // بيانات الخصم الإضافية (هواتف وعناوين)
                    Theme(
                      data: theme.copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        tilePadding: EdgeInsets.zero,
                        dense: true,
                        title: Text(
                          'بيانات الاتصال والعنوان للخصم ${idx + 1}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        initiallyExpanded: opp.isDetailsExpanded,
                        onExpansionChanged: (v) =>
                            setState(() => opp.isDetailsExpanded = v),
                        children: [
                          _buildPhoneListSection(
                            theme: theme,
                            title: 'أرقام هواتف الخصم',
                            phones: opp.phones,
                            newPhoneCtrl: opp.newPhoneCtrl,
                            newPhoneType: opp.newPhoneType,
                            onTypeChanged: (t) =>
                                setState(() => opp.newPhoneType = t),
                            onAdd: () {
                              final num = opp.newPhoneCtrl.text.trim();
                              if (num.isNotEmpty) {
                                setState(() {
                                  opp.phones.add((type: opp.newPhoneType, number: num));
                                  opp.newPhoneCtrl.clear();
                                });
                              }
                            },
                            onRemove: (pIdx) =>
                                setState(() => opp.phones.removeAt(pIdx)),
                          ),
                          const SizedBox(height: 8),
                          AppTextField(
                            controller: opp.nationalIdCtrl,
                            label: 'الرقم الوطني',
                            hint: '11111111111',
                            keyboardType: TextInputType.number,
                            prefixIcon: Icons.badge_outlined,
                          ),
                          const SizedBox(height: 8),
                          AppTextField(
                            controller: opp.addressCtrl,
                            label: 'عنوان الإقامة',
                            hint: 'الميدان',
                            prefixIcon: Icons.home_outlined,
                          ),
                          const SizedBox(height: 8),
                          AppTextField(
                            controller: opp.mukhtarCtrl,
                            label: 'عنوان المختار',
                            hint: 'مختار الميدان',
                            prefixIcon: Icons.location_city_outlined,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 16),

            // ================= 3. حالة القضية عند التسجيل =================
            if (widget.caseId == null) ...[
              Row(
                children: [
                  Icon(Icons.timeline, size: 20, color: theme.colorScheme.primary),
                  const SizedBox(width: 8),
                  const Text(
                    'حالة القضية عند التسجيل',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ChoiceChip(
                    label: const Text('قيد النظر',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    selected: _caseStatus == 'OPEN',
                    avatar: const Icon(Icons.hourglass_top, size: 16),
                    onSelected: (_) => setState(() => _caseStatus = 'OPEN'),
                  ),
                  ChoiceChip(
                    label: const Text('مفصولة',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    selected: _caseStatus == 'CLOSED',
                    avatar: const Icon(Icons.verified, size: 16),
                    onSelected: (_) => setState(() => _caseStatus = 'CLOSED'),
                  ),
                  ChoiceChip(
                    label: const Text('مستأنفة / طعن',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    selected: _caseStatus == 'APPEALED',
                    avatar: const Icon(Icons.upgrade, size: 16),
                    onSelected: (_) {
                      setState(() {
                        _caseStatus = 'APPEALED';
                        if (_pastStages.isEmpty) {
                          _pastStages.add(_ConcludedStageFormData());
                        }
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // بطاقة قرار الفصل في حال كانت القضية مفصولة
              if (_caseStatus == 'CLOSED') ...[
                AppCard(
                  color: Colors.green.withAlpha(20),
                  border: Border.all(color: Colors.green.withAlpha(60)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.verified, color: Colors.green, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'بيانات قرار الفصل',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              icon: const Icon(Icons.calendar_month, size: 18),
                              label: Text(
                                _resolutionDate != null
                                    ? 'تاريخ الفصل: ${AppDateFormatter.formatDate(_resolutionDate!)}'
                                    : 'تاريخ الفصل',
                                style: const TextStyle(fontSize: 13),
                              ),
                              onPressed: () async {
                                final d = await showDatePicker(
                                  context: context,
                                  initialDate: _resolutionDate ?? DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2035),
                                );
                                if (d != null) {
                                  setState(() => _resolutionDate = d);
                                }
                              },
                            ),
                          ),
                          if (_resolutionDate != null)
                            IconButton(
                              icon: const Icon(Icons.clear, size: 18),
                              onPressed: () => setState(() => _resolutionDate = null),
                            ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      AppTextField(
                        controller: _decisionNumberCtrl,
                        label: 'رقم قرار الفصل',
                        hint: 'رقم القرار',
                      ),
                      const SizedBox(height: 10),
                      AppTextField(
                        controller: _decisionRulingCtrl,
                        label: 'قرار الفصل',
                        hint: 'قرار الفصل',
                        enableSpeech: true,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
              ],

              // بطاقات المراحل المفصولة السابقة في حال كانت القضية طعناً أو استئنافاً (يدعم مراحل متعددة)
              if (_caseStatus == 'APPEALED') ...[
                SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.history_edu, color: Colors.purple, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'المراحل المفصولة السابقة (${_pastStages.length})',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.purple,
                            ),
                          ),
                        ],
                      ),
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            _pastStages.add(_ConcludedStageFormData());
                          });
                        },
                        icon: const Icon(Icons.add, size: 16),
                        label: const Text('إضافة مرحلة سابقة +'),
                        style: TextButton.styleFrom(
                          visualDensity: VisualDensity.compact,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                ..._pastStages.asMap().entries.map((entry) {
                  final stgIdx = entry.key;
                  final stg = entry.value;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: AppCard(
                      color: Colors.purple.withAlpha(20),
                      border: Border.all(color: Colors.purple.withAlpha(60)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'المرحلة السابقة ${stgIdx + 1}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.purple,
                                ),
                              ),
                              if (_pastStages.length > 1)
                                IconButton(
                                  icon: const Icon(Icons.delete_outline,
                                      color: Colors.red, size: 20),
                                  tooltip: 'حذف هذه المرحلة',
                                  visualDensity: VisualDensity.compact,
                                  onPressed: () {
                                    setState(() {
                                      stg.dispose();
                                      _pastStages.removeAt(stgIdx);
                                    });
                                  },
                                ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          AppTextField(
                            controller: stg.courtCtrl,
                            label: 'المحكمة السابقة',
                            hint: 'مثال: ب م 7 أو استئناف 8',
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: AppTextField(
                                  controller: stg.caseNumCtrl,
                                  label: 'رقم الأساس',
                                  hint: '26003',
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                flex: 2,
                                child: AppTextField(
                                  controller: stg.yearCtrl,
                                  label: 'العام',
                                  hint: '2024',
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          AppTextField(
                            controller: stg.claimBadgeCtrl,
                            label: 'شارة الدعوى (إن وجدت)',
                            hint: 'رقم 3211 تاريخ 1/10/2024',
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: AppTextField(
                                  controller: stg.decisionNumCtrl,
                                  label: 'رقم قرار الفصل',
                                  hint: '1070',
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                flex: 3,
                                child: OutlinedButton.icon(
                                  icon: const Icon(Icons.calendar_month, size: 16),
                                  label: Text(
                                    stg.decisionDate != null
                                        ? AppDateFormatter.formatDate(stg.decisionDate!)
                                        : 'تاريخ القرار',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  onPressed: () async {
                                    final d = await showDatePicker(
                                      context: context,
                                      initialDate: stg.decisionDate ?? DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2035),
                                    );
                                    if (d != null) {
                                      setState(() => stg.decisionDate = d);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          AppTextField(
                            controller: stg.decisionRulingCtrl,
                            label: 'قرار الفصل',
                            hint: 'قرار الفصل',
                            enableSpeech: true,
                            maxLines: 2,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  icon: const Icon(Icons.mark_email_read, size: 16),
                                  label: Text(
                                    stg.notificationDate != null
                                        ? 'تاريخ التبليغ: ${AppDateFormatter.formatDate(stg.notificationDate!)}'
                                        : 'تاريخ التبليغ',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  onPressed: () async {
                                    final d = await showDatePicker(
                                      context: context,
                                      initialDate: stg.notificationDate ?? DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2035),
                                    );
                                    if (d != null) {
                                      setState(() => stg.notificationDate = d);
                                    }
                                  },
                                ),
                              ),
                              if (stg.notificationDate != null)
                                IconButton(
                                  icon: const Icon(Icons.clear, size: 18),
                                  onPressed: () => setState(() => stg.notificationDate = null),
                                ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          AppTextField(
                            controller: stg.groundsCtrl,
                            label: 'أسباب الاستئناف / الطعن',
                            hint: 'أسباب الطعن',
                            enableSpeech: true,
                            maxLines: 2,
                          ),
                          const SizedBox(height: 10),
                          // جلسات وإجراءات هذه المرحلة
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'جلسات وإجراءات هذه المرحلة (${stg.hearings.length})',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  icon: const Icon(Icons.calendar_month, size: 16),
                                  label: Text(
                                    AppDateFormatter.formatDate(stg.newHearingDate),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  onPressed: () async {
                                    final d = await showDatePicker(
                                      context: context,
                                      initialDate: stg.newHearingDate,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2035),
                                    );
                                    if (d != null) {
                                      setState(() => stg.newHearingDate = d);
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                flex: 2,
                                child: AppTextField(
                                  controller: stg.newHearingActionCtrl,
                                  label: 'الإجراء / الجلسة',
                                  hint: 'تبليغ / استمهال / تدقيق',
                                ),
                              ),
                              const SizedBox(width: 6),
                              IconButton.filled(
                                icon: const Icon(Icons.add, size: 18),
                                onPressed: () {
                                  final actionText = stg.newHearingActionCtrl.text.trim();
                                  final resolvedAction = actionText.isNotEmpty ? actionText : 'جلسة';
                                  setState(() {
                                    stg.hearings.add((
                                      date: stg.newHearingDate.millisecondsSinceEpoch,
                                      action: resolvedAction,
                                      decision: null,
                                    ));
                                    stg.newHearingActionCtrl.clear();
                                  });
                                },
                              ),
                            ],
                          ),
                          if (stg.hearings.isNotEmpty) ...[
                            const SizedBox(height: 6),
                            ...stg.hearings.asMap().entries.map((hEntry) {
                              final hIdx = hEntry.key;
                              final h = hEntry.value;
                              return Container(
                                margin: const EdgeInsets.only(bottom: 4),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.surface,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${AppDateFormatter.formatDate(DateTime.fromMillisecondsSinceEpoch(h.date))}: ${h.action}',
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.close,
                                          size: 16, color: Colors.red),
                                      onPressed: () => setState(() =>
                                          stg.hearings.removeAt(hIdx)),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ],
                        ],
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 14),
              ],
            ],

            // 4. رقم الأساس والمحكمة
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: AppTextField(
                    controller: _caseNumberCtrl,
                    label: 'رقم الأساس',
                    hint: '1450',
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: AppTextField(
                    controller: _caseYearCtrl,
                    label: 'السنة',
                    hint: '2026',
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // 4. المحكمة المختصة (خيار إضافة محكمة جديدة في أسفل القائمة بعرض يطابق زر الاختيار)
            courtsAsync.when(
              data: (courts) {
                return InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'المحكمة المختصة',
                    prefixIcon: Icon(Icons.account_balance),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      menuWidth: MediaQuery.of(context).size.width - 32,
                      menuMaxHeight: 320,
                      borderRadius: BorderRadius.circular(12),
                      value: _selectedCourtId,
                      hint: const Text('اختر المحكمة المختصة...'),
                      items: [
                        ...courts.map((ct) => DropdownMenuItem<String>(
                              value: ct.id,
                              child: Text(ct.name,
                                  overflow: TextOverflow.ellipsis),
                            )),
                        const DropdownMenuItem<String>(
                          value: '__ADD_NEW_COURT__',
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.add_circle_outline,
                                  color: Colors.blue, size: 18),
                              SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  '+ إضافة محكمة مختصة جديدة...',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      onChanged: (v) {
                        if (v == '__ADD_NEW_COURT__') {
                          _showAddCourtDialog();
                        } else {
                          setState(() => _selectedCourtId = v);
                        }
                      },
                    ),
                  ),
                );
              },
              loading: () => const LinearProgressIndicator(),
              error: (_, _) => const SizedBox(),
            ),
            const SizedBox(height: 14),

            // 5. نوع الدعوى (فارغة في البداية مع إضافة نوع دعوى جديد في الأسفل بعرض يطابق زر الاختيار)
            InputDecorator(
              decoration: const InputDecoration(
                labelText: 'نوع الدعوى',
                prefixIcon: Icon(Icons.gavel),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  menuWidth: MediaQuery.of(context).size.width - 32,
                  menuMaxHeight: 320,
                  borderRadius: BorderRadius.circular(12),
                  value: _selectedCaseType,
                  hint: const Text('اختر نوع الدعوى أو أضف نوعاً جديداً'),
                  items: [
                    ..._customCaseTypes.map((t) => DropdownMenuItem<String>(
                          value: t,
                          child: Text(t, overflow: TextOverflow.ellipsis),
                        )),
                    const DropdownMenuItem<String>(
                      value: '__ADD_NEW_TYPE__',
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add_circle_outline,
                              color: Colors.blue, size: 18),
                          SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              '+ إضافة نوع دعوى جديد...',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  onChanged: (v) {
                    if (v == '__ADD_NEW_TYPE__') {
                      _showAddCaseTypeDialog();
                    } else {
                      setState(() => _selectedCaseType = v);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 6. مستطيل الجلسات القضائية بجانبه دائرة للإضافة
            AppCard(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.event_seat,
                              color: theme.colorScheme.primary),
                          const SizedBox(width: 8),
                          Text(
                            'جلسات المحاكمة (${_hearings.length})',
                            style: theme.textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      IconButton.filled(
                        icon: Icon(
                            _isHearingsExpanded ? Icons.close : Icons.add),
                        onPressed: () {
                          setState(() {
                            _isHearingsExpanded = !_isHearingsExpanded;
                            if (_isHearingsExpanded) {
                              _isTasksExpanded = false;
                            }
                          });
                        },
                        tooltip: 'إضافة جلسة',
                      ),
                    ],
                  ),
                  if (_isHearingsExpanded) ...[
                    const Divider(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.calendar_month, size: 18),
                            label: Text(
                              AppDateFormatter.formatDate(_newHearingDate),
                              style: const TextStyle(fontSize: 13),
                            ),
                            onPressed: () async {
                              final d = await showDatePicker(
                                context: context,
                                initialDate: _newHearingDate,
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2035),
                              );
                              if (d != null) {
                                setState(() => _newHearingDate = d);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: _newHearingActionCtrl,
                      label: 'العمل المطلوب *',
                      hint: 'مرافعة / استجواب شهود',
                      enableSpeech: true,
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ElevatedButton.icon(
                        onPressed: _addHearing,
                        icon: const Icon(Icons.check, size: 18),
                        label: const Text('حفظ الجلسة في القائمة'),
                      ),
                    ),
                  ],
                  if (_hearings.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    ..._hearings.map((h) {
                      final hDate =
                          DateTime.fromMillisecondsSinceEpoch(h.date);
                      final isPostponed = h.status == 'POSTPONED';
                      final isAttended = h.status == 'ATTENDED';

                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          color: isPostponed
                              ? Colors.orange.withAlpha(20)
                              : Colors.teal.withAlpha(20),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isPostponed
                                ? Colors.orange.withAlpha(60)
                                : Colors.teal.withAlpha(60),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isPostponed
                                  ? Icons.update
                                  : Icons.event_available,
                              size: 20,
                              color: isPostponed ? Colors.orange : Colors.teal,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppDateFormatter.formatDate(hDate),
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    h.action,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            if (h.status != null) ...[
                              AppStatusBadge(
                                label: isPostponed
                                    ? 'مؤجلة'
                                    : (isAttended ? 'منجزة' : 'مجدولة'),
                                color: isPostponed
                                    ? Colors.orange
                                    : (isAttended ? Colors.green : Colors.blue),
                              ),
                              const SizedBox(width: 6),
                            ],
                            IconButton(
                              icon: const Icon(Icons.delete_outline,
                                  size: 20, color: Colors.red),
                              tooltip: 'حذف الجلسة',
                              onPressed: () =>
                                  setState(() => _hearings.remove(h)),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 7. مستطيل الأعمال والإجراءات القضائية الأخرى بجانبه دائرة للإضافة
            AppCard(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.assignment_outlined,
                              color: Colors.amber.shade800),
                          const SizedBox(width: 8),
                          Text(
                            'أعمال وإجراءات أخرى (${_tasks.length})',
                            style: theme.textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      IconButton.filled(
                        icon:
                            Icon(_isTasksExpanded ? Icons.close : Icons.add),
                        onPressed: () {
                          setState(() {
                            _isTasksExpanded = !_isTasksExpanded;
                            if (_isTasksExpanded) {
                              _isHearingsExpanded = false;
                            }
                          });
                        },
                        tooltip: 'إضافة عمل قضائي',
                      ),
                    ],
                  ),
                  if (_isTasksExpanded) ...[
                    const Divider(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.calendar_month, size: 18),
                            label: Text(
                              AppDateFormatter.formatDate(_newTaskDate),
                              style: const TextStyle(fontSize: 13),
                            ),
                            onPressed: () async {
                              final d = await showDatePicker(
                                context: context,
                                initialDate: _newTaskDate,
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2035),
                              );
                              if (d != null) {
                                setState(() => _newTaskDate = d);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: _newTaskTitleCtrl,
                      label: 'العمل المطلوب *',
                      hint: 'مراجعة الديوان / إخراج قيد',
                      enableSpeech: true,
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ElevatedButton.icon(
                        onPressed: _addTask,
                        icon: const Icon(Icons.check, size: 18),
                        label: const Text('إضافة الإجراء'),
                      ),
                    ),
                  ],
                  if (_tasks.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    ..._tasks.map((t) {
                      final tDate =
                          DateTime.fromMillisecondsSinceEpoch(t.date);
                      return Container(
                        margin: const EdgeInsets.only(bottom: 6),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.amber.withAlpha(20),
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: Colors.amber.withAlpha(60)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.task_alt,
                                size: 18, color: Colors.amber.shade800),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '${AppDateFormatter.formatDate(tDate)}: ${t.title}',
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline,
                                  size: 18, color: Colors.red),
                              onPressed: () =>
                                  setState(() => _tasks.remove(t)),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 10. إرفاق الملفات مع إمكانية تعديل الاسم
            AppCard(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'إرفاق وثائق الدعوى',
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      OutlinedButton.icon(
                        onPressed: _pickFiles,
                        icon: const Icon(Icons.attach_file, size: 18),
                        label: const Text('إرفاق ملفات'),
                      ),
                    ],
                  ),
                  if (_attachedFiles.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Column(
                      children: _attachedFiles.asMap().entries.map((entry) {
                        final idx = entry.key;
                        final item = entry.value;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 6),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest
                                .withAlpha(60),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.insert_drive_file, size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  item.displayName,
                                  style: const TextStyle(fontSize: 13),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit,
                                    size: 18, color: Colors.blue),
                                tooltip: 'تعديل اسم الملف',
                                onPressed: () => _renameAttachedFile(idx),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline,
                                    size: 18, color: Colors.red),
                                tooltip: 'حذف من المرفقات',
                                onPressed: () =>
                                  setState(() => _attachedFiles.removeAt(idx)),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 11. ملاحظاتي
            AppTextField(
              controller: _notesCtrl,
              label: 'ملاحظاتي',
              hint: 'ملاحظات...',
              enableSpeech: true,
              prefixIcon: Icons.edit_note,
              maxLines: 3,
            ),
            const SizedBox(height: 16),

            // 12. الأتعاب والمدفوعات
            AppCard(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.payments_outlined, color: Colors.green),
                      SizedBox(width: 8),
                      Text(
                        'الأتعاب والمقبوضات',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // اختيار العملة بترتيب ثابت وحجم ثابت لا يتغير
                  SizedBox(
                    width: double.infinity,
                    child: SegmentedButton<String>(
                      showSelectedIcon: false,
                      segments: const [
                        ButtonSegment(value: 'SYP', label: Text('ل.س')),
                        ButtonSegment(value: 'USD', label: Text('دولار')),
                        ButtonSegment(value: 'EUR', label: Text('يورو')),
                      ],
                      selected: {_selectedCurrency},
                      onSelectionChanged: (set) =>
                          setState(() => _selectedCurrency = set.first),
                    ),
                  ),
                  const SizedBox(height: 14),
                  AppTextField(
                    controller: _agreedFeeCtrl,
                    label: 'إجمالي الأتعاب المتفق عليها',
                    hint: '5000000',
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 12),
                  AppTextField(
                    controller: _paidAmountCtrl,
                    label: 'الدفعة المسددة (المقبوضة)',
                    hint: '1500000',
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 13. زر القيد النهائي
            ElevatedButton(
              onPressed: _isSubmitting ? null : _submit,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: Colors.white,
              ),
              child: _isSubmitting
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : Text(
                      widget.caseId == null
                          ? 'قيد القضية في السجل'
                          : 'حفظ التعديلات',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
