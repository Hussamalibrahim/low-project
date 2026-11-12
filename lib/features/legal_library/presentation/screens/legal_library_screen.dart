import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/database_provider.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_empty_state.dart';
import '../../../../shared/widgets/app_status_badge.dart';
import '../../data/repositories/legal_library_repository.dart';

final legalLibraryRepositoryProvider =
    Provider<LegalLibraryRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return LegalLibraryRepository(db);
});

final librarySearchQueryProvider = StateProvider<String>((ref) => '');
final libraryCategoryFilterProvider = StateProvider<String?>((ref) => null);

final allLegalReferencesStreamProvider =
    StreamProvider<List<LegalReference>>((ref) {
  final repo = ref.watch(legalLibraryRepositoryProvider);
  final search = ref.watch(librarySearchQueryProvider);
  final cat = ref.watch(libraryCategoryFilterProvider);
  return repo.watchReferences(search: search, categoryFilter: cat);
});

class LegalLibraryScreen extends ConsumerWidget {
  const LegalLibraryScreen({super.key});

  void _showAddReferenceDialog(BuildContext context, WidgetRef ref) {
    final titleCtrl = TextEditingController();
    final lawNumCtrl = TextEditingController();
    final yearCtrl = TextEditingController();
    final authorityCtrl = TextEditingController();
    final textCtrl = TextEditingController();
    final sourceCtrl = TextEditingController(text: 'الجريدة الرسمية / دمشق');
    String type = 'LAW';
    String category = 'مدني';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (dialogCtx, setDialogState) => AlertDialog(
          title: const Text('إضافة مرجع أو صيغة قانونية'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleCtrl,
                  decoration: const InputDecoration(
                    labelText: 'عنوان القانون أو الصيغة *',
                    hintText: 'مثال: قانون الإيجارات رقم 10 / صيغة دعوى إخلاء',
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        initialValue: type,
                        decoration: const InputDecoration(labelText: 'النوع'),
                        items: const [
                          DropdownMenuItem(value: 'LAW', child: Text('قانون', overflow: TextOverflow.ellipsis)),
                          DropdownMenuItem(
                              value: 'LEGISLATIVE_DECREE',
                              child: Text('مرسوم تشريعي', overflow: TextOverflow.ellipsis)),
                          DropdownMenuItem(
                              value: 'CASSATION_PRECEDENT',
                              child: Text('اجتهاد نقض', overflow: TextOverflow.ellipsis)),
                          DropdownMenuItem(
                              value: 'TEMPLATE', child: Text('صيغة ونموذج دعوى', overflow: TextOverflow.ellipsis)),
                        ],
                        onChanged: (v) => setDialogState(() => type = v!),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        initialValue: category,
                        decoration:
                            const InputDecoration(labelText: 'التصنيف'),
                        items: const [
                          DropdownMenuItem(value: 'مدني', child: Text('مدني')),
                          DropdownMenuItem(
                              value: 'عقاري', child: Text('عقاري')),
                          DropdownMenuItem(
                              value: 'تجاري', child: Text('تجاري')),
                          DropdownMenuItem(
                              value: 'جزائي', child: Text('جزائي')),
                          DropdownMenuItem(
                              value: 'أحوال شخصية', child: Text('أحوال شخصية')),
                          DropdownMenuItem(
                              value: 'أصول محاكمات',
                              child: Text('أصول محاكمات')),
                        ],
                        onChanged: (v) => setDialogState(() => category = v!),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: lawNumCtrl,
                        decoration:
                            const InputDecoration(labelText: 'رقم التشريع / القرار'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: yearCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: 'السنة'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: authorityCtrl,
                  decoration: const InputDecoration(
                    labelText: 'الجهة المصدرة',
                    hintText: 'مجلس الشعب / محكمة النقض / وزارة العدل',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: textCtrl,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    labelText: 'النص الكامل للمادة أو النموذج *',
                    hintText: 'الصق النص القانوني أو صيغة الدعوى هنا...',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (titleCtrl.text.trim().isEmpty ||
                    textCtrl.text.trim().isEmpty) {
                  return;
                }
                await ref.read(legalLibraryRepositoryProvider).addReference(
                      title: titleCtrl.text.trim(),
                      referenceType: type,
                      lawNumber: lawNumCtrl.text.trim(),
                      year: int.tryParse(yearCtrl.text),
                      issuingAuthority: authorityCtrl.text.trim(),
                      category: category,
                      fullText: textCtrl.text.trim(),
                      source: sourceCtrl.text.trim(),
                    );
                if (ctx.mounted) Navigator.of(ctx).pop();
              },
              child: const Text('إضافة للمكتبة'),
            ),
          ],
        ),
      ),
    );
  }

  void _showViewTextDialog(BuildContext context, LegalReference ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(ref.title),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (ref.source != null)
                  Text('المصدر: ${ref.source!}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const Divider(),
                SelectableText(
                  ref.fullText,
                  style: const TextStyle(fontSize: 14, height: 1.6),
                ),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.copy),
            tooltip: 'نسخ النص بالكامل',
            onPressed: () {
              Clipboard.setData(ClipboardData(text: ref.fullText));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم نسخ النص إلى الحافظة')),
              );
            },
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('إغلاق'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final refsAsync = ref.watch(allLegalReferencesStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('المكتبة القانونية السورية'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddReferenceDialog(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('إضافة مرجع / صيغة'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (val) =>
                  ref.read(librarySearchQueryProvider.notifier).state = val,
              decoration: InputDecoration(
                hintText: 'بحث في القوانين، المراسيم، وصيغ الدعاوى...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () =>
                      ref.read(librarySearchQueryProvider.notifier).state = '',
                ),
              ),
            ),
          ),
          Expanded(
            child: refsAsync.when(
              data: (references) {
                if (references.isEmpty) {
                  return AppEmptyState(
                    icon: Icons.local_library_outlined,
                    title: 'لا توجد مراجع قانونية مطابقة',
                    subtitle:
                        'يمكنك استيراد القوانين والمراسيم السورية وصيغ الدعاوى للرجوع إليها والبحث فيها بدون إنترنت',
                    actionLabel: 'إضافة مرجع جديد',
                    onAction: () => _showAddReferenceDialog(context, ref),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 80),
                  itemCount: references.length,
                  itemBuilder: (context, index) {
                    final item = references[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: AppCard(
                        onTap: () => _showViewTextDialog(context, item),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  item.referenceType == 'TEMPLATE'
                                      ? Icons.description
                                      : Icons.menu_book,
                                  color: theme.colorScheme.primary,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    item.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                AppStatusBadge(label: item.category),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              item.fullText,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                color: theme.hintColor,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                if (item.source != null)
                                  Expanded(
                                    child: Text(
                                      item.source!,
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: theme.colorScheme.secondary,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                const SizedBox(width: 8),
                                const Text(
                                  'اضغط للقراءة والنسخ',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
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
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('خطأ: $e')),
            ),
          ),
        ],
      ),
    );
  }
}
