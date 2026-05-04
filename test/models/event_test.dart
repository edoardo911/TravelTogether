import 'package:flutter_test/flutter_test.dart';
import 'package:travel_together/models/event.dart';

void main() {
  test("event from json", () {
    final date = "2026-05-03T02:28:25Z";
    final json = {
      "id": "123123",
      "name": "test",
      "description": "test test test",
      "location": "santa monica",
      "authorUUID": "123123",
      "maxParticipants": 9,
      "duration": "3 days",
      "date": date,
      "participants": [ "Mario", "Luigi" ],
      "transportation": [ "Car" ],
    };

    final event = Event.fromJson(json);
    expect(event.id, "123123");
    expect(event.name, "test");
    expect(event.description, "test test test");
    expect(event.location, "santa monica");
    expect(event.authorUUID, "123123");
    expect(event.maxParticipants, 9);
    expect(event.duration, "3 days");
    expect(event.date, DateTime.parse(date));
    expect(event.participants, [ "Mario", "Luigi" ]);
    expect(event.transportation, [ "Car" ]);
  });

  test("json to event no lists", () {
    final date = "2026-05-03T02:28:25.000Z";
    final event = Event(
      id: "123123",
      name: "test",
      description: "test test test",
      location: "santa monica",
      authorUUID: "123123",
      maxParticipants: 9,
      duration: "3 days",
      date: DateTime.parse(date),
    );

    final json = event.toJson();
    expect(json["id"], null);
    expect(json["name"], "test");
    expect(json["description"], "test test test");
    expect(json["location"], "santa monica");
    expect(json["authorUUID"], "123123");
    expect(json["maxParticipants"], 9);
    expect(json["duration"], "3 days");
    expect(json["date"], date);
  });

  test("json to event", () {
    final date = "2026-05-03T02:28:25.000Z";
    final event = Event(
      id: "123123",
      name: "test",
      description: "test test test",
      location: "santa monica",
      authorUUID: "123123",
      maxParticipants: 9,
      duration: "3 days",
      date: DateTime.parse(date),
      participants: [ "Mario", "Luigi" ],
      transportation: [ "Car" ],
    );

    final json = event.toJson();
    expect(json["participants"], [ "Mario", "Luigi" ]);
    expect(json["transportation"], [ "Car" ]);
  });
}