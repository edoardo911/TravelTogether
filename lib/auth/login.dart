import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travel_together/auth/auth_service.dart';
import 'package:travel_together/widgets/pill_button.dart';
import 'package:travel_together/widgets/pill_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _authController = AuthController(AmplifyAuthService());

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if(!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });
    final logged = await _authController.login(_emailController.text, _passwordController.text);
    setState(() {
      _isLoading = false;
    });
    if(logged && mounted) {
      Navigator.pushReplacementNamed(context, "/home");
    } else {
      Fluttertoast.showToast(
        msg: "Email o password errati",
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
                    "Login",
                    style: TextStyle(fontSize: 50),
                  ),
                  const SizedBox(height: 32),
                  PillInput(
                    hint: "Email",
                    controller: _emailController,
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return "Inserisci una mail";
                      }
                      if(!value.contains("@")) {
                        return "Inserisci una mail valida";
                      }
                      return null;
                    }
                  ),
                  const SizedBox(height: 24),
                  PillInput(
                    hint: "Password",
                    controller: _passwordController,
                    obscure: true,
                    validator: (value) {
                      if(value == null || value.length < 8) {
                        return "Minimo 8 caratteri";
                      }
                      return null;
                    }
                  ),
                  const SizedBox(height: 32),
                  PillButton(
                    text: "Login",
                    icon: Icons.login,
                    onPressed: _isLoading ? null : _submit,
                  ),
                  SizedBox(height: 16),
                  Text("oppure"),
                  SizedBox(height: 16),
                  PillButton(
                    text: "Registrati",
                    icon: Icons.arrow_right_alt_sharp,
                    primary: false,
                    onPressed: () => Navigator.pushReplacementNamed(context, "/register"),
                  ),
                ],
              ),
            ),
          ) : CircularProgressIndicator(),
        ),
      ),
    );
  }
}