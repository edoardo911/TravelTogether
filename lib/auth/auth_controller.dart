import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:travel_together/auth/auth_service.dart';

class AuthController {
  final AuthService service;

  AuthController(this.service);

  Future<bool> register(String name, String email, String password) async {
    await Amplify.Auth.signUp(
      username: email,
      password: password,
    );
    return true;
  }

  Future<bool> login(String email, String password) async {
    debugPrint("$email $password");
    return true;
  }

  Future<bool> confirm(String email, String password) async {
    await Amplify.Auth.signIn(
      username: email,
      password: password,
    );

    final user = await Amplify.Auth.getCurrentUser();
    debugPrint(user.userId);
    debugPrint(user.username);
    // try {
    //   final restOperation = Amplify.API.post(
    //     "/register",
    //     body: HttpPayload.json({
    //       "uuid": user.userId,
    //       "name": name,
    //       "email": email
    //     }),
    //   );
    //   final response = await restOperation.response;
    //   if(response.statusCode != 200) {
    //     debugPrint("ERROR CODE: ${response.statusCode}");
    //     return false;
    //   }
    // } on ApiException catch(e) {
    //   debugPrint("POST call failed: $e");
    //   return false;
    // }

    return false;
  }
}