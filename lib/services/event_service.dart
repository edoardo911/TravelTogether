import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travel_together/models/event.dart';

//abstract class for testability
abstract class EventService {
  Future<List<Event>> getEventsByAuthorUUID(String uuid);
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
      if(response.statusCode == 200) {
        final rawData = jsonDecode(response.decodeBody())["events"];
        return List<Event>.from(rawData.map((json) => Event.fromJson(json)));
      }
    } on Exception catch(e) {
      debugPrint("Exception: $e");
      Fluttertoast.showToast(
        msg: "Error retrieving this user's events",
        gravity: ToastGravity.BOTTOM,
      );
      return [];
    }
    return [];
  }
}

//controller
class EventController {
  EventService eventService;

  EventController(this.eventService);

  Future<List<Event>> getEventsByAuthorUUID(String uuid) async {
    return await eventService.getEventsByAuthorUUID(uuid);
  }
}