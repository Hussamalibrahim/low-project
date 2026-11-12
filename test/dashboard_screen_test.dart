import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/native.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:law_office/core/database/app_database.dart';
import 'package:law_office/core/database/database_provider.dart';
import 'package:law_office/features/dashboard/presentation/screens/dashboard_screen.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('ar', null);
  });

  testWidgets('DashboardScreen renders calendar, agenda, and cases without overflow',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final testDb = AppDatabase(NativeDatabase.memory());

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(testDb),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: DashboardScreen(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify calendar header and weekdays exist
    expect(find.text('السبت'), findsOneWidget);
    expect(find.text('الأحد'), findsOneWidget);
    expect(find.text('الجمعة'), findsOneWidget);

    // Verify weekly / monthly toggle exists
    expect(find.text('شهري'), findsOneWidget);
    expect(find.text('أسبوعي'), findsOneWidget);

    // Verify daily agenda section header
    expect(find.textContaining('جدول أعمال يوم:'), findsOneWidget);

    // Scroll down to reveal Current Cases section
    await tester.drag(find.byType(ListView), const Offset(0, -300));
    await tester.pumpAndSettle();

    // Verify Current Cases section
    expect(find.text('القضايا الحالية قيد النظر'), findsOneWidget);

    // Verify zero exception
    expect(tester.takeException(), isNull);

    await testDb.close();
  });
}

