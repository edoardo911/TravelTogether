import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:travel_together/services/auth_service.dart';
import 'package:travel_together/auth/splash.dart';

class MockAuthController extends Mock implements AuthController {}

void main() {
  testWidgets("splash navigation to home", (tester) async {
    final auth = MockAuthController();

    when(() => auth.isLoggedIn()).thenAnswer((_) async => true);

    await tester.pumpWidget(
      MaterialApp(
        routes: {
          '/home': (_) => const Text("HOME"),
          '/register': (_) => const Text("REGISTER"),
        },
        home: SplashScreen(authController: auth),
      ),
    );

    await tester.pump();
    await tester.pumpAndSettle();
    expect(find.text("HOME"), findsOneWidget);
  });

  testWidgets("splash navigation to register", (tester) async {
    final auth = MockAuthController();

    when(() => auth.isLoggedIn()).thenAnswer((_) async => false);

    await tester.pumpWidget(
      MaterialApp(
        routes: {
          '/home': (_) => const Text("HOME"),
          '/register': (_) => const Text("REGISTER"),
        },
        home: SplashScreen(authController: auth),
      ),
    );

    await tester.pump();
    await tester.pumpAndSettle();
    expect(find.text("REGISTER"), findsOneWidget);
  });
}