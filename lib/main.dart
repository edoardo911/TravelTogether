import 'package:flutter/material.dart';
import 'package:travel_together/amplify_setup.dart';
import 'package:travel_together/home/events/event.dart';
import 'package:travel_together/home/user/profile_large.dart';
import 'package:travel_together/home/user/user.dart';
import 'package:travel_together/models/event.dart';
import 'package:travel_together/services/auth_service.dart';
import 'package:travel_together/auth/confirm.dart';
import 'package:travel_together/auth/login.dart';
import 'package:travel_together/auth/splash.dart';
import 'package:travel_together/home/home.dart';
import 'package:travel_together/auth/register.dart';
import 'package:travel_together/themes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureAmplify();
  runApp(const TravelTogether());
}

class TravelTogether extends StatelessWidget {
  const TravelTogether({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (_) => SplashScreen(authController: AuthController(AmplifyAuthService())),
        '/home': (_) => HomeScreen(),
        '/register': (_) => RegisterScreen(),
        '/login': (_) => LoginScreen(),
        '/confirm': (_) => ConfirmPage(),
        '/event': (context) => EventPage(
          event: (ModalRoute.of(context)!.settings.arguments as Map)["event"]
        ),
        '/user': (context) => ProfileLargePage(
          uuid: (ModalRoute.of(context)!.settings.arguments as Map)["uuid"],
          isLogged: (ModalRoute.of(context)!.settings.arguments as Map)["logged"],
        ),
      },
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
    );
  }
}