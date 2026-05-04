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
}