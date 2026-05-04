import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travel_together/models/user.dart';

abstract class UserService {
  Future<Map<String, dynamic>> getUserById(String uuid);
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
      return {};
    }
    return {};
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
}