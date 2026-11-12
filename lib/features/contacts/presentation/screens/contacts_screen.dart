import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/database_provider.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_empty_state.dart';
import '../../../../shared/widgets/app_status_badge.dart';
import '../../../cases/presentation/providers/cases_provider.dart';
import '../../data/repositories/contacts_repository.dart';

final contactsRepositoryProvider = Provider<ContactsRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return ContactsRepository(db);
});

final contactsCategoryFilterProvider = StateProvider<String?>((ref) => null);

final allContactsStreamProvider = StreamProvider<List<Contact>>((ref) {
  final repo = ref.watch(contactsRepositoryProvider);
  final cat = ref.watch(contactsCategoryFilterProvider);
  return repo.watchContacts(categoryFilter: cat);
});

class ContactsScreen extends ConsumerStatefulWidget {
  const ContactsScreen({super.key});

  @override
  ConsumerState<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends ConsumerState<ContactsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showAddContactDialog(BuildContext context) {
    final nameCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    final orgCtrl = TextEditingController();
    final notesCtrl = TextEditingController();
    String category = 'LAWYER';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (dialogCtx, setDialogState) => AlertDialog(
          title: const Text('إضافة جهة اتصال مهنية'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(labelText: 'الاسم الكامل *'),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: category,
                  decoration: const InputDecoration(labelText: 'التصنيف المهني'),
                  items: const [
                    DropdownMenuItem(value: 'LAWYER', child: Text('محامٍ زميل')),
                    DropdownMenuItem(value: 'EXPERT', child: Text('خبير معتمد')),
                    DropdownMenuItem(value: 'NOTARY', child: Text('كاتب عدل')),
                    DropdownMenuItem(value: 'WITNESS', child: Text('شاهد')),
                    DropdownMenuItem(value: 'TRANSLATOR', child: Text('مترجم محلف')),
                    DropdownMenuItem(value: 'OFFICIAL', child: Text('دائرة / جهة رسمية')),
                    DropdownMenuItem(value: 'OTHER', child: Text('أخرى')),
                  ],
                  onChanged: (v) => setDialogState(() => category = v!),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: phoneCtrl,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(labelText: 'رقم الهاتف'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: orgCtrl,
                  decoration: const InputDecoration(
                    labelText: 'الجهة / المكتب / الاختصاص',
                    hintText: 'مكتب محاماة / اختصاص محاسبي / عقاري...',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: notesCtrl,
                  decoration: const InputDecoration(labelText: 'ملاحظات'),
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
                if (nameCtrl.text.trim().isEmpty) return;
                await ref.read(contactsRepositoryProvider).addContact(
                      name: nameCtrl.text.trim(),
                      category: category,
                      phone: phoneCtrl.text.trim(),
                      organization: orgCtrl.text.trim(),
                      notes: notesCtrl.text.trim(),
                    );
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
    final contactsAsync = ref.watch(allContactsStreamProvider);
    final courtsAsync = ref.watch(allCourtsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('دليل المحاكم وجهات الاتصال'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'جهات الاتصال المهنية'),
            Tab(text: 'المحاكم ومجمعات القضاء'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddContactDialog(context),
        icon: const Icon(Icons.person_add),
        label: const Text('إضافة جهة اتصال'),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // 1. جهات الاتصال
          contactsAsync.when(
            data: (contacts) {
              if (contacts.isEmpty) {
                return AppEmptyState(
                  icon: Icons.contacts_outlined,
                  title: 'لا توجد جهات اتصال مسجلة',
                  subtitle: 'سجل أرقام المحامين والخبراء والشهود لربطهم بالقضايا',
                  actionLabel: 'إضافة جهة اتصال',
                  onAction: () => _showAddContactDialog(context),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final c = contacts[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: AppCard(
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withAlpha(20),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.person,
                                color: theme.colorScheme.primary),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      c.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    AppStatusBadge(
                                      label: _getCategoryArabic(c.category),
                                    ),
                                  ],
                                ),
                                if (c.phone != null &&
                                    c.phone!.isNotEmpty) ...[
                                  const SizedBox(height: 4),
                                  Text('هاتف: ${c.phone!}',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: theme.hintColor)),
                                ],
                                if (c.organization != null &&
                                    c.organization!.isNotEmpty) ...[
                                  const SizedBox(height: 2),
                                  Text(c.organization!,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: theme.colorScheme.secondary)),
                                ],
                              ],
                            ),
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

          // 2. المحاكم
          courtsAsync.when(
            data: (courts) {
              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
                itemCount: courts.length,
                itemBuilder: (context, index) {
                  final court = courts[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: AppCard(
                      child: Row(
                        children: [
                          const Icon(Icons.account_balance,
                              color: Colors.blue, size: 28),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  court.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${court.governorate} - ${court.city}${court.address != null ? " • ${court.address!}" : ""}',
                                  style: TextStyle(
                                      fontSize: 12, color: theme.hintColor),
                                ),
                              ],
                            ),
                          ),
                          AppStatusBadge(label: court.courtType),
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
        ],
      ),
    );
  }

  String _getCategoryArabic(String cat) {
    switch (cat) {
      case 'LAWYER':
        return 'محامٍ زميل';
      case 'EXPERT':
        return 'خبير معتمد';
      case 'NOTARY':
        return 'كاتب عدل';
      case 'WITNESS':
        return 'شاهد';
      case 'TRANSLATOR':
        return 'مترجم محلف';
      case 'OFFICIAL':
        return 'جهة رسمية';
      default:
        return 'جهة اتصال';
    }
  }
}
