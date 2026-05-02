import 'package:flutter/material.dart';

class PillButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool primary;
  final bool occupyAllScreen;

  const PillButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.primary = true,
    this.occupyAllScreen = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: occupyAllScreen ? double.infinity : null,
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
            if(text.isNotEmpty) ...[
              Text(text),
              SizedBox(width: 8),
            ],
            Icon(icon),
          ],
        ),
      ),
    );
  }
}