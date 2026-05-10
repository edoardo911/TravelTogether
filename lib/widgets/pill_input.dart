import 'package:flutter/material.dart';

typedef Validator = String? Function(String?);

class PillInput extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool obscure;
  final Validator? validator;
  final TextInputType inputType;
  final IconData? suffixIcon;
  final Function(String)? onSubmit;

  const PillInput({
    super.key,
    required this.hint,
    required this.controller,
    this.obscure = false,
    this.validator,
    this.inputType = TextInputType.text,
    this.suffixIcon,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: inputType,
      onFieldSubmitted: onSubmit,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
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