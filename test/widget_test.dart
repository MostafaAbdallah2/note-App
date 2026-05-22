import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bloc_test/main.dart';

void main() {
  testWidgets('App shows auth landing page', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    sharedPerf = await SharedPreferences.getInstance();

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Sign Up'), findsOneWidget);
  });
}
