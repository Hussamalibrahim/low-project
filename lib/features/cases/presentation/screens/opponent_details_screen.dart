import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/database/app_database.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_confirm_dialog.dart';
import '../../../../shared/widgets/app_status_badge.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../providers/cases_provider.dart';

class OpponentDetailsScreen extends ConsumerStatefulWidget {
  final String caseId;
  final CaseParty? party;

  const OpponentDetailsScreen({
    super.key,
    required this.caseId,
    this.party,
  });

  @override
  ConsumerState<OpponentDetailsScreen> createState() =>
      _OpponentDetailsScreenState();
}

class _OpponentDetailsScreenState extends ConsumerState<OpponentDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  late bool _isEditing;
  late String _role;

  final _nameCtrl = TextEditingController();
  final List<({String type, String number})> _phones = [];
  final _newPhoneCtrl = TextEditingController();
  String _newPhoneType = 'محمول';

  final _nationalIdCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _mukhtarCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.party == null;
    _role = widget.party?.role ?? 'DEFENDANT';

    if (widget.party != null) {
      _loadPartyData(widget.party!);
    }
  }

  void _loadPartyData(CaseParty p) {
    _nameCtrl.text = p.name;
    _role = p.role;

    _phones.clear();
    if (p.lawyerPhone != null && p.lawyerPhone!.isNotEmpty) {
      _phones.addAll(_parsePhones(p.lawyerPhone!));
    }

    // استخراج العنوان والمختار والرقم الوطني من الملاحظات
    if (p.notes != null && p.notes!.isNotEmpty) {
      final segments = p.notes!.split(' • ');
      final remainingNotes = <String>[];

      for (final seg in segments) {
        if (seg.startsWith('الرقم الوطني: ')) {
          _nationalIdCtrl.text =
              seg.substring('الرقم الوطني: '.length).trim();
        } else if (seg.startsWith('العنوان: ')) {
          final addrFull = seg.substring('العنوان: '.length).trim();
          if (addrFull.contains(' • المختار: ')) {
            final addrParts = addrFull.split(' • المختار: ');
            _addressCtrl.text =
                addrParts[0].replaceFirst('الإقامة: ', '').trim();
            _mukhtarCtrl.text = addrParts.length > 1 ? addrParts[1].trim() : '';
          } else {
            _addressCtrl.text = addrFull.replaceFirst('الإقامة: ', '').trim();
          }
        } else if (seg.startsWith('المختار: ')) {
          _mukhtarCtrl.text = seg.substring('المختار: '.length).trim();
        } else if (seg.startsWith('المهنة: ')) {
          // المهنة محذوفة حسب طلب المستخدم
        } else {
          remainingNotes.add(seg);
        }
      }

      if (remainingNotes.isNotEmpty) {
        _notesCtrl.text = remainingNotes.join(' • ');
      }
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
    _nameCtrl.dispose();
    _newPhoneCtrl.dispose();
    _nationalIdCtrl.dispose();
    _addressCtrl.dispose();
    _mukhtarCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final name = _nameCtrl.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى كتابة اسم الخصم (إجباري)')),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      // تجميع أرقام الهواتف
      if (_newPhoneCtrl.text.trim().isNotEmpty) {
        _phones.add((type: _newPhoneType, number: _newPhoneCtrl.text.trim()));
        _newPhoneCtrl.clear();
      }
      final resolvedPhone = _phones.isNotEmpty
          ? _phones.map((p) => '${p.number} (${p.type})').join(' • ')
          : null;

      // تجميع العنوان والمختار
      final addrParts = <String>[];
      if (_addressCtrl.text.trim().isNotEmpty) {
        addrParts.add(_addressCtrl.text.trim());
      }
      if (_mukhtarCtrl.text.trim().isNotEmpty) {
        addrParts.add('المختار: ${_mukhtarCtrl.text.trim()}');
      }
      final resolvedAddress = addrParts.join(' • ');

      // تجميع الملاحظات الشاملة للخصم
      final noteParts = <String>[];
      if (_nationalIdCtrl.text.trim().isNotEmpty) {
        noteParts.add('الرقم الوطني: ${_nationalIdCtrl.text.trim()}');
      }
      if (resolvedAddress.isNotEmpty) {
        noteParts.add('العنوان: $resolvedAddress');
      }
      if (_notesCtrl.text.trim().isNotEmpty) {
        noteParts.add(_notesCtrl.text.trim());
      }
      final resolvedNotes = noteParts.isNotEmpty ? noteParts.join(' • ') : null;

      final repo = ref.read(casesRepositoryProvider);

      if (widget.party == null) {
        await repo.addCaseParty(
          caseId: widget.caseId,
          name: name,
          role: _role,
          phone: resolvedPhone,
          notes: resolvedNotes,
        );
      } else {
        await repo.updateCaseParty(
          partyId: widget.party!.id,
          name: name,
          role: _role,
          phone: resolvedPhone,
          notes: resolvedNotes,
        );
      }

      ref.invalidate(caseWithDetailsProvider(widget.caseId));
      ref.invalidate(caseListItemsStreamProvider);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.party == null
                  ? 'تمت إضافة الخصم ($name) بنجاح'
                  : 'تم حفظ تعديلات الخصم ($name) بنجاح',
            ),
            backgroundColor: Colors.green,
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ أثناء الحفظ: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _deleteOpponent() async {
    if (widget.party == null) return;

    final ok = await AppConfirmDialog.show(
      context,
      title: 'حذف الخصم',
      message: 'هل أنت متأكد من حذف الخصم (${widget.party!.name}) من القضية؟',
      confirmLabel: 'حذف',
      isDestructive: true,
    );

    if (ok) {
      await ref
          .read(casesRepositoryProvider)
          .deleteCaseParty(widget.party!.id);
      ref.invalidate(caseWithDetailsProvider(widget.caseId));
      ref.invalidate(caseListItemsStreamProvider);
      if (mounted) {
        context.pop();
      }
    }
  }

  Widget _buildRoleToggle(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    final unselectedBg =
        isDark ? const Color(0xFF0F172A) : const Color(0xFFE2E8F0);
    final unselectedFg =
        isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569);

    return Container(
      decoration: BoxDecoration(
        color: unselectedBg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => setState(() => _role = 'DEFENDANT'),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: _role == 'DEFENDANT'
                    ? Colors.red.shade700
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'مدعى عليه',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: _role == 'DEFENDANT' ? Colors.white : unselectedFg,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => setState(() => _role = 'PLAINTIFF'),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: _role == 'PLAINTIFF'
                    ? theme.colorScheme.primary
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'مدعي',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: _role == 'PLAINTIFF' ? Colors.white : unselectedFg,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneListSection(ThemeData theme) {
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
              'أرقام هواتف الخصم (${_phones.length})',
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
                  value: _newPhoneType,
                  isDense: true,
                  items: const [
                    DropdownMenuItem(value: 'محمول', child: Text('محمول')),
                    DropdownMenuItem(value: 'واتساب', child: Text('واتساب')),
                    DropdownMenuItem(value: 'هاتف', child: Text('هاتف')),
                  ],
                  onChanged: (v) {
                    if (v != null) setState(() => _newPhoneType = v);
                  },
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: SizedBox(
                height: 48,
                child: TextField(
                  controller: _newPhoneCtrl,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: '09xxxxxxxx',
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    prefixIcon: Icon(
                      _newPhoneType == 'واتساب'
                          ? Icons.chat
                          : (_newPhoneType == 'هاتف'
                              ? Icons.phone
                              : Icons.phone_android),
                      size: 18,
                    ),
                  ),
                  onSubmitted: (_) {
                    final num = _newPhoneCtrl.text.trim();
                    if (num.isNotEmpty) {
                      setState(() {
                        _phones.add((type: _newPhoneType, number: num));
                        _newPhoneCtrl.clear();
                      });
                    }
                  },
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton.filled(
              icon: const Icon(Icons.add, size: 20),
              tooltip: 'إضافة رقم هاتف',
              onPressed: () {
                final num = _newPhoneCtrl.text.trim();
                if (num.isNotEmpty) {
                  setState(() {
                    _phones.add((type: _newPhoneType, number: num));
                    _newPhoneCtrl.clear();
                  });
                }
              },
            ),
          ],
        ),
        if (_phones.isNotEmpty) ...[
          const SizedBox(height: 10),
          ..._phones.asMap().entries.map((entry) {
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
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
                    onPressed: () => setState(() => _phones.removeAt(idx)),
                  ),
                ],
              ),
            );
          }),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditing
              ? (widget.party == null
                  ? 'إضافة خصم في الدعوى'
                  : 'تعديل بيانات الخصم')
              : 'بيانات الخصم',
        ),
        actions: [
          if (!_isEditing && widget.party != null) ...[
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              tooltip: 'تعديل بيانات الخصم',
              onPressed: () => setState(() => _isEditing = true),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              tooltip: 'حذف الخصم',
              onPressed: _deleteOpponent,
            ),
          ],
          if (_isEditing && widget.party != null)
            IconButton(
              icon: const Icon(Icons.close),
              tooltip: 'إلغاء التعديل',
              onPressed: () {
                _loadPartyData(widget.party!);
                setState(() => _isEditing = false);
              },
            ),
        ],
      ),
      body: _isEditing ? _buildEditForm(theme) : _buildViewBody(theme),
    );
  }

  Widget _buildViewBody(ThemeData theme) {
    final p = widget.party!;
    final isPlaintiff = p.role == 'PLAINTIFF';

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // بطاقة الخصم الرئيسية
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor:
                        isPlaintiff ? Colors.blue.shade700 : Colors.red.shade700,
                    child: const Icon(
                      Icons.person_outline,
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
                          p.name,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 6),
                        AppStatusBadge(
                          label: isPlaintiff ? 'مدعي' : 'مدعى عليه',
                          color: isPlaintiff ? Colors.blue : Colors.red,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // بطاقة الهواتف والاتصال
        if (p.lawyerPhone != null && p.lawyerPhone!.isNotEmpty) ...[
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.phone_outlined,
                        color: theme.colorScheme.primary, size: 20),
                    const SizedBox(width: 8),
                    const Text(
                      'أرقام الهاتف والاتصال',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ],
                ),
                const Divider(height: 18),
                ...p.lawyerPhone!.split(' • ').map((phoneEntry) {
                  final cleanNum = phoneEntry
                      .replaceAll(RegExp(r'\s*\([^)]*\)'), '')
                      .trim();
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            phoneEntry,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.copy, size: 18, color: Colors.grey),
                          tooltip: 'نسخ الرقم',
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: cleanNum));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('تم نسخ الرقم ($cleanNum)')),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 14),
        ],

        // بطاقة العناوين والبيانات الشخصية
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.badge_outlined,
                      color: theme.colorScheme.primary, size: 20),
                  const SizedBox(width: 8),
                  const Text(
                    'البيانات الرسمية والعناوين',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
              const Divider(height: 18),
              if (_nationalIdCtrl.text.isNotEmpty)
                _buildInfoRow('الرقم الوطني', _nationalIdCtrl.text),
              if (_addressCtrl.text.isNotEmpty)
                _buildInfoRow('عنوان الإقامة', _addressCtrl.text),
              if (_mukhtarCtrl.text.isNotEmpty)
                _buildInfoRow('عنوان المختار', _mukhtarCtrl.text),
              if (_nationalIdCtrl.text.isEmpty &&
                  _addressCtrl.text.isEmpty &&
                  _mukhtarCtrl.text.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'لم يتم إدخال بيانات رسمية أو عنوان إقامة بعد.',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ),
            ],
          ),
        ),

        // بطاقة الملاحظات إن وجدت
        if (_notesCtrl.text.isNotEmpty) ...[
          const SizedBox(height: 14),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.note_alt_outlined, color: Colors.amber, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'ملاحظات إضافية',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ],
                ),
                const Divider(height: 18),
                Text(_notesCtrl.text, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ],

        const SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: () => setState(() => _isEditing = true),
          icon: const Icon(Icons.edit),
          label: const Text(
            'تعديل بيانات الخصم',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildEditForm(ThemeData theme) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 1. صفة الخصم
          Row(
            children: [
              const Text(
                'صفة الخصم في الدعوى',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(width: 12),
              _buildRoleToggle(theme),
            ],
          ),
          const SizedBox(height: 14),

          // 2. اسم الخصم
          AppTextField(
            controller: _nameCtrl,
            label: 'اسم الخصم الكامل *',
            hint: 'الاسم الكامل',
            prefixIcon: Icons.person_outline,
            validator: (v) => v == null || v.trim().isEmpty
                ? 'يرجى كتابة اسم الخصم (إجباري)'
                : null,
          ),
          const SizedBox(height: 16),

          // 3. أرقام الهواتف (قائمة ديناميكية حتى 10+ أرقام)
          _buildPhoneListSection(theme),
          const SizedBox(height: 16),

          // 4. الرقم الوطني
          AppTextField(
            controller: _nationalIdCtrl,
            label: 'الرقم الوطني',
            hint: '11111111111',
            keyboardType: TextInputType.number,
            prefixIcon: Icons.badge_outlined,
          ),
          const SizedBox(height: 14),

          // 5. عنوان الإقامة
          AppTextField(
            controller: _addressCtrl,
            label: 'عنوان الإقامة',
            hint: 'الميدان',
            prefixIcon: Icons.home_outlined,
          ),
          const SizedBox(height: 14),

          // 6. عنوان المختار
          AppTextField(
            controller: _mukhtarCtrl,
            label: 'عنوان المختار',
            hint: 'مختار الميدان',
            prefixIcon: Icons.location_city_outlined,
          ),
          const SizedBox(height: 14),

          // 7. ملاحظات إضافية مع تسجيل صوتي
          AppTextField(
            controller: _notesCtrl,
            label: 'ملاحظات إضافية عن الخصم',
            hint: 'ملاحظات...',
            enableSpeech: true,
            prefixIcon: Icons.edit_note,
            maxLines: 3,
          ),
          const SizedBox(height: 24),

          // 8. زر الحفظ
          ElevatedButton(
            onPressed: _isSaving ? null : _save,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: Colors.white,
            ),
            child: _isSaving
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white),
                  )
                : Text(
                    widget.party == null
                        ? 'إضافة الخصم للقضية'
                        : 'حفظ التعديلات',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
