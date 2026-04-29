import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:travel_together/auth/auth_service.dart';

class MockStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late MockStorage storage;
  late AuthService authService;

  setUp(() {
    storage = MockStorage();
    authService = AuthService(storage);
  });

  test("is logged in", () async {
    when(() => storage.read(key: "jwt")).thenAnswer((_) async => "token123");

    final result = await authService.isLoggedIn();
    expect(result, true);
  });

  test("is not logged in", () async {
    when(() => storage.read(key: "jwt")).thenAnswer((_) async => null);

    final result = await authService.isLoggedIn();
    expect(result, false);
  });
}