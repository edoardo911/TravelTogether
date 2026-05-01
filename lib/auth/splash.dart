import 'package:flutter/material.dart';
import 'package:travel_together/auth/auth_service.dart';

class SplashScreen extends StatefulWidget {
  final AuthController authController;

  const SplashScreen({super.key, required this.authController});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    if(!mounted) return;

    if(await widget.authController.isLoggedIn()) {
      Navigator.pushReplacementNamed(context, "/home");
    } else {
      Navigator.pushReplacementNamed(context, "/register");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
