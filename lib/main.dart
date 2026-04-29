import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:travel_together/auth/auth_service.dart';
import 'package:travel_together/auth/home.dart';
import 'package:travel_together/auth/register.dart';
import 'package:travel_together/auth/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (_) => SplashScreen(authService: AuthService(FlutterSecureStorage())),
        '/home': (_) => HomeScreen(),
        '/register': (_) => RegisterScreen(),
      },
    );
  }
}