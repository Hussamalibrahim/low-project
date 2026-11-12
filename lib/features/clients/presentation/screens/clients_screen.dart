import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_empty_state.dart';
import '../providers/clients_provider.dart';

class ClientsScreen extends ConsumerWidget {
  const ClientsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final clientsAsync = ref.watch(allClientsStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('دليل الموكلين'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/clients/new'),
        icon: const Icon(Icons.person_add),
        label: const Text('إضافة موكل جديد'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (val) =>
                  ref.read(clientSearchQueryProvider.notifier).state = val,
              decoration: InputDecoration(
                hintText: 'بحث بالاسم، رقم الهاتف، أو الرقم الوطني...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () =>
                      ref.read(clientSearchQueryProvider.notifier).state = '',
                ),
              ),
            ),
          ),
          Expanded(
            child: clientsAsync.when(
              data: (clients) {
                if (clients.isEmpty) {
                  return AppEmptyState(
                    icon: Icons.people_outline,
                    title: 'لا يوجد موكلون مسجلون',
                    subtitle: 'اضغط على زر إضافة موكل جديد لتسجيل بيانات موكل',
                    actionLabel: 'إضافة موكل جديد',
                    onAction: () => context.push('/clients/new'),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 80),
                  itemCount: clients.length,
                  itemBuilder: (context, index) {
                    final client = clients[index];
                    final isCompany = client.clientType == 'COMPANY';

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: AppCard(
                        onTap: () => context.push('/clients/${client.id}'),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isCompany
                                    ? Colors.orange.withAlpha(25)
                                    : Colors.blue.withAlpha(25),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isCompany
                                    ? Icons.business
                                    : Icons.person_outline,
                                color: isCompany ? Colors.orange : Colors.blue,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    client.fullName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.phone,
                                          size: 13, color: theme.hintColor),
                                      const SizedBox(width: 4),
                                      Text(
                                        client.phone,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: theme.hintColor,
                                        ),
                                      ),
                                      if (client.nationalId != null &&
                                          client.nationalId!.isNotEmpty) ...[
                                        const SizedBox(width: 12),
                                        Text(
                                          'وطني: ${client.nationalId!}',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: theme.hintColor,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.arrow_forward_ios,
                                size: 14, color: Colors.grey),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('خطأ: $err')),
            ),
          ),
        ],
      ),
    );
  }
}

