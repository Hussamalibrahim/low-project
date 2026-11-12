import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/archive/presentation/screens/archive_screen.dart';
import '../../features/backup/presentation/screens/backup_screen.dart';
import '../../features/calendar/presentation/screens/calendar_screen.dart';
import '../../features/cases/presentation/screens/add_edit_case_screen.dart';
import '../../features/cases/presentation/screens/case_details_screen.dart';
import '../../features/cases/presentation/screens/cases_screen.dart';
import '../../features/clients/presentation/screens/add_edit_client_screen.dart';
import '../../features/clients/presentation/screens/client_details_screen.dart';
import '../../features/clients/presentation/screens/clients_screen.dart';
import '../../features/communications/presentation/screens/communications_screen.dart';
import '../../features/contacts/presentation/screens/contacts_screen.dart';
import '../../features/contracts/presentation/screens/contracts_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/dashboard/presentation/screens/more_modules_screen.dart';
import '../../features/file_manager/presentation/screens/document_preview_screen.dart';
import '../../features/file_manager/presentation/screens/file_manager_screen.dart';
import '../../features/finance/presentation/screens/finance_screen.dart';
import '../../features/hearings/presentation/screens/hearings_screen.dart';
import '../../features/legal_ai/presentation/screens/legal_ai_screen.dart';
import '../../features/legal_library/presentation/screens/legal_library_screen.dart';
import '../../features/reports/presentation/screens/reports_screen.dart';
import '../../features/security/presentation/app_lock_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/tasks/presentation/screens/tasks_screen.dart';
import '../security/security_provider.dart';
import 'scaffold_with_bottom_nav_bar.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  RouterNotifier(this._ref) {
    _ref.listen<bool>(
      appLockProvider.select((s) => s.isLocked),
      (_, s) => notifyListeners(),
    );
  }

  String? redirect(BuildContext context, GoRouterState state) {
    final isLocked = _ref.read(appLockProvider).isLocked;
    final isLockPath = state.uri.path == '/lock';

    if (isLocked && !isLockPath) {
      return '/lock';
    }
    if (!isLocked && isLockPath) {
      return '/dashboard';
    }
    return null;
  }
}

final routerNotifierProvider = Provider<RouterNotifier>((ref) {
  return RouterNotifier(ref);
});

final appRouterProvider = Provider<GoRouter>((ref) {
  final notifier = ref.watch(routerNotifierProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/dashboard',
    refreshListenable: notifier,
    redirect: notifier.redirect,
    routes: [
      GoRoute(
        path: '/lock',
        builder: (context, state) => const AppLockScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithBottomNavBar(navigationShell: navigationShell);
        },
        branches: [
          // 0. Dashboard
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/dashboard',
                builder: (context, state) => const DashboardScreen(),
              ),
            ],
          ),
          // 1. Cases
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/cases',
                builder: (context, state) => const CasesScreen(),
              ),
            ],
          ),
          // 2. Hearings
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/hearings',
                builder: (context, state) => const HearingsScreen(),
              ),
            ],
          ),
          // 3. File Manager
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/file-manager',
                builder: (context, state) => const FileManagerScreen(),
              ),
            ],
          ),
          // 3. More Modules
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/more',
                builder: (context, state) => const MoreModulesScreen(),
              ),
            ],
          ),
        ],
      ),

      // التقويم الكامل المباشر
      GoRoute(
        path: '/calendar',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const CalendarScreen(),
      ),

      // دليل الموكلين المباشر
      GoRoute(
        path: '/clients',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const ClientsScreen(),
      ),

      // مسارات القضايا
      GoRoute(
        path: '/cases/new',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const AddEditCaseScreen(),
      ),
      GoRoute(
        path: '/cases/:id',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) =>
            CaseDetailsScreen(caseId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/cases/:id/edit',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) =>
            AddEditCaseScreen(caseId: state.pathParameters['id']!),
      ),

      // مسارات الموكلين
      GoRoute(
        path: '/clients/new',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const AddEditClientScreen(),
      ),
      GoRoute(
        path: '/clients/:id',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) =>
            ClientDetailsScreen(clientId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/clients/:id/edit',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) =>
            AddEditClientScreen(clientId: state.pathParameters['id']!),
      ),

      // مسارات المستندات
      GoRoute(
        path: '/documents/:id',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) =>
            DocumentPreviewScreen(documentId: state.pathParameters['id']!),
      ),

      // مسارات الوحدات المستقلة
      GoRoute(
        path: '/tasks',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const TasksScreen(),
      ),
      GoRoute(
        path: '/finance',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const FinanceScreen(),
      ),
      GoRoute(
        path: '/contracts',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const ContractsScreen(),
      ),
      GoRoute(
        path: '/contacts',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const ContactsScreen(),
      ),
      GoRoute(
        path: '/communications',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const CommunicationsScreen(),
      ),
      GoRoute(
        path: '/legal-library',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const LegalLibraryScreen(),
      ),
      GoRoute(
        path: '/legal-ai',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const LegalAiScreen(),
      ),
      GoRoute(
        path: '/reports',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const ReportsScreen(),
      ),
      GoRoute(
        path: '/archive',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const ArchiveScreen(),
      ),
      GoRoute(
        path: '/backup',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const BackupScreen(),
      ),
      GoRoute(
        path: '/settings',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
});
