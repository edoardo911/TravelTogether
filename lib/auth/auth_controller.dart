import 'package:flutter/cupertino.dart';
import 'package:travel_together/auth/auth_service.dart';

class AuthController {
  final AuthService service;

  AuthController(this.service);

  Future<bool> register(String name, String email, String password) async {
    debugPrint("$name $email $password");
    return false;
  }

  Future<bool> login(String email, String password) async {
    debugPrint("$email $password");
    return false;
  }
}