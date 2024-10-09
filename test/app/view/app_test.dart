import 'package:flutter_test/flutter_test.dart';
import 'package:teach_savvy/app/app.dart';
import 'package:teach_savvy/src/features/counter/presentation/pages/counter_page.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(CounterPage), findsOneWidget);
    });
  });
}
