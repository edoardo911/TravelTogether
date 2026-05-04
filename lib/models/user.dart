class User {
  final String id;
  final String uuid;
  final String name;
  final String email;

  User({
    required this.id,
    required this.uuid,
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["_id"] ?? json["id"],
      uuid: json["uuid"],
      name: json["name"],
      email: json["email"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uuid": uuid,
      "name": name,
      "email": email,
    };
  }
}