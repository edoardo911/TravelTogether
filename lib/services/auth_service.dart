import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';

//abstract auth service for testability
abstract class AuthService {
  Future<bool> isLoggedIn();
  Future<void> signUp(String name, String email, String password);
  Future<void> signIn(String email, String password);
  Future<bool> confirm(String email, String name, String password, String code);
  Future<void> logOut();
}

//amplify auth service
class AmplifyAuthService implements AuthService {
  @override
  Future<bool> isLoggedIn() async {
    final session = await Amplify.Auth.fetchAuthSession();
    return session.isSignedIn;
  }

  @override
  Future<void> signUp(String name, String email, String password) async {
    await Amplify.Auth.signUp(
      username: email,
      password: password,
    );
  }

  @override
  Future<void> signIn(String email, String password) async {
    await Amplify.Auth.signIn(
      username: email,
      password: password,
    );
  }

  @override
  Future<bool> confirm(String email, String name, String password, String code) async {
    final result = await Amplify.Auth.confirmSignUp(
        username: email,
        confirmationCode: code
    );
    if(!result.isSignUpComplete) {
      return false;
    }
    await Amplify.Auth.signIn(
      username: email,
      password: password,
    );

    final user = await Amplify.Auth.getCurrentUser();
    try {
      final restOperation = Amplify.API.post(
        "/create",
        body: HttpPayload.json({
          "uuid": user.userId,
          "name": name,
          "email": email
        }),
      );
      final response = await restOperation.response;
      if(response.statusCode != 200) {
        debugPrint("ERROR CODE: ${response.statusCode}");
        return false;
      }
    } on ApiException catch(e) {
      debugPrint("POST call failed: $e");
      return false;
    }
    return true;
  }

  @override
  Future<void> logOut() async {
    await Amplify.Auth.signOut();
  }
}

//auth controller
class AuthController {
  final AuthService authService;

  AuthController(this.authService);

  Future<bool> isLoggedIn() async {
    return await authService.isLoggedIn();
  }

  Future<bool> register(String name, String email, String password) async {
    try {
      await authService.signUp(name, email, password);
    } on Exception catch(_) {
      return false;
    }
    return true;
  }

  Future<bool> login(String email, String password) async {
    try {
      await authService.signIn(email, password);
    } on Exception catch(_) {
      return false;
    }
    return true;
  }

  Future<bool> confirm(String email, String name, String password, String code) async {
    try {
      return await authService.confirm(email, name, password, code);
    } on Exception catch(_) {
      return false;
    }
  }

  Future<bool> logOut() async {
    try {
      await authService.logOut();
    } on Exception catch(_) {
      return false;
    }
    return true;
  }
}