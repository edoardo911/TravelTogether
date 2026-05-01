import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travel_together/auth/auth_service.dart';
import 'package:travel_together/widgets/code_input6.dart';

class ConfirmPage extends StatefulWidget {
  const ConfirmPage({super.key});

  @override
  State<ConfirmPage> createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  final _authController = AuthController(AmplifyAuthService());

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void onCodeEnter(String code) async {
    setState(() {
      _isLoading = true;
    });

    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final result = await _authController.confirm(args["email"], args["name"], args["password"], code);

    setState(() {
      _isLoading = false;
    });

    if(result && mounted) {
      Navigator.pushReplacementNamed(context, "/home");
    } else {
      await _authController.register(args["name"], args["email"], args["password"]);
      Fluttertoast.showToast(
        msg: "Il codice non è corretto, riprova",
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 16),
          child: !_isLoading ? Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Inserisci il codice di verifica che hai ottenuto per email",
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32),
                  CodeInput6(onCompleted: onCodeEnter),
                ]
              ),
            ),
          ) :  CircularProgressIndicator(),
        ),
      ),
    );
  }
}
