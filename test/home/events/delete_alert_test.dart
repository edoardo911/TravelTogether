import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_together/home/events/delete_alert.dart';

void main() {
  testWidgets("delete alert widget", (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DeleteAlert(action: () {}),
        ),
      ),
    );

    expect(find.byType(Text), findsNWidgets(4));
    expect(find.byType(TextButton), findsNWidgets(2));
    expect(find.text("Conferma Eliminazione"), findsOneWidget);
    expect(find.text("Sei sicuro di voler eliminare questo viaggio?"), findsOneWidget);
    expect(find.text("Si"), findsOneWidget);
    expect(find.text("No"), findsOneWidget);
  });

  testWidgets("delete alert action", (tester) async {
    bool called = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DeleteAlert(action: () => called = true),
        ),
      ),
    );

    await tester.tap(find.byType(TextButton).at(1));
    await tester.pumpAndSettle();
    expect(called, true);
  });
}