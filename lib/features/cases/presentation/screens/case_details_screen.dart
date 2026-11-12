import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as p;
import 'package:share_plus/share_plus.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_confirm_dialog.dart';
import '../../../../shared/widgets/app_status_badge.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../file_manager/presentation/providers/file_manager_provider.dart';
import '../../../finance/presentation/providers/finance_provider.dart';
import '../../../hearings/presentation/providers/hearings_provider.dart';
import '../../data/repositories/cases_repository.dart';
import '../providers/cases_provider.dart';
import 'opponent_details_screen.dart';

class CaseDetailsScreen extends ConsumerStatefulWidget {
  final String caseId;

  const CaseDetailsScreen({super.key, required this.caseId});

  @override
  ConsumerState<CaseDetailsScreen> createState() => _CaseDetailsScreenState();
}

class _CaseDetailsScreenState extends ConsumerState<CaseDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _caseNotesCtrl = TextEditingController();
  bool _isNotesInitialized = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _caseNotesCtrl.dispose();
    super.dispose();
  }

  String _formatFileSize(int bytes) {
    if (bytes >= 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} ميغابايت';
    } else {
      return '${(bytes / 1024).toStringAsFixed(1)} كيلوبايت';
    }
  }

  IconData _getDocIcon(String ext) {
    switch (ext.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'jpg':
      case 'png':
      case 'jpeg':
        return Icons.image;
      case 'txt':
        return Icons.text_snippet;
      default:
        return Icons.insert_drive_file;
    }
  }

  Future<void> _uploadAndAttachDocument(String caseId) async {
    try {
      final res = await FilePicker.platform.pickFiles(allowMultiple: true);
      if (res != null) {
        for (final filePath in res.paths) {
          if (filePath != null) {
            final fileName = p.basename(filePath);
            await ref.read(casesRepositoryProvider).attachDocumentToCase(
                  caseId: caseId,
                  filePath: filePath,
                  displayName: fileName,
                );
          }
        }
        ref.invalidate(caseDocumentsStreamProvider(caseId));
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم رفع وإرفاق المستندات بالقضية بنجاح'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تعذر اختيار أو إرفاق المستند: $e')),
        );
      }
    }
  }

  Future<void> _showDocumentActionSheet(Document doc, String caseId) async {
    final theme = Theme.of(context);

    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(_getDocIcon(doc.extension),
                    size: 36, color: theme.colorScheme.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doc.fileName,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'الحجم: ${_formatFileSize(doc.fileSize)} • اللاحقة: ${doc.extension.toUpperCase()}',
                        style: TextStyle(fontSize: 12, color: theme.hintColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 24),

            // خيار تعديل الاسم
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.blue),
              title: const Text('تغيير اسم المستند'),
              onTap: () async {
                Navigator.pop(ctx);
                final renameCtrl = TextEditingController(text: doc.fileName);
                final newName = await showDialog<String>(
                  context: context,
                  builder: (dCtx) => AlertDialog(
                    title: const Text('تعديل اسم المستند'),
                    content: AppTextField(
                      controller: renameCtrl,
                      label: 'الاسم الجديد',
                      hint: 'اكتب اسم المستند...',
                      autofocus: true,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(dCtx),
                        child: const Text('إلغاء'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (renameCtrl.text.trim().isNotEmpty) {
                            Navigator.pop(dCtx, renameCtrl.text.trim());
                          }
                        },
                        child: const Text('حفظ'),
                      ),
                    ],
                  ),
                );

                if (newName != null && newName.isNotEmpty) {
                  await ref
                      .read(casesRepositoryProvider)
                      .updateDocumentTitle(doc.id, newName);
                  ref.invalidate(caseDocumentsStreamProvider(caseId));
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم تعديل اسم المستند بنجاح')),
                    );
                  }
                }
              },
            ),

            // خيار فتح المستند
            ListTile(
              leading: const Icon(Icons.open_in_new, color: Colors.green),
              title: const Text('فتح المستند'),
              onTap: () async {
                Navigator.pop(ctx);
                final res = await OpenFilex.open(doc.uriString);
                if (res.type != ResultType.done && mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('تعذر فتح الملف: ${res.message}')),
                  );
                }
              },
            ),

            // خيار مشاركة المستند
            ListTile(
              leading: const Icon(Icons.share, color: Colors.indigo),
              title: const Text('مشاركة المستند'),
              onTap: () async {
                Navigator.pop(ctx);
                if (File(doc.uriString).existsSync()) {
                  await Share.shareXFiles([XFile(doc.uriString)]);
                } else if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('الملف غير موجود على الجهاز')),
                  );
                }
              },
            ),

            // خيار فك الارتباط / الحذف
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.red),
              title: const Text('حذف المستند من القضية',
                  style: TextStyle(color: Colors.red)),
              onTap: () async {
                Navigator.pop(ctx);
                final ok = await AppConfirmDialog.show(
                  context,
                  title: 'حذف المستند',
                  message: 'هل تريد حذف هذا المستند من القضية؟',
                  confirmLabel: 'حذف',
                  isDestructive: true,
                );
                if (ok) {
                  await ref
                      .read(fileManagerRepositoryProvider)
                      .removeDocumentCaseAssociation(doc.id, caseId);
                  ref.invalidate(caseDocumentsStreamProvider(caseId));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showResolveCaseDialog(Case c) async {
    DateTime resDate = c.closingDate != null
        ? DateTime.fromMillisecondsSinceEpoch(c.closingDate!)
        : DateTime.now();
    final decNumCtrl = TextEditingController();
    final notesCtrl = TextEditingController();

    if (c.outcome != null && c.outcome!.isNotEmpty) {
      for (final line in c.outcome!.split('\n')) {
        final tr = line.trim();
        if (tr.startsWith('قرار رقم: ')) {
          decNumCtrl.text = tr.substring('قرار رقم: '.length).trim();
        } else if (tr.startsWith('رقم القرار: ')) {
          decNumCtrl.text = tr.substring('رقم القرار: '.length).trim();
        } else if (tr.startsWith('قرار فصل رقم: ')) {
          decNumCtrl.text = tr.substring('قرار فصل رقم: '.length).trim();
        } else if (tr.isNotEmpty && tr != 'فُصلت القضية') {
          notesCtrl.text += (notesCtrl.text.isEmpty ? '' : '\n') + tr;
        }
      }
    }

    await showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDlgState) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.gavel, color: Colors.green),
              SizedBox(width: 8),
              Text('فصل القضية'),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'وفق ممارسة المحاكم، يمكنك فصل القضية الآن حتى وإن لم يصدر رقم القرار بعد، ويمكنك تعديل بيانات القرار لاحقاً:',
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
                const SizedBox(height: 14),
                OutlinedButton.icon(
                  icon: const Icon(Icons.calendar_month, size: 18),
                  label: Text(
                    'تاريخ الفصل: ${AppDateFormatter.formatDate(resDate)}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  onPressed: () async {
                    final d = await showDatePicker(
                      context: ctx,
                      initialDate: resDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2035),
                    );
                    if (d != null) {
                      setDlgState(() => resDate = d);
                    }
                  },
                ),
                const SizedBox(height: 12),
                AppTextField(
                  controller: decNumCtrl,
                  label: 'رقم الفصل / القرار (اختياري)',
                  hint: 'مثال: 145 / 2026',
                  autofocus: true,
                ),
                const SizedBox(height: 12),
                AppTextField(
                  controller: notesCtrl,
                  label: 'منطوق الحكم / القرار (اختياري)',
                  hint: 'اكتب منطوق الحكم أو الملاحظات أو سجلها صوتياً...',
                  enableSpeech: true,
                  maxLines: 3,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () async {
                await ref.read(casesRepositoryProvider).resolveCase(
                      caseId: c.id,
                      resolutionDate: resDate.millisecondsSinceEpoch,
                      decisionNumber: decNumCtrl.text.trim(),
                      notes: notesCtrl.text.trim(),
                    );
                ref.invalidate(caseWithDetailsProvider(c.id));
                ref.invalidate(allCasesStreamProvider);
                ref.invalidate(caseListItemsStreamProvider);
                if (mounted) {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('تم تثبيت فصل القضية بنجاح'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              child: const Text('تثبيت فصل القضية',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  /// استئناف / طعن القضية والانتقال إلى مرحلة جديدة
  Future<void> _showAppealCaseDialog(Case c) async {
    String selectedStage = 'استئناف';
    final caseNumCtrl = TextEditingController();
    final caseYearCtrl =
        TextEditingController(text: DateTime.now().year.toString());
    final groundsCtrl = TextEditingController();
    DateTime? firstHearingDate;
    String? selectedCourtId = c.courtId;

    final courts = await ref.read(allCourtsProvider.future);

    if (!mounted) return;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) {
          return Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 20,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'استئناف / طعن القضية',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                  const Text(
                    'سيتم حفظ وأرشفة المرحلة السابقة والانتقال بالقضية إلى المرحلة الجديدة مع رقم أساس ومحكمة جديدة.',
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  const SizedBox(height: 14),

                  DropdownButtonFormField<String>(
                    value: selectedStage,
                    decoration: const InputDecoration(
                      labelText: 'المرحلة القضائية الجديدة',
                      prefixIcon: Icon(Icons.stairs_outlined),
                    ),
                    items: const [
                      DropdownMenuItem(
                          value: 'استئناف', child: Text('مرحلة الاستئناف')),
                      DropdownMenuItem(
                          value: 'نقض', child: Text('مرحلة النقض')),
                      DropdownMenuItem(
                          value: 'اعتراض', child: Text('اعتراض على حكم غيابي')),
                      DropdownMenuItem(
                          value: 'إعادة محاكمة', child: Text('إعادة المحاكمة')),
                      DropdownMenuItem(
                          value: 'تنفيذ', child: Text('مرحلة التنفيذ الإجرائي')),
                    ],
                    onChanged: (val) {
                      if (val != null) setSheetState(() => selectedStage = val);
                    },
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: AppTextField(
                          controller: caseNumCtrl,
                          label: 'رقم الأساس الجديد (اختياري)',
                          hint: 'مثال: 1054',
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: AppTextField(
                          controller: caseYearCtrl,
                          label: 'السنة',
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  if (courts.isNotEmpty) ...[
                    DropdownButtonFormField<String>(
                      value: selectedCourtId,
                      decoration: const InputDecoration(
                        labelText: 'المحكمة المختصة الجديدة',
                        prefixIcon: Icon(Icons.account_balance),
                      ),
                      items: courts.map((crt) {
                        return DropdownMenuItem(
                          value: crt.id,
                          child:
                              Text(crt.name, overflow: TextOverflow.ellipsis),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setSheetState(() => selectedCourtId = val);
                      },
                    ),
                    const SizedBox(height: 12),
                  ],

                  OutlinedButton.icon(
                    icon: const Icon(Icons.calendar_month, size: 18),
                    label: Text(
                      firstHearingDate == null
                          ? 'تحديد موعد أول جلسة في المرحلة الجديدة (اختياري)'
                          : 'موعد أول جلسة: ${AppDateFormatter.formatDate(firstHearingDate!)}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: ctx,
                        initialDate:
                            DateTime.now().add(const Duration(days: 14)),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2035),
                      );
                      if (picked != null) {
                        setSheetState(() => firstHearingDate = picked);
                      }
                    },
                  ),
                  const SizedBox(height: 12),

                  AppTextField(
                    controller: groundsCtrl,
                    label: 'أسباب وملاحظات الاستئناف / الطعن (اختياري)',
                    hint: 'اكتب أسباب الطعن أو سجلها صوتياً...',
                    enableSpeech: true,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 18),

                  ElevatedButton(
                    onPressed: () async {
                      final year = int.tryParse(caseYearCtrl.text) ??
                          DateTime.now().year;
                      await ref
                          .read(casesRepositoryProvider)
                          .transitionToNewStage(
                            caseId: c.id,
                            newStage: selectedStage,
                            newCaseNumber: caseNumCtrl.text.trim(),
                            newCaseYear: year,
                            newCourtId: selectedCourtId,
                            grounds: groundsCtrl.text.trim(),
                            firstHearingDate:
                                firstHearingDate?.millisecondsSinceEpoch,
                          );
                      ref.invalidate(caseWithDetailsProvider(c.id));
                      ref.invalidate(caseConcludedStagesStreamProvider(c.id));
                      ref.invalidate(allCasesStreamProvider);
                      ref.invalidate(caseListItemsStreamProvider);

                      if (mounted) {
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'تم نقل القضية إلى مرحلة $selectedStage بنجاح'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('تثبيت وبدء المرحلة الجديدة',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// تسجيل تبليغ قضائي جديد
  Future<void> _showAddSubpoenaDialog(CaseWithDetails details) async {
    final c = details.caseItem;
    final recipientCtrl = TextEditingController();
    if (details.parties.isNotEmpty) {
      recipientCtrl.text = details.parties.first.name;
    }
    String notificationType = 'مذكرة دعوة لحضور جلسة';
    String status = 'قيد التبليغ والمتابعة';
    DateTime notifDate = DateTime.now();
    final notesCtrl = TextEditingController();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) {
          return Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 20,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'تسجيل تبليغ قضائي جديد',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  AppTextField(
                    controller: recipientCtrl,
                    label: 'الجهة المطلوب تبليغها *',
                    hint: 'اسم الخصم أو الشاهد أو المطلوب تبليغه',
                  ),
                  const SizedBox(height: 12),

                  DropdownButtonFormField<String>(
                    value: notificationType,
                    decoration: const InputDecoration(
                      labelText: 'نوع التبليغ / الإخطار',
                      prefixIcon: Icon(Icons.mark_email_read_outlined),
                    ),
                    items: const [
                      DropdownMenuItem(
                          value: 'مذكرة دعوة لحضور جلسة',
                          child: Text('مذكرة دعوة لحضور جلسة')),
                      DropdownMenuItem(
                          value: 'إخطار تنفيذي', child: Text('إخطار تنفيذي')),
                      DropdownMenuItem(
                          value: 'إنذار عدلي', child: Text('إنذار عدلي')),
                      DropdownMenuItem(
                          value: 'تبليغ قرار حكم',
                          child: Text('تبليغ قرار حكم')),
                      DropdownMenuItem(
                          value: 'مذكرة إحضار أو تكليف',
                          child: Text('مذكرة إحضار أو تكليف')),
                    ],
                    onChanged: (val) {
                      if (val != null)
                        setSheetState(() => notificationType = val);
                    },
                  ),
                  const SizedBox(height: 12),

                  DropdownButtonFormField<String>(
                    value: status,
                    decoration: const InputDecoration(
                      labelText: 'نتيجة وحالة التبليغ',
                      prefixIcon: Icon(Icons.task_alt),
                    ),
                    items: const [
                      DropdownMenuItem(
                          value: 'قيد التبليغ والمتابعة',
                          child: Text('قيد التبليغ والمتابعة')),
                      DropdownMenuItem(
                          value: 'تم التبليغ بالذات',
                          child: Text('تم التبليغ بالذات')),
                      DropdownMenuItem(
                          value: 'تم التبليغ موطناً',
                          child: Text('تم التبليغ موطناً')),
                      DropdownMenuItem(
                          value: 'إعادة تبليغ لجهالة العنوان',
                          child: Text('إعادة تبليغ لجهالة العنوان')),
                      DropdownMenuItem(
                          value: 'إعادة تبليغ لعدم الوجود',
                          child: Text('إعادة تبليغ لعدم الوجود')),
                      DropdownMenuItem(
                          value: 'تعذر التبليغ', child: Text('تعذر التبليغ')),
                    ],
                    onChanged: (val) {
                      if (val != null) setSheetState(() => status = val);
                    },
                  ),
                  const SizedBox(height: 12),

                  OutlinedButton.icon(
                    icon: const Icon(Icons.calendar_month, size: 18),
                    label: Text(
                      'تاريخ التبليغ: ${AppDateFormatter.formatDate(notifDate)}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: ctx,
                        initialDate: notifDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2035),
                      );
                      if (picked != null) {
                        setSheetState(() => notifDate = picked);
                      }
                    },
                  ),
                  const SizedBox(height: 12),

                  AppTextField(
                    controller: notesCtrl,
                    label: 'ملاحظات المحضر / التبليغ (اختياري)',
                    hint: 'اكتب تفاصيل التبليغ أو سجلها صوتياً...',
                    enableSpeech: true,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 18),

                  ElevatedButton(
                    onPressed: () async {
                      if (recipientCtrl.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('يرجى تحديد الجهة المطلوب تبليغها')),
                        );
                        return;
                      }
                      await ref
                          .read(casesRepositoryProvider)
                          .addCaseNotification(
                            caseId: c.id,
                            recipient: recipientCtrl.text.trim(),
                            notificationType: notificationType,
                            date: notifDate.millisecondsSinceEpoch,
                            status: status,
                            notes: notesCtrl.text.trim(),
                          );
                      ref.invalidate(caseNotificationsStreamProvider(c.id));
                      if (mounted) {
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('تم تسجيل التبليغ القضائي بنجاح'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('حفظ التبليغ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// تعديل نتيجة أو إعادة تبليغ
  Future<void> _showUpdateSubpoenaStatusDialog(CaseProcedure n) async {
    String status = n.result ?? 'تم التبليغ بالذات';
    final notesCtrl = TextEditingController(text: n.description ?? '');

    await showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDlgState) => AlertDialog(
          title: Text(
            'تحديث: ${n.title}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: status,
                decoration: const InputDecoration(labelText: 'النتيجة الجديدة'),
                items: const [
                  DropdownMenuItem(
                      value: 'تم التبليغ بالذات',
                      child: Text('تم التبليغ بالذات')),
                  DropdownMenuItem(
                      value: 'تم التبليغ موطناً',
                      child: Text('تم التبليغ موطناً')),
                  DropdownMenuItem(
                      value: 'إعادة تبليغ لجهالة العنوان',
                      child: Text('إعادة تبليغ لجهالة العنوان')),
                  DropdownMenuItem(
                      value: 'إعادة تبليغ لعدم الوجود',
                      child: Text('إعادة تبليغ لعدم الوجود')),
                  DropdownMenuItem(
                      value: 'تعذر التبليغ', child: Text('تعذر التبليغ')),
                  DropdownMenuItem(
                      value: 'قيد التبليغ والمتابعة',
                      child: Text('قيد التبليغ والمتابعة')),
                ],
                onChanged: (val) {
                  if (val != null) setDlgState(() => status = val);
                },
              ),
              const SizedBox(height: 12),
              AppTextField(
                controller: notesCtrl,
                label: 'ملاحظات المحضر',
                hint: 'تفاصيل التسليم أو سبب الإعادة...',
                enableSpeech: true,
                maxLines: 2,
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
                await ref
                    .read(casesRepositoryProvider)
                    .updateCaseNotificationStatus(
                      notificationId: n.id,
                      status: status,
                      notes: notesCtrl.text.trim(),
                    );
                ref.invalidate(caseNotificationsStreamProvider(n.caseId));
                if (mounted) Navigator.pop(ctx);
              },
              child: const Text('حفظ التحديث'),
            ),
          ],
        ),
      ),
    );
  }

  int _getPostponementCount(Hearing h) {
    if (h.postponementReason == null || h.postponementReason!.trim().isEmpty) {
      return (h.status == 'POSTPONED' || h.status == 'مؤجلة') ? 1 : 0;
    }
    return h.postponementReason!.split(' • ').length;
  }

  List<String> _getPostponementReasons(Hearing h) {
    if (h.postponementReason == null || h.postponementReason!.trim().isEmpty) {
      return [];
    }
    return h.postponementReason!.split(' • ');
  }

  String _getPostponementLabel(int count) {
    if (count <= 0) return '';
    if (count == 1) return 'أُجّلت (مرة واحدة)';
    if (count == 2) return 'أُجّلت (مرتين)';
    return 'أُجّلت ($count مرات)';
  }

  void _showHearingHistoryDialog(Hearing h, String caseTitle) {
    final reasons = _getPostponementReasons(h);
    final count = _getPostponementCount(h);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'سجل تأجيلات: ${h.hearingType}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        caseTitle,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(ctx),
                ),
              ],
            ),
            const Divider(height: 20),
            Row(
              children: [
                const Icon(Icons.history, color: Colors.orange, size: 20),
                const SizedBox(width: 8),
                Text(
                  'عدد مرات التأجيل: ${_getPostponementLabel(count)}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (reasons.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('لا توجد أسباب تفصيلية مسجلة'),
              )
            else
              ...List.generate(reasons.length, (idx) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.amber.withAlpha(20),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.amber.withAlpha(60)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.amber.shade800,
                          child: Text(
                            '${idx + 1}',
                            style: const TextStyle(
                                fontSize: 11,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'التأجيل رقم ${idx + 1}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                reasons[idx],
                                style: const TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            const SizedBox(height: 14),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(ctx);
                _showPostponeHearingDialog(h, h.caseId);
              },
              icon: const Icon(Icons.schedule, size: 18),
              label: const Text('تأجيل الجلسة'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showPostponeHearingDialog(Hearing h, String caseId) async {
    final reasonCtrl = TextEditingController(text: 'إمهال لتقديم المذكرات');
    DateTime newDate = DateTime.now().add(const Duration(days: 14));

    await showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDlgState) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.update, color: Colors.orange),
              SizedBox(width: 8),
              Text('تأجيل الجلسة'),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('جلسة: ${h.hearingType}',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  icon: const Icon(Icons.calendar_month, size: 18),
                  label: Text('تاريخ الجلسة القادمة: ${AppDateFormatter.formatDate(newDate)}'),
                  onPressed: () async {
                    final d = await showDatePicker(
                      context: ctx,
                      initialDate: newDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2035),
                    );
                    if (d != null) {
                      setDlgState(() => newDate = d);
                    }
                  },
                ),
                const SizedBox(height: 12),
                AppTextField(
                  controller: reasonCtrl,
                  label: 'سبب التأجيل وملاحظات الجلسة *',
                  hint: 'إمهال لتقديم دفوع / تبليغ الخصم',
                  enableSpeech: true,
                  autofocus: true,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () async {
                final newReason = reasonCtrl.text.trim();
                if (newReason.isEmpty) return;

                await ref.read(hearingsRepositoryProvider).postponeHearing(
                      hearingId: h.id,
                      caseId: caseId,
                      courtId: h.courtId,
                      hearingType: h.hearingType,
                      newHearingDate: newDate.millisecondsSinceEpoch,
                      reason: newReason,
                    );

                ref.invalidate(caseHearingsStreamProvider(caseId));
                ref.invalidate(allHearingsStreamProvider);
                ref.invalidate(caseListItemsStreamProvider);

                if (mounted) {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('تم تأجيل الجلسة وجدولة الجلسة القادمة بنجاح'),
                      backgroundColor: Colors.teal,
                    ),
                  );
                }
              },
              child: const Text('تأكيد التأجيل'),
            ),
          ],
        ),
      ),
    );
  }

  void _openOpponentScreen(
      BuildContext context, String caseId, CaseParty? party) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => OpponentDetailsScreen(
          caseId: caseId,
          party: party,
        ),
      ),
    );
  }

  Widget _buildResolutionCard(Case c, ThemeData theme, bool isClosed) {
    return AppCard(
      color: isClosed
          ? Colors.blueGrey.withAlpha(20)
          : Colors.green.withAlpha(20),
      border: Border.all(
        color: isClosed
            ? Colors.blueGrey.withAlpha(60)
            : Colors.green.withAlpha(80),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.gavel,
                        color: isClosed ? Colors.grey : Colors.green,
                        size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        isClosed ? 'القضية مفصولة' : 'فصل القضية',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: isClosed
                              ? (theme.brightness == Brightness.dark
                                  ? Colors.grey.shade300
                                  : Colors.grey.shade800)
                              : (theme.brightness == Brightness.dark
                                  ? Colors.green.shade300
                                  : Colors.green.shade800),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              if (!isClosed)
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                  ),
                  onPressed: () => _showResolveCaseDialog(c),
                  icon: const Icon(Icons.check_circle, size: 16),
                  label: const Text('فصل القضية'),
                ),
            ],
          ),
          if (isClosed) ...[
            const SizedBox(height: 8),
            if (c.closingDate != null)
              Text(
                'تاريخ الفصل: ${AppDateFormatter.formatTimestamp(c.closingDate)}',
                style: const TextStyle(fontSize: 12),
              ),
            if (c.outcome != null && c.outcome!.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                c.outcome!,
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ],
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.refresh, size: 16),
                label:
                    const Text('إلغاء الفصل وإعادة القضية للقضايا الجارية'),
                onPressed: () async {
                  await ref
                      .read(casesRepositoryProvider)
                      .reopenCase(c.id);
                  ref.invalidate(caseWithDetailsProvider(c.id));
                  ref.invalidate(allCasesStreamProvider);
                  ref.invalidate(caseListItemsStreamProvider);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'تم إلغاء الفصل وإعادة القضية للقضايا الجارية'),
                      ),
                    );
                  }
                },
              ),
            ),
          ] else ...[
            const SizedBox(height: 6),
            Text(
              'اضغط على "فصل القضية" لإدخال تاريخ الفصل ورقم القرار والملاحظات لتنتقل الدعوى تلقائياً للقضايا المفصولة.',
              style: TextStyle(
                fontSize: 12,
                color: theme.textTheme.bodyMedium?.color?.withAlpha(200),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showAddHearingDialog(BuildContext context, String caseId) {
    final typeController = TextEditingController(text: 'جلسة محاكمة');
    DateTime hearingDate = DateTime.now().add(const Duration(days: 7));

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDlgState) => AlertDialog(
          title: const Text('تسجيل جلسة محاكمة جديدة'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTextField(
                controller: typeController,
                label: 'العمل المطلوب في الجلسة *',
                hint: 'تقديم مرافعة / استجواب شهود',
                enableSpeech: true,
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                icon: const Icon(Icons.calendar_month),
                label: Text('التاريخ: ${AppDateFormatter.formatDate(hearingDate)}'),
                onPressed: () async {
                  final d = await showDatePicker(
                    context: ctx,
                    initialDate: hearingDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2035),
                  );
                  if (d != null) {
                    setDlgState(() => hearingDate = d);
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (typeController.text.trim().isEmpty) return;
                await ref.read(hearingsRepositoryProvider).addHearing(
                      caseId: caseId,
                      hearingDate: hearingDate.millisecondsSinceEpoch,
                      hearingType: typeController.text.trim(),
                    );
                ref.invalidate(caseHearingsStreamProvider(caseId));
                ref.invalidate(allHearingsStreamProvider);
                ref.invalidate(caseListItemsStreamProvider);
                if (ctx.mounted) Navigator.of(ctx).pop();
              },
              child: const Text('حفظ'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final caseAsync = ref.watch(caseWithDetailsProvider(widget.caseId));
    final hearingsAsync = ref.watch(caseHearingsStreamProvider(widget.caseId));
    final proceduresAsync =
        ref.watch(caseProceduresStreamProvider(widget.caseId));
    final documentsAsync =
        ref.watch(caseDocumentsStreamProvider(widget.caseId));
    final financeAsync = ref.watch(caseFinancialSummaryProvider(
        (caseId: widget.caseId, currency: 'SYP')));

    return caseAsync.when(
      data: (details) {
        if (details == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('تفاصيل القضية')),
            body: const Center(child: Text('لم يتم العثور على القضية')),
          );
        }

        final c = details.caseItem;
        final isClosed = c.status == 'CLOSED';

        if (!_isNotesInitialized) {
          _caseNotesCtrl.text = c.notes ?? '';
          _isNotesInitialized = true;
        }

        final caseBarTitle = details.clients.isNotEmpty
            ? details.clients.first.fullName
            : c.title;

        return Scaffold(
          appBar: AppBar(
            title: Text(caseBarTitle, overflow: TextOverflow.ellipsis),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                tooltip: 'تعديل بيانات القضية',
                onPressed: () => context.push('/cases/${c.id}/edit'),
              ),
              PopupMenuButton<String>(
                onSelected: (value) async {
                  if (value == 'resolve') {
                    _showResolveCaseDialog(c);
                  } else if (value == 'reopen') {
                    await ref.read(casesRepositoryProvider).reopenCase(c.id);
                    ref.invalidate(caseWithDetailsProvider(c.id));
                    ref.invalidate(allCasesStreamProvider);
                    ref.invalidate(caseListItemsStreamProvider);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('تمت إعادة فتح القضية بنجاح')),
                      );
                    }
                  } else if (value == 'archive') {
                    final ok = await AppConfirmDialog.show(
                      context,
                      title: 'أرشفة القضية',
                      message:
                          'هل تريد نقل القضية رقم ${c.caseNumber} إلى الأرشيف؟',
                      confirmLabel: 'أرشفة',
                    );
                    if (ok) {
                      await ref
                          .read(casesRepositoryProvider)
                          .archiveCase(c.id, c.title);
                      if (context.mounted) {
                        context.pop();
                      }
                    }
                  } else if (value == 'delete') {
                    final ok = await AppConfirmDialog.show(
                      context,
                      title: 'حذف القضية',
                      message: 'هل أنت متأكد من حذف القضية؟',
                      confirmLabel: 'حذف',
                      isDestructive: true,
                    );
                    if (ok) {
                      await ref
                          .read(casesRepositoryProvider)
                          .deleteCase(c.id, c.title);
                      if (context.mounted) {
                        context.pop();
                      }
                    }
                  }
                },
                itemBuilder: (ctx) => [
                  if (!isClosed)
                    const PopupMenuItem(
                      value: 'resolve',
                      child: Row(
                        children: [
                          Icon(Icons.gavel, color: Colors.green, size: 18),
                          SizedBox(width: 8),
                          Text('فصل القضية'),
                        ],
                      ),
                    )
                  else
                    const PopupMenuItem(
                      value: 'reopen',
                      child: Row(
                        children: [
                          Icon(Icons.refresh, color: Colors.blue, size: 18),
                          SizedBox(width: 8),
                          Text('إعادة فتح القضية'),
                        ],
                      ),
                    ),
                  const PopupMenuItem(
                    value: 'archive',
                    child: Row(
                      children: [
                        Icon(Icons.archive_outlined, size: 18),
                        SizedBox(width: 8),
                        Text('أرشفة القضية'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline, color: Colors.red, size: 18),
                        SizedBox(width: 8),
                        Text('حذف', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
            bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.center,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              labelPadding: const EdgeInsets.symmetric(horizontal: 14),
              labelStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              unselectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
              tabs: const [
                Tab(text: 'نظرة عامة'),
                Tab(text: 'جلسات المحاكمة'),
                Tab(text: 'التبليغات القضائية'),
                Tab(text: 'المستندات'),
                Tab(text: 'المالية'),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              // 1. نظرة عامة
              ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // 1. الموكل في الأعلى
                  Text(
                    'الموكل',
                    style: theme.textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  if (details.clients.isEmpty)
                    const AppCard(child: Text('لم يتم ربط موكل بعد'))
                  else
                    ...details.clients.map((client) {
                      final role =
                          details.clientRoles[client.id] ?? 'PLAINTIFF';
                      final isPlaintiff = role == 'PLAINTIFF';
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: AppCard(
                          onTap: () => context.push('/clients/${client.id}'),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: isPlaintiff
                                    ? Colors.blue.withAlpha(30)
                                    : Colors.red.withAlpha(30),
                                child: Icon(
                                  Icons.person,
                                  color: isPlaintiff ? Colors.blue : Colors.red,
                                  size: 22,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      client.fullName,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    if (client.phone.trim().isNotEmpty) ...[
                                      const SizedBox(height: 2),
                                      Text(
                                        'هاتف: ${client.phone}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: theme.hintColor,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              AppStatusBadge(
                                label: isPlaintiff ? 'مدعي' : 'مدعى عليه',
                                color: isPlaintiff ? Colors.blue : Colors.red,
                              ),
                              const SizedBox(width: 6),
                              const Icon(Icons.arrow_forward_ios,
                                  size: 13, color: Colors.grey),
                            ],
                          ),
                        ),
                      );
                    }),
                  const SizedBox(height: 14),

                  // 2. الخصوم مباشرة تحت الموكل
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'الخصوم (${details.parties.length})',
                        style: theme.textTheme.titleSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      TextButton.icon(
                        onPressed: () => _openOpponentScreen(context, c.id, null),
                        icon: const Icon(Icons.add, size: 16),
                        label: const Text('إضافة خصم +'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (details.parties.isEmpty)
                    AppCard(
                      onTap: () => _openOpponentScreen(context, c.id, null),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor:
                                theme.colorScheme.primary.withAlpha(25),
                            child: Icon(
                              Icons.person_add_outlined,
                              color: theme.colorScheme.primary,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'إضافة خصم',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 13,
                            color: theme.colorScheme.primary,
                          ),
                        ],
                      ),
                    )
                  else
                    ...details.parties.map((p) {
                      final isPlaintiff = p.role == 'PLAINTIFF';
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: AppCard(
                          onTap: () => _openOpponentScreen(context, c.id, p),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: isPlaintiff
                                    ? Colors.blue.withAlpha(30)
                                    : Colors.red.withAlpha(30),
                                child: Icon(
                                  Icons.person_outline,
                                  color: isPlaintiff ? Colors.blue : Colors.red,
                                  size: 22,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      p.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    if (p.lawyerPhone != null &&
                                        p.lawyerPhone!.trim().isNotEmpty) ...[
                                      const SizedBox(height: 2),
                                      Text(
                                        'هاتف: ${p.lawyerPhone}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: theme.hintColor,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              AppStatusBadge(
                                label: isPlaintiff ? 'مدعي' : 'مدعى عليه',
                                color: isPlaintiff ? Colors.blue : Colors.red,
                              ),
                              const SizedBox(width: 6),
                              const Icon(Icons.arrow_forward_ios,
                                  size: 13, color: Colors.grey),
                            ],
                          ),
                        ),
                      );
                    }),
                  const SizedBox(height: 14),

                  // 3. المرحلة الإجرائية الحالية للدعوى (بعد الطعن أو الاستئناف أو البدائية)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.gavel, size: 20, color: theme.colorScheme.primary),
                          const SizedBox(width: 8),
                          Text(
                            'المرحلة الحالية: ${c.stage}',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      AppStatusBadge(
                        label: isClosed ? 'مفصولة' : 'قيد النظر',
                        color: isClosed ? Colors.blueGrey : Colors.green,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                c.title,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary.withAlpha(25),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                c.stage,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 18),
                        _buildInfoRow('رقم الأساس والسنة',
                            c.caseNumber == '-' ? 'غير محدد' : '${c.caseNumber} لعام ${c.caseYear}'),
                        _buildInfoRow('نوع الدعوى', c.caseType),
                        _buildInfoRow('المحكمة المختصة',
                            details.court?.name ?? 'غير محدد'),
                        if (c.closingDate != null)
                          _buildInfoRow(
                            'تاريخ الفصل',
                            AppDateFormatter.formatTimestamp(c.closingDate),
                          ),
                        if (c.claimAmount != null && c.claimAmount! > 0)
                          _buildInfoRow(
                            'المبلغ المدعى به',
                            CurrencyFormatter.format(c.claimAmount!,
                                currency: c.currency),
                          ),
                        if (c.notes != null && c.notes!.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: theme.brightness == Brightness.dark
                                  ? const Color(0xFF1E293B)
                                  : const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.info_outline, size: 18, color: Colors.blueGrey),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'ملاحظات وأسباب المرحلة: ${c.notes!}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        const SizedBox(height: 14),

                        // أزرار التحكم بالمرحلة (فصل القضية / استئناف أو طعن جديد)
                        if (isClosed) ...[
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.amber.shade800,
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                  ),
                                  onPressed: () => _showAppealCaseDialog(c),
                                  icon: const Icon(Icons.upgrade, size: 18, color: Colors.white),
                                  label: const Text(
                                    '+ استئناف / طعن جديد',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                flex: 2,
                                child: OutlinedButton.icon(
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                  ),
                                  onPressed: () => _showResolveCaseDialog(c),
                                  icon: const Icon(Icons.edit_note, size: 18),
                                  label: const Text(
                                    'تعديل القرار',
                                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ] else ...[
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: const EdgeInsets.symmetric(vertical: 10),
                              ),
                              onPressed: () => _showResolveCaseDialog(c),
                              icon: const Icon(Icons.gavel, size: 18, color: Colors.white),
                              label: const Text(
                                'فصل القضية',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // قرار الحكم وفصل القضية إن كانت مفصولة
                  if (isClosed && c.outcome != null && c.outcome!.isNotEmpty) ...[
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
                                'قرار الحكم وفصل القضية',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          Text(c.outcome!, style: const TextStyle(fontSize: 15)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                  ],

                  // 4. سجل المراحل السابقة المفصولة (المراحل السابقة قبل الاستئناف أو الطعن)
                  ref.watch(caseConcludedStagesStreamProvider(c.id)).when(
                    data: (concludedStages) {
                      if (concludedStages.isEmpty) return const SizedBox.shrink();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.history_edu, size: 20, color: Colors.blueGrey),
                              const SizedBox(width: 8),
                              Text(
                                'سجل المراحل السابقة المفصولة (${concludedStages.length})',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ...concludedStages.map((stg) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: AppCard(
                                color: theme.brightness == Brightness.dark
                                    ? const Color(0xFF1E293B)
                                    : const Color(0xFFF8FAFC),
                                child: ExpansionTile(
                                  tilePadding: EdgeInsets.zero,
                                  leading: const CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.blueGrey,
                                    child: Icon(Icons.done_all, color: Colors.white, size: 18),
                                  ),
                                  title: Text(
                                    stg.title,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                  ),
                                  subtitle: Text(
                                    'تاريخ الفصل: ${AppDateFormatter.formatTimestamp(stg.procedureDate)}',
                                    style: TextStyle(fontSize: 13, color: theme.hintColor),
                                  ),
                                  children: [
                                    if (stg.description != null && stg.description!.isNotEmpty) ...[
                                      const Divider(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 4),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            stg.description!,
                                            style: const TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            );
                          }),
                          const SizedBox(height: 14),
                        ],
                      );
                    },
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                  ),

                  // 5. ملاحظاتي (قابلة للتعديل والتسجيل الصوتي والحفظ المباشر)
                  Text(
                    'ملاحظاتي',
                    style: theme.textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  AppCard(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AppTextField(
                          controller: _caseNotesCtrl,
                          label: '',
                          hint: 'اكتب ملاحظاتك الخاصة أو سجلها صوتياً...',
                          enableSpeech: true,
                          maxLines: 4,
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              await ref
                                  .read(casesRepositoryProvider)
                                  .updateCaseNotes(
                                      c.id, _caseNotesCtrl.text.trim());
                              ref.invalidate(caseWithDetailsProvider(c.id));
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('تم حفظ الملاحظات بنجاح'),
                                    backgroundColor: Colors.teal,
                                  ),
                                );
                              }
                            },
                            icon: const Icon(Icons.save, size: 18),
                            label: const Text('حفظ الملاحظات'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // 2. جلسات المحاكمة
              hearingsAsync.when(
                data: (hearings) => Column(
                  children: [
                    // بطاقة فصل القضية في الأعلى فقط إذا كانت القضية مفصولة
                    if (isClosed)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                        child: _buildResolutionCard(c, theme, isClosed),
                      ),

                    // زر تسجيل جلسة جديدة في الأعلى فقط إذا كانت القضية جارية
                    if (!isClosed)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () =>
                                _showAddHearingDialog(context, c.id),
                            icon: const Icon(Icons.add),
                            label: const Text('تسجيل جلسة محاكمة جديدة'),
                          ),
                        ),
                      ),

                    Expanded(
                      child: hearings.isEmpty
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Text('لا توجد جلسات محاكمة مسجلة بعد'),
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              itemCount: hearings.length,
                              itemBuilder: (ctx, index) {
                                final h = hearings[index];
                                final postCount = _getPostponementCount(h);
                                final postReasons = _getPostponementReasons(h);
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: AppCard(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                h.hearingType,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            AppStatusBadge(
                                              label: h.status == 'SCHEDULED'
                                                  ? 'مجدولة'
                                                  : h.status == 'POSTPONED'
                                                      ? 'مؤجلة'
                                                      : h.status,
                                              color: h.status == 'POSTPONED'
                                                  ? Colors.orange
                                                  : null,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        // تاريخ الجلسة
                                        Text(
                                          postCount > 0
                                              ? 'تاريخ الجلسة الأساسي: ${AppDateFormatter.formatTimestamp(h.hearingDate)}'
                                              : 'تاريخ الجلسة: ${AppDateFormatter.formatTimestamp(h.hearingDate)}',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: theme.hintColor),
                                        ),
                                        if (h.postponementReason != null &&
                                            h.postponementReason!.isNotEmpty) ...[
                                          const SizedBox(height: 6),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 8),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.orange.withAlpha(25),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                  color: Colors.orange.shade700
                                                      .withAlpha(80)),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                            Icons.history,
                                                            size: 16,
                                                            color: Colors
                                                                .deepOrange),
                                                        const SizedBox(width: 6),
                                                        Text(
                                                          _getPostponementLabel(
                                                              postCount),
                                                          style: const TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .deepOrange,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    InkWell(
                                                      onTap: () =>
                                                          _showHearingHistoryDialog(
                                                              h, c.title),
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                                horizontal: 6,
                                                                vertical: 2),
                                                        child: Text(
                                                          'عرض سجل هذه الجلسة',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.blue,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  'سبب التأجيل: ${postReasons.isNotEmpty ? postReasons.last : h.postponementReason!}',
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.deepOrange,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                        if (h.nextHearingDate != null) ...[
                                          const SizedBox(height: 6),
                                          Text(
                                            'تاريخ الجلسة القادمة (المؤجل إليها): ${AppDateFormatter.formatTimestamp(h.nextHearingDate)}',
                                            style: TextStyle(
                                                color: theme
                                                    .colorScheme.primary,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13),
                                          ),
                                        ],
                                        const SizedBox(height: 10),
                                        // زر خيار تأجيل الجلسة
                                        if (!isClosed)
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: OutlinedButton.icon(
                                              onPressed: () =>
                                                  _showPostponeHearingDialog(
                                                      h, c.id),
                                              icon: const Icon(Icons.update,
                                                  size: 16),
                                              label: const Text('تأجيل الجلسة'),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),

                    // بطاقة فصل القضية في الأسفل تماماً تحت الجلسات إذا كانت القضية جارية
                    if (!isClosed)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                        child: _buildResolutionCard(c, theme, isClosed),
                      ),
                  ],
                ),
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('خطأ: $e')),
              ),

              // 3. التبليغات القضائية
              _buildSubpoenasTab(details, theme),

              // 4. المستندات المرتبطة (رفع مباشر + تغيير الاسم + ميغابايت + إلغاء التصنيف)
              documentsAsync.when(
                data: (docs) => ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _uploadAndAttachDocument(c.id),
                      icon: const Icon(Icons.upload_file),
                      label: const Text('رفع وإرفاق مستند جديد لهذه القضية +'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                    const SizedBox(height: 14),
                    if (docs.isEmpty)
                      const AppCard(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 24),
                            child: Column(
                              children: [
                                Icon(Icons.folder_open, size: 36, color: Colors.grey),
                                SizedBox(height: 8),
                                Text('لا توجد مستندات مرفقة بهذه القضية بعد'),
                                SizedBox(height: 4),
                                Text(
                                  'اضغط على الزر أعلاه لرفع مستندات أو صور تخص هذه القضية',
                                  style: TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    else
                      ...docs.map((doc) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: AppCard(
                              onTap: () => _showDocumentActionSheet(doc, c.id),
                              child: Row(
                                children: [
                                  Icon(_getDocIcon(doc.extension),
                                      size: 32,
                                      color: theme.colorScheme.primary),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          doc.fileName,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${_formatFileSize(doc.fileSize)} • ${doc.extension.toUpperCase()}',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: theme.hintColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.edit,
                                        size: 18, color: Colors.blue),
                                    tooltip: 'تغيير الاسم',
                                    onPressed: () =>
                                        _showDocumentActionSheet(doc, c.id),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.open_in_new,
                                        size: 18, color: Colors.green),
                                    tooltip: 'فتح المستند',
                                    onPressed: () =>
                                        OpenFilex.open(doc.uriString),
                                  ),
                                ],
                              ),
                            ),
                          )),
                  ],
                ),
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('خطأ: $e')),
              ),

              // 4. الإجراءات والمالية
              ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  financeAsync.when(
                    data: (fin) => AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('الملخص المالي للدعوى',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Icon(Icons.monetization_on_outlined,
                                  color: Colors.green),
                            ],
                          ),
                          const Divider(),
                          _buildInfoRow('إجمالي الأتعاب المتفق عليها',
                              CurrencyFormatter.format(fin.totalAgreed)),
                          _buildInfoRow('المسدد',
                              CurrencyFormatter.format(fin.totalPaid)),
                          _buildInfoRow('المتبقي بذمة الموكل',
                              CurrencyFormatter.format(fin.balanceRemaining)),
                        ],
                      ),
                    ),
                    loading: () => const LinearProgressIndicator(),
                    error: (e, _) => Text('خطأ: $e'),
                  ),
                  const SizedBox(height: 16),

                  Text('سجل الإجراءات القضائية',
                      style: theme.textTheme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  proceduresAsync.when(
                    data: (procs) {
                      if (procs.isEmpty) {
                        return const AppCard(child: Text('لا توجد إجراءات مسجلة'));
                      }
                      return Column(
                        children: procs
                            .map((pr) => Padding(
                                  padding: const EdgeInsets.only(bottom: 6),
                                  child: AppCard(
                                    child: Row(
                                      children: [
                                        const Icon(Icons.assignment,
                                            color: Colors.teal),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(pr.title,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(
                                                AppDateFormatter.formatTimestamp(
                                                    pr.procedureDate),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: theme.hintColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ))
                            .toList(),
                      );
                    },
                    loading: () => const LinearProgressIndicator(),
                    error: (e, _) => Text('خطأ: $e'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        body: Center(child: Text('خطأ: $e')),
      ),
    );
  }

  Widget _buildSubpoenasTab(CaseWithDetails details, ThemeData theme) {
    final c = details.caseItem;
    final notificationsAsync = ref.watch(caseNotificationsStreamProvider(c.id));

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () => _showAddSubpoenaDialog(details),
              icon: const Icon(Icons.add),
              label: const Text(
                'تسجيل تبليغ قضائي جديد',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Expanded(
          child: notificationsAsync.when(
            data: (notifs) {
              if (notifs.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.mark_email_read_outlined,
                            size: 48, color: theme.hintColor),
                        const SizedBox(height: 12),
                        const Text(
                          'لا توجد تبليغات قضائية مسجلة لهذه القضية بعد',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'سجل مذكرات الدعوة، الإخطارات، والإنذارات وتتبع إعادات التبليغ',
                          style: TextStyle(fontSize: 14, color: theme.hintColor),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }

              return ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: notifs.length,
                itemBuilder: (ctx, index) {
                  final n = notifs[index];
                  final status = n.result ?? 'قيد التبليغ';
                  Color statusColor = Colors.orange;
                  if (status.contains('تم التبليغ')) {
                    statusColor = Colors.green;
                  } else if (status.contains('إعادة') ||
                      status.contains('تعذر')) {
                    statusColor = Colors.red;
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Icon(Icons.mark_email_read,
                                        color: statusColor, size: 20),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        n.title,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              AppStatusBadge(label: status, color: statusColor),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.calendar_month,
                                  size: 16, color: theme.hintColor),
                              const SizedBox(width: 4),
                              Text(
                                'تاريخ التبليغ: ${AppDateFormatter.formatTimestamp(n.procedureDate)}',
                                style: TextStyle(
                                    fontSize: 14, color: theme.hintColor),
                              ),
                            ],
                          ),
                          if (n.description != null &&
                              n.description!.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: theme.brightness == Brightness.dark
                                    ? const Color(0xFF1E293B)
                                    : const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                n.description!,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                          const Divider(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton.icon(
                                onPressed: () =>
                                    _showUpdateSubpoenaStatusDialog(n),
                                icon: const Icon(Icons.edit, size: 16),
                                label: const Text('تعديل النتيجة / إعادة تبليغ'),
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                icon: const Icon(Icons.delete_outline,
                                    size: 20, color: Colors.red),
                                tooltip: 'حذف التبليغ',
                                onPressed: () async {
                                  await ref
                                      .read(casesRepositoryProvider)
                                      .deleteCaseNotification(n.id);
                                  ref.invalidate(
                                      caseNotificationsStreamProvider(c.id));
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('خطأ: $e')),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
