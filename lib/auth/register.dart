import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travel_together/services/auth_service.dart';
import 'package:travel_together/widgets/pill_button.dart';
import 'package:travel_together/widgets/pill_input.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _authController = AuthController(AmplifyAuthService());

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordController2 = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordController2.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if(!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });
    final success = await _authController.register(_nameController.text.trim(), _emailController.text.trim(), _passwordController.text);
    setState(() {
      _isLoading = false;
    });

    if(success && mounted) {
      Navigator.pushReplacementNamed(
        context,
        "/confirm",
        arguments: {
          "email": _emailController.text,
          "name": _nameController.text,
          "password": _passwordController.text,
        }
      );
    } else {
      Fluttertoast.showToast(
        msg: "Errore server",
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
                    "Sign In",
                    style: TextStyle(fontSize: 50),
                  ),
                  const SizedBox(height: 32),
                  PillInput(
                    hint: "Nome",
                    controller: _nameController,
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return "Inserisci il nome";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  PillInput(
                    hint: "Email",
                    controller: _emailController,
                    inputType: TextInputType.emailAddress,
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
                  const SizedBox(height: 24),
                  PillInput(
                    hint: "Conferma Password",
                    controller: _passwordController2,
                    obscure: true,
                    validator: (value) {
                      if(value == null || value.length < 8) {
                        return "Minimo 8 caratteri";
                      }
                      if(value != _passwordController.text) {
                        return "Le password devono corrispondere";
                      }
                      return null;
                    }
                  ),
                  const SizedBox(height: 32),
                  PillButton(
                    text: "Registrati",
                    icon: Icons.arrow_right_alt_sharp,
                    onPressed: _isLoading ? null : _submit,
                  ),
                  SizedBox(height: 16),
                  Text("oppure"),
                  SizedBox(height: 16),
                  PillButton(
                    text: "Log In",
                    icon: Icons.login,
                    primary: false,
                    onPressed: () => Navigator.pushReplacementNamed(context, "/login"),
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