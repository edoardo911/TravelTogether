import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_together/widgets/icon_button_pill.dart';

void main() {
  testWidgets("icon button pill widget", (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: IconButtonPill(
            onPressed: () {},
            icon: Icons.add
          ),
        ),
      ),
    );

    expect(find.byType(Icon), findsOneWidget);
  });

  testWidgets("icon button pill tap", (tester) async {
    bool called = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: IconButtonPill(
              onPressed: () => called = true,
              icon: Icons.add
          ),
        ),
      ),
    );

    await tester.tap(find.byType(IconButtonPill));
    await tester.pumpAndSettle();
    expect(called, true);
  });
}