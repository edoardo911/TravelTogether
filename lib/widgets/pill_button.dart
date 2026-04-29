import 'package:flutter/material.dart';

class PillButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool primary;

  const PillButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.primary = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primary ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surface,
          foregroundColor: primary ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.primary,
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text),
            SizedBox(width: 8),
            Icon(icon),
          ],
        ),
      ),
    );
  }
}