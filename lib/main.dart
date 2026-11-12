import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'core/routing/app_router.dart';
import 'core/security/security_provider.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ar', null);

  // معالجة استباقية لأخطاء العرض لمنع ظهور الشاشة الحمراء
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.amber.withAlpha(30),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.amber.shade700.withAlpha(80)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.warning_amber_rounded, color: Colors.amber.shade800),
                const SizedBox(width: 8),
                const Flexible(
                  child: Text(
                    'تعذر عرض هذا العنصر، يرجى تحديث الصفحة',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  };

  runApp(
    const ProviderScope(
      child: LawOfficeApp(),
    ),
  );
}

class LawOfficeApp extends ConsumerStatefulWidget {
  const LawOfficeApp({super.key});

  @override
  ConsumerState<LawOfficeApp> createState() => _LawOfficeAppState();
}

class _LawOfficeAppState extends ConsumerState<LawOfficeApp>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.read(appLockProvider.notifier).checkInactivityTimeout();
    } else if (state == AppLifecycleState.paused) {
      ref.read(appLockProvider.notifier).recordActivity();
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeState = ref.watch(themeProvider);
    final router = ref.watch(appRouterProvider);

    final lightTheme = AppTheme.buildTheme(
      colorTheme: themeState.colorTheme,
      isDark: false,
      fontSize: themeState.fontSize,
    );

    final darkTheme = AppTheme.buildTheme(
      colorTheme: themeState.colorTheme,
      isDark: true,
      fontSize: themeState.fontSize,
    );

    return Listener(
      onPointerDown: (_) {
        ref.read(appLockProvider.notifier).recordActivity();
      },
      child: MaterialApp.router(
        title: 'نظام إدارة مكتب المحاماة',
        debugShowCheckedModeBanner: false,
        themeMode: themeState.themeMode,
        theme: lightTheme,
        darkTheme: darkTheme,
        routerConfig: router,

        // إعدادات اللغة العربية والـ RTL
        locale: const Locale('ar', 'SY'),
        supportedLocales: const [
          Locale('ar', 'SY'),
          Locale('ar'),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        builder: (context, child) {
          final mediaQuery = MediaQuery.of(context);
          return MediaQuery(
            data: mediaQuery.copyWith(
              textScaler: TextScaler.linear(themeState.fontSize.scale),
            ),
            child: child ?? const SizedBox(),
          );
        },
      ),
    );
  }
}
