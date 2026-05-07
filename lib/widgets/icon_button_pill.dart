import 'package:flutter/material.dart';

class IconButtonPill extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final bool primary;

  const IconButtonPill({
    super.key,
    required this.onPressed,
    required this.icon,
    this.primary = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primary ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surface,
          foregroundColor: primary ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.primary,
          padding: EdgeInsets.all(10),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        child: Icon(icon),
      ),
    );
  }
}
