import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travel_together/models/event.dart';

//abstract class for testability
abstract class EventService {
  Future<List<Event>> getEventsByAuthorUUID(String uuid);
  Future<List<Event>> searchByName(String name);
  Future<bool> removeEventByID(String id);

  Future<bool> enroll(String eventId, String id);
  Future<bool> dismiss(String eventId, String id);

  Future<bool> update(Event event);
  Future<bool> create(Event event);
}

//amplify implementation
class AmplifyEventService implements EventService {
  @override
  Future<List<Event>> getEventsByAuthorUUID(String uuid) async {
    try {
      final restOperation = Amplify.API.get(
        "/events/$uuid",
        apiName: "events",
      );
      final response = await restOperation.response;
      final rawData = jsonDecode(response.decodeBody())["events"];
      return List<Event>.from(rawData.map((json) => Event.fromJson(json)));
    } on Exception catch(e) {
      debugPrint("Exception: $e");
      Fluttertoast.showToast(
        msg: "Error retrieving this user's events",
        gravity: ToastGravity.BOTTOM,
      );
      return [];
    }
  }

  @override
  Future<List<Event>> searchByName(String name) async {
    try {
      final restOperation = Amplify.API.get(
        "/search/$name",
        apiName: "events",
      );
      final response = await restOperation.response;
      final rawData = jsonDecode(response.decodeBody())["events"];
      return List<Event>.from(rawData.map((json) => Event.fromJson(json)));
    } on Exception catch(e) {
      debugPrint("Exception: $e");
      Fluttertoast.showToast(
        msg: "Error retrieving events",
        gravity: ToastGravity.BOTTOM,
      );
      return [];
    }
  }

  @override
  Future<bool> removeEventByID(String id) async {
    try {
      final restOperation = Amplify.API.delete(
        "/remove/$id",
        apiName: "events",
      );
      final response = await restOperation.response;
      if(response.statusCode == 200) {
        return true;
      }
    } on Exception catch(e) {
      debugPrint("Exception: $e");
      Fluttertoast.showToast(
        msg: "Error deleting the event",
        gravity: ToastGravity.BOTTOM,
      );
      return false;
    }
    return false;
  }

  @override
  Future<bool> enroll(String eventId, String id) async {
    try {
      final restOperation = Amplify.API.put(
        "/enroll/$eventId",
        apiName: "events",
        body: HttpPayload.json({
          "id": id,
        }),
      );
      final response = await restOperation.response;
      if(response.statusCode == 200) {
        return true;
      }
    } on Exception catch(e) {
      debugPrint("$e");
      return false;
    }
    return false;
  }

  @override
  Future<bool> dismiss(String eventId, String id) async {
    try {
      final restOperation = Amplify.API.put(
        "/dismiss/$eventId",
        apiName: "events",
        body: HttpPayload.json({
          "id": id,
        }),
      );
      final response = await restOperation.response;
      if(response.statusCode == 200) {
        return true;
      }
    } on Exception catch(e) {
      debugPrint("$e");
      return false;
    }
    return false;
  }

  @override
  Future<bool> update(Event event) async {
    try {
      final restOperation = Amplify.API.put(
        "/update/${event.id}",
        apiName: "events",
        body: HttpPayload.json(event.toJson()),
      );
      final response = await restOperation.response;
      if(response.statusCode == 200) {
        return true;
      }
    } on Exception catch(e) {
      debugPrint("$e");
      return false;
    }
    return false;
  }

  @override
  Future<bool> create(Event event) async {
    try {
      final restOperation = Amplify.API.post(
        "/create",
        apiName: "events",
        body: HttpPayload.json(event.toJson()),
      );
      final response = await restOperation.response;
      if(response.statusCode == 200) {
        return true;
      }
    } on Exception catch(e) {
      debugPrint("$e");
      return false;
    }
    return false;
  }
}

//controller
class EventController {
  EventService eventService;

  EventController(this.eventService);

  Future<List<Event>> getEventsByAuthorUUID(String uuid) async {
    return await eventService.getEventsByAuthorUUID(uuid);
  }

  Future<List<Event>> searchByName(String name) async {
    return await eventService.searchByName(name);
  }

  Future<bool> removeEventByID(String id) async {
    return await eventService.removeEventByID(id);
  }

  Future<bool> enroll(String eventId, String id) async {
    return await eventService.enroll(eventId, id);
  }

  Future<bool> dismiss(String eventId, String id) async {
    return await eventService.dismiss(eventId, id);
  }

  Future<bool> update(Event event) async {
    return await eventService.update(event);
  }

  Future<bool> create(Event event) async {
    return await eventService.create(event);
  }
}