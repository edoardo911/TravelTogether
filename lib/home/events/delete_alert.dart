import 'package:flutter/material.dart';

class DeleteAlert extends StatelessWidget {
  final VoidCallback action;

  const DeleteAlert({super.key, required this.action});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Conferma Eliminazione"),
      content: const Text("Sei sicuro di voler eliminare questo viaggio?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("No"),
        ),
        TextButton(
          onPressed: () => action(),
          child: const Text("Si"),
        ),
      ]
    );
  }
}
