import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_together/home/user/profile_info.dart';

void main() {
  testWidgets("profile info texts", (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProfileInfo(
            amount: 7,
            label: "test label",
            action: () {}
          ),
        ),
      ),
    );

    expect(find.text("7"), findsOneWidget);
    expect(find.text("test label"), findsOneWidget);
  });

  testWidgets("profile info action call", (tester) async {
    bool called = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProfileInfo(
              amount: 7,
              label: "test label",
              action: () => called = true,
          ),
        ),
      ),
    );

    await tester.tap(find.byType(InkWell));
    await tester.pump();
    expect(called, true);
  });
}