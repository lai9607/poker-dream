import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poker_dream/app.dart';

void main() {
  testWidgets('App initializes and shows bottom navigation', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: PokerDreamApp(),
      ),
    );

    // Wait for the app to fully render
    await tester.pumpAndSettle();

    // Verify that bottom navigation items are present
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Series'), findsOneWidget);
    expect(find.text('News'), findsOneWidget);
    expect(find.text('Alerts'), findsOneWidget);
    expect(find.text('More'), findsOneWidget);
  });
}
