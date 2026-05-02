import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:travel_together/home/user/user.dart';

class ProfilePage extends StatefulWidget {
  final bool isLogged;

  const ProfilePage({super.key, this.isLogged = false});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String uuid = "";

  Future<void> getUUID() async {
    final user = await Amplify.Auth.getCurrentUser();
    setState(() {
      uuid = user.userId;
    });
  }

  @override
  void initState() {
    super.initState();
    getUUID();
  }

  @override
  Widget build(BuildContext context) {
    return uuid != "" ? UserPage(
      uuid: uuid,
      isLogged: widget.isLogged,
    ) : CircularProgressIndicator();
  }
}
