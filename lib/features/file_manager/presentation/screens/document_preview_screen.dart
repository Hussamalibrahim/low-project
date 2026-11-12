import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:open_filex/open_filex.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_confirm_dialog.dart';
import '../../../../shared/widgets/app_status_badge.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../cases/presentation/providers/cases_provider.dart';
import '../providers/file_manager_provider.dart';

class DocumentPreviewScreen extends ConsumerStatefulWidget {
  final String documentId;

  const DocumentPreviewScreen({super.key, required this.documentId});

  @override
  ConsumerState<DocumentPreviewScreen> createState() =>
      _DocumentPreviewScreenState();
}

class _DocumentPreviewScreenState extends ConsumerState<DocumentPreviewScreen> {
  final _manualTextCtrl = TextEditingController();

  @override
  void dispose() {
    _manualTextCtrl.dispose();
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

  Future<void> _openExternal(String filePath) async {
    final result = await OpenFilex.open(filePath);
    if (result.type != ResultType.done && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تعذر فتح الملف: ${result.message}')),
      );
    }
  }

  Future<void> _shareFile(String filePath) async {
    final file = File(filePath);
    if (await file.exists()) {
      await Share.shareXFiles([XFile(filePath)]);
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الملف غير متاح للمشاركة')),
      );
    }
  }

  Future<void> _renameDocument(Document doc) async {
    final renameCtrl = TextEditingController(text: doc.fileName);
    final newName = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('تعديل اسم المستند'),
        content: AppTextField(
          controller: renameCtrl,
          label: 'الاسم الجديد',
          hint: 'اكتب اسم المستند...',
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
      await ref
          .read(casesRepositoryProvider)
          .updateDocumentTitle(doc.id, newName);
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم تعديل اسم المستند بنجاح')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final repo = ref.watch(fileManagerRepositoryProvider);

    return FutureBuilder<Document?>(
      future: repo.getDocumentById(widget.documentId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final doc = snapshot.data;
        if (doc == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('تفاصيل المستند')),
            body: const Center(child: Text('المستند غير موجود')),
          );
        }

        final isMissing = doc.isAvailable == 0;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              doc.fileName,
              style: const TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                tooltip: 'تعديل اسم المستند',
                onPressed: () => _renameDocument(doc),
              ),
              IconButton(
                icon: const Icon(Icons.share_outlined),
                tooltip: 'مشاركة المستند',
                onPressed: () => _shareFile(doc.uriString),
              ),
              IconButton(
                icon: const Icon(Icons.open_in_new),
                tooltip: 'فتح بتطبيق خارجي',
                onPressed: () => _openExternal(doc.uriString),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                tooltip: 'حذف سجل المستند',
                onPressed: () async {
                  final ok = await AppConfirmDialog.show(
                    context,
                    title: 'حذف سجل المستند',
                    message:
                        'هل تريد حذف سجل هذا المستند من النظام؟ الملف الأصلي سيبقى محفوظاً في ذاكرة جهازك ولن يتأثر.',
                    confirmLabel: 'حذف من النظام',
                    isDestructive: true,
                  );
                  if (ok) {
                    await repo.deleteDocumentRecord(doc.id, doc.fileName);
                    if (context.mounted) context.pop();
                  }
                },
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // بطاقة تفاصيل الملف
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(_getDocIcon(doc.extension),
                            size: 40, color: theme.colorScheme.primary),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doc.fileName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              AppStatusBadge(
                                label: isMissing ? 'الملف مفقود على القرص' : 'متاح وسليم',
                                color: isMissing ? Colors.red : Colors.green,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    _buildInfoRowWithWidget(
                      'النوع واللاحقة',
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(_getDocIcon(doc.extension), size: 16, color: theme.colorScheme.primary),
                          const SizedBox(width: 6),
                          Text(doc.extension.toUpperCase(),
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    _buildInfoRow(
                      'حجم الملف',
                      _formatFileSize(doc.fileSize),
                    ),
                    _buildInfoRow(
                      'تاريخ آخر تعديل للملف',
                      AppDateFormatter.formatTimestampWithTime(doc.lastModified),
                    ),
                    _buildInfoRow(
                      'تاريخ الإضافة للنظام',
                      AppDateFormatter.formatTimestampWithTime(doc.createdAt),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'المسار الفعلي على الجهاز:',
                      style: TextStyle(fontSize: 12, color: theme.hintColor),
                    ),
                    const SizedBox(height: 2),
                    SelectableText(
                      doc.uriString,
                      style: const TextStyle(fontSize: 11, fontFamily: 'monospace'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // أزرار الإجراءات السريعة
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _openExternal(doc.uriString),
                      icon: const Icon(Icons.open_in_new),
                      label: const Text('فتح المستند'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _renameDocument(doc),
                      icon: const Icon(Icons.edit),
                      label: const Text('تغيير الاسم'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildInfoRowWithWidget(String label, Widget trailing) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          trailing,
        ],
      ),
    );
  }
}
