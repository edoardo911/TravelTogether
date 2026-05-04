import 'package:flutter_test/flutter_test.dart';
import 'package:travel_together/models/user.dart';

void main() {
  test("user from json", () {
    final json = {
      "_id": "123",
      "uuid": "123",
      "name": "TEST",
      "email": "test@test.com"
    };

    final user = User.fromJson(json);
    expect(user.id, "123");
    expect(user.uuid, "123");
    expect(user.name, "TEST");
    expect(user.email, "test@test.com");
  });

  test("json to user", () {
    final user = User(
      id: "123",
      uuid: "123",
      name: "TEST",
      email: "test@test.com",
    );

    final json = user.toJson();
    expect(json["id"], null);
    expect(json["uuid"], "123");
    expect(json["name"], "TEST");
    expect(json["email"], "test@test.com");
  });
}