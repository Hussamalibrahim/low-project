import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/native.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:law_office/core/database/app_database.dart';
import 'package:law_office/core/database/database_provider.dart';
import 'package:law_office/features/cases/presentation/screens/add_edit_case_screen.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('ar', null);
  });

  testWidgets('AddEditCaseScreen renders on narrow screen without any pixel overflow',
      (WidgetTester tester) async {
    // Set small mobile screen size (360 x 640)
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
            body: AddEditCaseScreen(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify key fields rendered for client-centered case registration
    expect(find.text('قيد قضية جديدة'), findsOneWidget);
    expect(find.text('اسم الموكل'), findsOneWidget);
    expect(find.text('اسم الخصم'), findsOneWidget);
    expect(find.text('نوع الدعوى'), findsOneWidget);

    // Scroll down to the bottom of the form
    await tester.scrollUntilVisible(
      find.text('قيد القضية في السجل'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();

    expect(find.text('قيد القضية في السجل'), findsOneWidget);

    // Ensure zero exception occurred
    expect(tester.takeException(), isNull);

    await testDb.close();
  });
}
