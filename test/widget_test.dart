import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:school_event_planner/screens/welcome_screen.dart';

void main() {
  testWidgets('Welcome screen renders title', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: WelcomeScreen()),
    );

    expect(find.text('School Event Planning'), findsOneWidget);
  });
}
