import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_together/widgets/pill_button.dart';

void main() {
  testWidgets("pill button label", (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PillButton(
            text: "TEST",
            onPressed: () {}
          ),
        ),
      ),
    );

    expect(find.text("TEST"), findsOneWidget);
  });
  
  testWidgets("pill button interazione utente", (tester) async {
    var called = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PillButton(
              text: "TEST",
              onPressed: () => called = true,
          ),
        ),
      ),
    );

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(called, true);
  });
}