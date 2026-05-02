import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_together/home/user/profile_info.dart';

void main() {
  testWidgets("profile info data", (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProfileInfo(
            amount: 0,
            label: "test label",
            action: () {}
          ),
        ),
      ),
    );

    expect(find.byType(Text), findsNWidgets(2));
    expect(find.text("test label"), findsOneWidget);
    expect(find.text("0"), findsOneWidget);
  });

  testWidgets("button tap", (tester) async {
    bool called = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProfileInfo(
            amount: 0,
            label: "",
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