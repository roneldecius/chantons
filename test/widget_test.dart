import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:chantons/main.dart';
import 'package:chantons/providers/settings_provider.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  testWidgets('App should load', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => SettingsProvider(),
        child: const ChantonsApp(),
      ),
    );
    expect(find.byType(ChantonsApp), findsOneWidget);
  });
}
