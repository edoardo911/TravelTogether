import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_together/home/events/event_widget.dart';
import 'package:travel_together/models/event.dart';
import 'package:travel_together/widgets/pill_button.dart';

void main() {
  testWidgets("test texts", (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EventWidget(
            refresh: () {},
            event: Event.fromJson({
              "id": "event0",
              "name": "test",
              "description": "test test test",
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
    expect(find.text("01/01/2026 00:00, santa monica"), findsOneWidget);
    expect(find.text("test test test"), findsOneWidget);
    expect(find.text("Posti: 2/9"), findsOneWidget);
    expect(find.text("Tratta: Car, Foot"), findsOneWidget);
  });

  testWidgets("event widget on delete", (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EventWidget(
            refresh: () {},
            event: Event.fromJson({
              "id": "event0",
              "name": "test",
              "description": "test test test",
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

    await tester.tap(find.byType(PillButton));
    await tester.pump();

    expect(find.text("Sei sicuro di voler eliminare questo viaggio?"), findsOneWidget);
    expect(find.byType(TextButton), findsNWidgets(2));
  });
}