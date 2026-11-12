import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as p;
import 'package:share_plus/share_plus.dart';
import '../../../../core/database/app_database.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_empty_state.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../cases/presentation/providers/cases_provider.dart';
import '../providers/file_manager_provider.dart';

class FileManagerScreen extends ConsumerStatefulWidget {
  const FileManagerScreen({super.key});

  @override
  ConsumerState<FileManagerScreen> createState() => _FileManagerScreenState();
}

class _FileManagerScreenState extends ConsumerState<FileManagerScreen> {
  final _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
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

  Future<void> _uploadAndLinkDocument() async {
    try {
      final res = await FilePicker.platform.pickFiles(allowMultiple: true);
      if (res == null || res.paths.isEmpty) return;

      final casesList = await ref.read(casesRepositoryProvider).getAllCases();
      if (!mounted) return;

      if (casesList.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('يرجى قيد قضية أولاً لربط المستند المرفوع بها'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      for (final filePath in res.paths) {
        if (filePath == null) continue;
        final originalName = p.basename(filePath);
        final nameCtrl = TextEditingController(text: originalName);
        String? selectedCaseId = casesList.first.id;

        final saved = await showDialog<bool>(
          context: context,
          builder: (ctx) => StatefulBuilder(
            builder: (context, setDlgState) => AlertDialog(
              title: const Row(
                children: [
                  Icon(Icons.upload_file, color: Colors.blue),
                  SizedBox(width: 8),
                  Text('ربط المستند بقضية وموكل'),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppTextField(
                    controller: nameCtrl,
                    label: 'اسم المستند (يمكنك تعديله)',
                    hint: 'اسم الملف...',
                    autofocus: true,
                  ),
                  const SizedBox(height: 14),
                  DropdownButtonFormField<String>(
                    isExpanded: true,
                    value: selectedCaseId,
                    decoration: const InputDecoration(
                      labelText: 'اختر القضية / الموكل *',
                      prefixIcon: Icon(Icons.gavel),
                    ),
                    items: casesList
                        .map((c) => DropdownMenuItem(
                              value: c.id,
                              child: Text(
                                'أساس ${c.caseNumber} / ${c.caseYear} - ${c.title}',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    onChanged: (v) => setDlgState(() => selectedCaseId = v),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx, false),
                  child: const Text('تخطي / إلغاء'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (selectedCaseId != null &&
                        nameCtrl.text.trim().isNotEmpty) {
                      Navigator.pop(ctx, true);
                    }
                  },
                  child: const Text('حفظ ورفع'),
                ),
              ],
            ),
          ),
        );

        if (saved == true && selectedCaseId != null) {
          await ref.read(casesRepositoryProvider).attachDocumentToCase(
                caseId: selectedCaseId!,
                filePath: filePath,
                displayName: nameCtrl.text.trim(),
              );
        }
      }

      ref.invalidate(clientFoldersStreamProvider);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم رفع المستندات بنجاح وإضافتها لمجلدات الموكلين'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تعذر رفع المستند: $e')),
        );
      }
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
          label: 'اسم المستند الجديد',
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
      ref.invalidate(clientFoldersStreamProvider);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم تعديل اسم المستند بنجاح')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final clientFoldersAsync = ref.watch(clientFoldersStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('مدير ملفات الموكلين'),
        actions: [
          IconButton(
            icon: const Icon(Icons.upload_file),
            tooltip: 'رفع مستند',
            onPressed: _uploadAndLinkDocument,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _uploadAndLinkDocument,
        icon: const Icon(Icons.upload_file),
        label: const Text('رفع مستند جديد'),
      ),
      body: Column(
        children: [
          // شريط البحث
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchCtrl,
              decoration: InputDecoration(
                hintText: 'بحث في أسماء المستندات...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchCtrl.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchCtrl.clear();
                          ref.read(documentSearchQueryProvider.notifier).state =
                              '';
                        },
                      )
                    : null,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              onChanged: (val) {
                ref.read(documentSearchQueryProvider.notifier).state = val;
              },
            ),
          ),

          // قائمة مجلدات الموكلين وقائمة ملفات كل موكل تكبر وتصغر
          Expanded(
            child: clientFoldersAsync.when(
              data: (folders) {
                if (folders.isEmpty) {
                  return AppEmptyState(
                    icon: Icons.folder_open,
                    title: 'لا توجد مستندات مرفوعة بعد',
                    subtitle:
                        'اضغط على زر "رفع مستند جديد" لاختيار ملف وربطه بقضية الموكل.',
                    actionLabel: 'رفع مستند الآن',
                    onAction: _uploadAndLinkDocument,
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: folders.length,
                  itemBuilder: (context, index) {
                    final folder = folders[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: AppCard(
                        padding: EdgeInsets.zero,
                        child: Theme(
                          data: theme.copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            leading: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.amber.withAlpha(30),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.folder,
                                  color: Colors.amber, size: 24),
                            ),
                            title: Text(
                              'مجلد: ${folder.clientName}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            subtitle: Text(
                              '${folder.documents.length} مستند',
                              style: TextStyle(
                                  fontSize: 12, color: theme.hintColor),
                            ),
                            children: folder.documents.map((doc) {
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: theme.dividerColor.withAlpha(30),
                                    ),
                                  ),
                                ),
                                child: ListTile(
                                  leading: Icon(_getDocIcon(doc.extension),
                                      color: theme.colorScheme.primary),
                                  title: Text(
                                    doc.fileName,
                                    style: const TextStyle(fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Text(
                                    '${_formatFileSize(doc.fileSize)} • ${doc.extension.toUpperCase()}',
                                    style: TextStyle(
                                        fontSize: 11, color: theme.hintColor),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit,
                                            size: 18, color: Colors.blue),
                                        tooltip: 'تغيير الاسم',
                                        onPressed: () => _renameDocument(doc),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.open_in_new,
                                            size: 18, color: Colors.green),
                                        tooltip: 'فتح المستند',
                                        onPressed: () =>
                                            OpenFilex.open(doc.uriString),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.share,
                                            size: 18, color: Colors.indigo),
                                        tooltip: 'مشاركة',
                                        onPressed: () {
                                          if (File(doc.uriString).existsSync()) {
                                            Share.shareXFiles(
                                                [XFile(doc.uriString)]);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                  onTap: () =>
                                      context.push('/documents/${doc.id}'),
                                ),
                              );
                            }).toList(),
                          ),
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
      ),
    );
  }
}
