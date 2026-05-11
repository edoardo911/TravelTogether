import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travel_together/models/user.dart';

abstract class UserService {
  Future<Map<String, dynamic>> getUserById(String uuid);
  Future<List<User>> getUsersByIDs(List<String> ids);
  Future<List<User>> searchByName(String name);
  Future<String> getCurrentUserUUID();
}

class AmplifyUserService implements UserService {
  @override
  Future<Map<String, dynamic>> getUserById(String uuid) async {
    try {
      final restOperation = Amplify.API.get(
        "/users/$uuid",
        apiName: "users",
      );
      final response = await restOperation.response;
      final body = jsonDecode(response.decodeBody());
      if(response.statusCode == 200) {
        return body;
      }
    } on Exception catch(e) {
      debugPrint("$e");
      return {};
    }
    return {};
  }

  @override
  Future<List<User>> getUsersByIDs(List<String> ids) async {
    try {
      final restOperation = Amplify.API.put(
        "/group",
        apiName: "users",
        body: HttpPayload.json({
          "ids": ids,
        }),
      );
      final response = await restOperation.response;
      if(response.statusCode == 200) {
        final rawData = jsonDecode(response.decodeBody())["users"];
        return List<User>.from(rawData.map((json) => User.fromJson(json)));
      }
    } on Exception catch(e) {
      debugPrint("$e");
      return [];
    }
    return [];
  }

  @override
  Future<List<User>> searchByName(String name) async {
    try {
      final restOperation = Amplify.API.get(
        "/search/$name",
        apiName: "users",
      );
      final response = await restOperation.response;
      final rawData = jsonDecode(response.decodeBody())["users"];
      return List<User>.from(rawData.map((json) => User.fromJson(json)));
    } on Exception catch(e) {
      debugPrint("Exception: $e");
      Fluttertoast.showToast(
        msg: "Error retrieving users",
        gravity: ToastGravity.BOTTOM,
      );
      return [];
    }
  }

  @override
  Future<String> getCurrentUserUUID() async {
    final user = await Amplify.Auth.getCurrentUser();
    return user.userId;
  }
}

class UserController {
  final UserService userService;

  UserController(this.userService);

  Future<User> getUserById(String uuid) async {
    final json = await userService.getUserById(uuid);
    if(json["uuid"] == null) {
      Fluttertoast.showToast(
        msg: "Error retrieving user $uuid",
        gravity: ToastGravity.BOTTOM,
      );
    }
    return User.fromJson(json);
  }

  Future<List<User>> getUsersByIDs(List<String> ids) async {
    return await userService.getUsersByIDs(ids);
  }

  Future<List<User>> searchByName(String name) async {
    return await userService.searchByName(name);
  }

  Future<String> getCurrentUserUUID() async {
    return await userService.getCurrentUserUUID();
  }
}