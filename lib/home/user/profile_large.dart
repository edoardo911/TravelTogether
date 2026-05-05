import 'package:flutter/material.dart';
import 'package:travel_together/home/user/user.dart';

class ProfileLargePage extends StatelessWidget {
  final String uuid;
  final bool isLogged;

  const ProfileLargePage({super.key, required this.uuid, required this.isLogged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Utente"),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: UserPage(uuid: uuid, isLogged: isLogged),
      ),
    );
  }
}
