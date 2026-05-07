import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:travel_together/home/events/event_edit.dart';
import 'package:travel_together/models/event.dart';
import 'package:travel_together/widgets/pill_button.dart';

void main() {
  testWidgets("event create", (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EventEditPage(),
        ),
      ),
    );

    expect(find.byType(TextFormField), findsNWidgets(7));
    expect(find.byType(CheckboxListTile), findsOneWidget);
    expect(find.byType(PillButton), findsOneWidget);
  });

  testWidgets("event edit", (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EventEditPage(
            event: Event.fromJson({
              "id": "event0",
              "name": "test",
              "description": "description",
              "location": "santa monica",
              "authorUUID": "asd123",
              "maxParticipants": 9,
              "duration": "3 days",
              "date": DateTime(2026).toIso8601String(),
              "participants": [ "Mario", "Luigi" ],
              "transportation": [ "Car", "Foot" ],
            }),
          ),
        ),
      ),
    );

    expect(find.text("test"), findsOneWidget);
    expect(find.text("description"), findsOneWidget);
    expect(find.text("santa monica"), findsOneWidget);
    expect(find.text("3 days"), findsOneWidget);
    expect(find.text(DateFormat("dd/MM/yyyy HH:mm").format(DateTime(2026))), findsOneWidget);
    expect(find.text("Car"), findsOneWidget);
    expect(find.text("Foot"), findsOneWidget);

    expect(find.byType(TextFormField), findsNWidgets(6));
    expect(find.byType(CheckboxListTile), findsNothing);
    expect(find.byType(PillButton), findsOneWidget);
  });

  testWidgets("event edit transport", (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EventEditPage(),
        ),
      ),
    );

    final addButton = find.byType(IconButton);
    await tester.ensureVisible(addButton);
    await tester.enterText(find.byType(TextFormField).at(6), "test");
    await tester.tap(addButton);
    await tester.pump();
    expect(find.text("test"), findsOneWidget);

    final chipFinder = find.byWidgetPredicate(
      (widget) => widget is Chip && widget.label is Text && (widget.label as Text).data == "test"
    );
    final deleteIconFinder = find.descendant(
      of: chipFinder,
      matching: find.byIcon(Icons.cancel),
    );
    await tester.tap(deleteIconFinder);
    await tester.pumpAndSettle();
    expect(find.text("test"), findsNothing);
  });
}