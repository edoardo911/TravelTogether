import 'package:flutter_test/flutter_test.dart';
import 'package:travel_together/models/user.dart';
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

  @override
  Future<List<User>> getUsersByIDs(List<String> ids) async {
    List<User> result = [];
    ids.forEach((uuid) async {
      if(uuid == "asd123") {
        result.add(User.fromJson({
          "id": "asd123",
          "uuid": "asd123",
          "name": "test",
          "email": "test@test.com",
        }));
      }
      if(uuid == "asd456") {
        result.add(User.fromJson({
          "id": "asd456",
          "uuid": "asd123",
          "name": "test",
          "email": "test@test.com",
        }));
      }
    });
    return result;
  }

  @override
  Future<List<User>> searchByName(String name) async {
    if(name == "test") {
      return [
        User.fromJson({
          "id": "asd123",
          "uuid": "asd123",
          "name": "test",
          "email": "test@test.com",
        }),
        User.fromJson({
          "id": "asd456",
          "uuid": "asd456",
          "name": "test",
          "email": "test@test.com",
        }),
      ];
    } else {
      return [];
    }
  }

  @override
  Future<String> getCurrentUserUUID() async { return ""; }
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

  test("get users by ids empty", () async {
    final userController = UserController(UserServiceTest());
    final users = await userController.getUsersByIDs([]);
    expect(users.length, 0);
  });

  test("get users by ids not empty", () async {
    final userController = UserController(UserServiceTest());
    final users = await userController.getUsersByIDs([ "asd123", "oh093f3027grf" ]);
    expect(users.length, 1);
  });

  test("search users present", () async {
    final userController = UserController(UserServiceTest());
    final users = await userController.searchByName("test");
    expect(users.length, 2);
    expect(users[1].id, "asd456");
    expect(users[1].uuid, "asd456");
    expect(users[1].name, "test");
    expect(users[1].email, "test@test.com");
  });

  test("search users not present", () async {
    final userController = UserController(UserServiceTest());
    final users = await userController.searchByName("asdaveibevoaovbiaes");
    expect(users.length, 0);
  });
}