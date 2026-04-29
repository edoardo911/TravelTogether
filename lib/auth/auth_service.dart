import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final FlutterSecureStorage storage;

  AuthService(this.storage);

  Future<bool> isLoggedIn() async {
    final token = await storage.read(key: "jwt");
    return token != null;
  }
}