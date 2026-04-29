import 'package:flutter/material.dart';

typedef Validator = String? Function(String?);

class PillInput extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool obscure;
  final Validator? validator;

  const PillInput({
    super.key,
    required this.hint,
    required this.controller,
    this.obscure = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(999),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
        validator: validator,
    );
  }
}