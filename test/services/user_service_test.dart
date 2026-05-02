import 'package:flutter_test/flutter_test.dart';
import 'package:travel_together/services/user_service.dart';

class UserServiceTest implements UserService {
  @override
  Future<Map<String, dynamic>> getUserById(String uuid) async {
    if(uuid == "asd123") {
      return {
        "id": "172983",
        "uuid": "asd123",
        "name": "test",
        "email": "test@test.com",
      };
    } else {
      return {
        "id": "",
        "uuid": "",
        "name": "",
        "email": "",
      };
    }
  }
}

void main() {
  test("user present", () async {
    final userController = UserController(UserServiceTest());
    final user = await userController.getUserById("asd123");

    expect(user.id, "172983");
    expect(user.uuid, "asd123");
    expect(user.name, "test");
    expect(user.email, "test@test.com");
  });

  test("user not present", () async {
    final userController = UserController(UserServiceTest());
    final user = await userController.getUserById("asd1234");

    expect(user.uuid, "");
  });
}