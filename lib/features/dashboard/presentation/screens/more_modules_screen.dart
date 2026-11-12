import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/localization/app_strings.dart';
import '../../../../shared/widgets/app_card.dart';

class MoreModulesScreen extends StatelessWidget {
  const MoreModulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final modules = [
      (
        icon: Icons.account_balance_wallet_outlined,
        title: AppStrings.moduleFinance,
        subtitle: 'اتفاقيات الأتعاب، الدفعات، المصاريف، والأرصدة',
        route: '/finance',
        color: Colors.green,
      ),
      (
        icon: Icons.task_alt,
        title: AppStrings.moduleTasks,
        subtitle: 'المهام الإدارية والقضائية والتذكيرات',
        route: '/tasks',
        color: Colors.amber.shade800,
      ),
      (
        icon: Icons.assignment_outlined,
        title: AppStrings.moduleContracts,
        subtitle: 'سندات التوكيل، عقود الأتعاب، ومهل الانتهاء',
        route: '/contracts',
        color: Colors.indigo,
      ),
      (
        icon: Icons.account_balance_outlined,
        title: AppStrings.moduleContacts,
        subtitle: 'محاكم دمشق، المحامون، الخبراء، والشهود',
        route: '/contacts',
        color: Colors.blue,
      ),
      (
        icon: Icons.phone_in_talk_outlined,
        title: AppStrings.moduleCommunications,
        subtitle: 'سجل المقابلات والمكالمات ومخرجات اللقاءات',
        route: '/communications',
        color: Colors.cyan.shade800,
      ),
      (
        icon: Icons.local_library_outlined,
        title: AppStrings.moduleLegalLibrary,
        subtitle: 'التشريعات السورية، المراسيم، وصيغ الدعاوى',
        route: '/legal-library',
        color: Colors.deepOrange,
      ),
      (
        icon: Icons.auto_awesome,
        title: AppStrings.moduleLegalAi,
        subtitle: 'المساعد الذكي (Gemini): تلخيص، وصياغة، وتدقيق',
        route: '/legal-ai',
        color: Colors.purple,
      ),
      (
        icon: Icons.analytics_outlined,
        title: AppStrings.moduleReports,
        subtitle: 'تقارير القضايا، المالية، والتصدير PDF/Excel/CSV',
        route: '/reports',
        color: Colors.blueGrey,
      ),
      (
        icon: Icons.archive_outlined,
        title: AppStrings.moduleArchive,
        subtitle: 'سجل القضايا المؤرشفة واستعراض تاريخها',
        route: '/archive',
        color: Colors.brown,
      ),
      (
        icon: Icons.cloud_sync_outlined,
        title: AppStrings.moduleBackup,
        subtitle: 'النسخ المشفر (AES-256) مع المستندات، وGoogle Drive',
        route: '/backup',
        color: Colors.blue.shade900,
      ),
      (
        icon: Icons.tune,
        title: AppStrings.moduleSettings,
        subtitle: 'السمات اللونية، تحجيم الخطوط، وقفل الأمان',
        route: '/settings',
        color: Colors.blueGrey,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('المزيد من وحدات النظام'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: modules.length,
        itemBuilder: (context, index) {
          final m = modules[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: AppCard(
              onTap: () => context.push(m.route),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: m.color.withAlpha(25),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(m.icon, color: m.color, size: 26),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          m.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          m.subtitle,
                          style: TextStyle(
                            fontSize: 12,
                            color: theme.hintColor,
                          ),
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
      ),
    );
  }
}
