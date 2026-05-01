import 'package:flutter/material.dart';
import 'package:travel_together/auth/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _authController = AuthController(AmplifyAuthService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {
                _authController.logOut();
                Navigator.pushReplacementNamed(context, "/");
              },
              child: Text("Log out")),
          ],
        ),
      ),
    );
  }
}