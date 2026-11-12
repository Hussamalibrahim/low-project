import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_confirm_dialog.dart';
import '../../../../shared/widgets/app_empty_state.dart';
import '../../../cases/presentation/providers/cases_provider.dart';

class ArchiveScreen extends ConsumerWidget {
  const ArchiveScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final archivedAsync = ref.watch(archivedCasesStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('أرشيف القضايا المحسومة'),
      ),
      body: archivedAsync.when(
        data: (cases) {
          if (cases.isEmpty) {
            return const AppEmptyState(
              icon: Icons.archive_outlined,
              title: 'الأرشيف فارغ',
              subtitle: 'لم تقم بأرشفة أي قضية بعد. يمكنك أرشفة القضايا المحسومة من تفاصيل القضية.',
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: cases.length,
            itemBuilder: (context, index) {
              final c = cases[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: AppCard(
                  onTap: () => context.push('/cases/${c.id}'),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.brown.withAlpha(25),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.inventory_2_outlined, color: Colors.brown),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'أساس ${c.caseNumber} / ${c.caseYear}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              c.title,
                              style: const TextStyle(fontSize: 13),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'النوع: ${c.caseType} • المرحلة: ${c.stage}',
                              style: const TextStyle(fontSize: 11, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.unarchive, color: Colors.blue),
                        tooltip: 'استرجاع القضية من الأرشيف',
                        onPressed: () async {
                          final ok = await AppConfirmDialog.show(
                            context,
                            title: 'استرجاع القضية',
                            message: 'هل تريد استرجاع القضية رقم ${c.caseNumber} إلى القضايا قيد النظر؟',
                            confirmLabel: 'استرجاع',
                          );
                          if (ok) {
                            await ref.read(casesRepositoryProvider).restoreCase(c.id, c.title);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('تم استرجاع القضية بنجاح')),
                              );
                            }
                          }
                        },
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
    );
  }
}
