import 'package:flutter_test/flutter_test.dart';
import 'package:travel_together/models/event.dart';
import 'package:travel_together/services/event_service.dart';

class EventServiceTest implements EventService {
  @override
  Future<List<Event>> getEventsByAuthorUUID(String uuid) async {
    if(uuid == "asd123") {
      return [
        Event.fromJson({
          "id": "event0",
          "name": "test",
          "description": "test test test",
          "location": "santa monica",
          "authorUUID": "asd123",
          "maxParticipants": 9,
          "duration": "3 days",
          "date": DateTime(2026).toIso8601String(),
          "participants": [ "Mario", "Luigi" ],
          "transportation": [ "Car" ],
        }),
        Event.fromJson({
          "id": "event1",
          "name": "test2",
          "description": "batteries",
          "location": "Bergamo Sopra",
          "authorUUID": "asd123",
          "maxParticipants": 9,
          "duration": "3 days",
          "date": DateTime(2027).toIso8601String(),
          "participants": [ "Wario", "Waluigi" ],
          "transportation": [ "Train" ],
        }),
      ];
    }
    return [];
  }

  @override
  Future<bool> removeEventByID(String id) async {
    return id == "event0" || id == "event1";
  }

  @override
  Future<bool> enroll(String eventId, String id) async {
    return id == "asd123";
  }

  @override
  Future<bool> dismiss(String eventId, String id) async {
    return id == "asd456";
  }

  @override
  Future<bool> update(Event event) async {
    return event.id == "event0";
  }

  @override
  Future<bool> create(Event event) async {
    return event.id == "event1";
  }
}

void main() {
  test("events present", () async {
    final controller = EventController(EventServiceTest());
    final events = await controller.getEventsByAuthorUUID("asd123");

    expect(events.length, 2);
    expect(events[1].id, "event1");
    expect(events[1].name, "test2");
    expect(events[1].description, "batteries");
    expect(events[1].location, "Bergamo Sopra");
    expect(events[1].authorUUID, "asd123");
    expect(events[1].maxParticipants, 9);
    expect(events[1].duration, "3 days");
    expect(events[1].date, DateTime(2027));
    expect(events[1].participants, [ "Wario", "Waluigi" ]);
    expect(events[1].transportation, [ "Train" ]);
  });

  test("events not present", () async {
    final controller = EventController(EventServiceTest());
    final events = await controller.getEventsByAuthorUUID("123456");

    expect(events.length, 0);
  });

  test("test remove", () async {
    final controller = EventController(EventServiceTest());
    expect(await controller.removeEventByID("event1"), true);
    expect(await controller.removeEventByID("event2"), false);
  });

  test("test enroll", () async {
    final controller = EventController(EventServiceTest());
    expect(await controller.enroll("", "asd123"), true);
    expect(await controller.enroll("", "asd456"), false);
  });

  test("test dismiss", () async {
    final controller = EventController(EventServiceTest());
    expect(await controller.dismiss("", "asd123"), false);
    expect(await controller.dismiss("", "asd456"), true);
  });

  test("test update", () async {
    final controller = EventController(EventServiceTest());
    final result = await controller.update(Event.fromJson({
      "id": "event0",
      "name": "test",
      "description": "test test test",
      "location": "santa monica",
      "authorUUID": "asd123",
      "maxParticipants": 9,
      "duration": "3 days",
      "date": DateTime(2026).toIso8601String(),
      "participants": [ "Mario", "Luigi" ],
      "transportation": [ "Car" ],
    }));
    expect(result, true);
  });

  test("test create", () async {
    final controller = EventController(EventServiceTest());
    final result = await controller.create(Event.fromJson({
      "id": "event0",
      "name": "test",
      "description": "test test test",
      "location": "santa monica",
      "authorUUID": "asd123",
      "maxParticipants": 9,
      "duration": "3 days",
      "date": DateTime(2026).toIso8601String(),
      "participants": [ "Mario", "Luigi" ],
      "transportation": [ "Car" ],
    }));
    expect(result, false);
  });
}