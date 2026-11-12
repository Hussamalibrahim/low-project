import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../providers/clients_provider.dart';

class AddEditClientScreen extends ConsumerStatefulWidget {
  final String? clientId;

  const AddEditClientScreen({super.key, this.clientId});

  @override
  ConsumerState<AddEditClientScreen> createState() =>
      _AddEditClientScreenState();
}

class _AddEditClientScreenState extends ConsumerState<AddEditClientScreen> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _phoneSecCtrl = TextEditingController();
  final _nationalIdCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _companyNameCtrl = TextEditingController();
  final _commercialRecordCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();

  String _clientType = 'INDIVIDUAL';
  bool _isInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit && widget.clientId != null) {
      _loadExistingClient();
      _isInit = true;
    }
  }

  Future<void> _loadExistingClient() async {
    final client = await ref
        .read(clientsRepositoryProvider)
        .getClientById(widget.clientId!);
    if (client != null && mounted) {
      setState(() {
        _clientType = client.clientType;
        _fullNameCtrl.text = client.fullName;
        _phoneCtrl.text = client.phone;
        _phoneSecCtrl.text = client.phoneSecondary ?? '';
        _nationalIdCtrl.text = client.nationalId ?? '';
        _emailCtrl.text = client.email ?? '';
        _addressCtrl.text = client.address ?? '';
        _companyNameCtrl.text = client.companyName ?? '';
        _commercialRecordCtrl.text = client.commercialRecord ?? '';
        _notesCtrl.text = client.notes ?? '';
      });
    }
  }

  @override
  void dispose() {
    _fullNameCtrl.dispose();
    _phoneCtrl.dispose();
    _phoneSecCtrl.dispose();
    _nationalIdCtrl.dispose();
    _emailCtrl.dispose();
    _addressCtrl.dispose();
    _companyNameCtrl.dispose();
    _commercialRecordCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final repo = ref.read(clientsRepositoryProvider);

    // التحقق من منع التكرار بالرقم الوطني إن وجد
    if (_nationalIdCtrl.text.trim().isNotEmpty) {
      final exists = await repo.checkNationalIdExists(
        _nationalIdCtrl.text.trim(),
        excludeClientId: widget.clientId,
      );
      if (exists && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'تنبيه: يوجد موكل آخر مسجل مسبقاً بنفس الرقم الوطني منعاً للازدواجية',
            ),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    if (widget.clientId == null) {
      await repo.createClient(
        clientType: _clientType,
        fullName: _fullNameCtrl.text,
        phone: _phoneCtrl.text,
        phoneSecondary: _phoneSecCtrl.text,
        nationalId: _nationalIdCtrl.text,
        email: _emailCtrl.text,
        address: _addressCtrl.text,
        companyName: _companyNameCtrl.text,
        commercialRecord: _commercialRecordCtrl.text,
        notes: _notesCtrl.text,
      );
    } else {
      await repo.updateClient(
        id: widget.clientId!,
        clientType: _clientType,
        fullName: _fullNameCtrl.text,
        phone: _phoneCtrl.text,
        phoneSecondary: _phoneSecCtrl.text,
        nationalId: _nationalIdCtrl.text,
        email: _emailCtrl.text,
        address: _addressCtrl.text,
        companyName: _companyNameCtrl.text,
        commercialRecord: _commercialRecordCtrl.text,
        notes: _notesCtrl.text,
      );
    }

    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final isCompany = _clientType == 'COMPANY';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.clientId == null ? 'إضافة موكل جديد' : 'تعديل بيانات الموكل'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // نوع الموكل
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(
                  value: 'INDIVIDUAL',
                  label: Text('شخص'),
                  icon: Icon(Icons.person),
                ),
                ButtonSegment(
                  value: 'COMPANY',
                  label: Text('شركة / منشأة'),
                  icon: Icon(Icons.business),
                ),
              ],
              selected: {_clientType},
              onSelectionChanged: (set) {
                setState(() => _clientType = set.first);
              },
            ),
            const SizedBox(height: 18),

            AppTextField(
              controller: _fullNameCtrl,
              label: isCompany ? 'اسم المنشأة أو الشركة *' : 'اسم الموكل الثلاثي *',
              hint: isCompany ? 'شركة (...) المحدودة المسؤولية' : 'الاسم والنسبة واسم الأب',
              prefixIcon: isCompany ? Icons.business : Icons.person_outline,
              enableSpeech: true,
              validator: (v) => v == null || v.trim().isEmpty ? 'مطلوب' : null,
            ),
            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    controller: _phoneCtrl,
                    label: 'رقم الهاتف الأساسي *',
                    hint: '09xxxxxxxx',
                    prefixIcon: Icons.phone,
                    keyboardType: TextInputType.phone,
                    validator: (v) =>
                        v == null || v.trim().isEmpty ? 'مطلوب' : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppTextField(
                    controller: _phoneSecCtrl,
                    label: 'هاتف إضافي (اختياري)',
                    hint: 'هاتف أرضي أو جوال',
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            AppTextField(
              controller: _nationalIdCtrl,
              label: isCompany ? 'الرقم الضريبي / السجل' : 'الرقم الوطني (11 خانة)',
              hint: isCompany ? 'سجل تجاري / صناعي' : '01xxxxxxxx',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 14),

            if (isCompany) ...[
              AppTextField(
                controller: _commercialRecordCtrl,
                label: 'رقم السجل التجاري والجهة الصادر عنها',
                hint: 'سجل تجاري رقم (...) دمشق',
              ),
              const SizedBox(height: 14),
            ],

            AppTextField(
              controller: _emailCtrl,
              label: 'البريد الإلكتروني (اختياري)',
              hint: 'example@email.com',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 14),

            AppTextField(
              controller: _addressCtrl,
              label: 'العنوان ومكان الإقامة',
              hint: 'المحافظة - المنطقة - الشارع - البناء',
              enableSpeech: true,
            ),
            const SizedBox(height: 14),

            AppTextField(
              controller: _notesCtrl,
              label: 'ملاحظات المحامي الخاصة',
              hint: 'ملاحظات عن الموكل وسير التعامل...',
              enableSpeech: true,
              maxLines: 3,
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                widget.clientId == null ? 'تسجيل الموكل' : 'حفظ التعديلات',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

