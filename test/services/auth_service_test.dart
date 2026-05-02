import 'package:flutter_test/flutter_test.dart';
import 'package:travel_together/services/auth_service.dart';

class AuthServiceTest implements AuthService {
  @override
  Future<bool> isLoggedIn() async {
    return true;
  }

  @override
  Future<void> signUp(String name, String email, String password) async {
    if(email == "test@test.com") {
      throw Exception("");
    }
  }

  @override
  Future<void> signIn(String email, String password) async {
    if(email == "test@test.com" && password != "test123") {
      throw Exception("");
    }
  }

  @override
  Future<bool> confirm(String email, String name, String password, String code) async {
    return email == "test@test.com" && code == "123456";
  }

  @override
  Future<void> logOut() async {}
}

void main() {
  test("authentication success", () async {
    final auth = AuthController(AuthServiceTest());

    expect(await auth.isLoggedIn(), true);
    expect(await auth.register("test", "test2@test.com", "test123"), true);
    expect(await auth.login("test@test.com", "test123"), true);
    expect(await auth.confirm("test@test.com", "test", "test123", "123456"), true);
  });

  test("authentication fail", () async {
    final auth = AuthController(AuthServiceTest());

    expect(await auth.isLoggedIn(), true);
    expect(await auth.register("test", "test@test.com", "test123"), false);
    expect(await auth.login("test@test.com", "123"), false);
    expect(await auth.confirm("test@test.com", "test", "test123", "1234567"), false);
  });
}