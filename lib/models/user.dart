class User {
  final String uuid;
  final String name;
  final String email;

  User({
    required this.uuid,
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uuid: json["_id"],
      name: json["name"],
      email: json["email"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": uuid,
      "name": name,
      "email": email,
    };
  }
}