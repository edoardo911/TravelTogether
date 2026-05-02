import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  final int amount;
  final String label;
  final VoidCallback action;

  const ProfileInfo({
    super.key,
    required this.amount,
    required this.label,
    required this.action
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
              amount.toString(),
              style: TextStyle(
                fontSize: 32,
              )
            ),
            Text(label),
          ],
        ),
      ),
    );
  }
}
