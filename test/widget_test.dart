import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/native.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:law_office/core/database/app_database.dart';
import 'package:law_office/core/database/database_provider.dart';
import 'package:law_office/main.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('ar', null);
  });

  testWidgets('LawOfficeApp loads Dashboard and handles taps without glitching',
      (WidgetTester tester) async {
    final testDb = AppDatabase(NativeDatabase.memory());

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(testDb),
        ],
        child: const LawOfficeApp(),
      ),
    );

    // Allow database stream to emit and settle UI
    await tester.pumpAndSettle();

    // Verify main app and dashboard widgets exist
    expect(find.byType(LawOfficeApp), findsOneWidget);
    expect(find.text('أهلاً بك زميلي الأستاذ المحامي'), findsOneWidget);
    expect(find.text('إجراءات سريعة'), findsOneWidget);
    expect(find.text('إضافة موكل'), findsOneWidget);
    expect(find.text('قيد قضية'), findsOneWidget);

    // Tap on pointer down (which used to glitch and recreate GoRouter)
    await tester.tap(find.text('إضافة موكل'));
    await tester.pumpAndSettle();

    // Verify it navigated to Add/Edit client screen
    expect(find.text('إضافة موكل جديد'), findsOneWidget);

    // Close DB
    await testDb.close();
  });
}
