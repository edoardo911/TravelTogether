import 'package:flutter/material.dart';
import 'package:travel_together/models/user.dart';
import 'package:travel_together/widgets/pill_button.dart';

class UserWidget extends StatefulWidget {
  final User user;

  const UserWidget({super.key, required this.user});

  @override
  State<UserWidget> createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context, "/user",
        arguments: {
          "uuid": widget.user.uuid,
          "logged": false,
        }
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.user.name,
            style: TextStyle(fontSize: 24),
          ),
          PillButton(
            text: "Work in progress...",
            occupyAllScreen: false,
            primary: false,
            icon: Icons.cancel,
            onPressed: () {} //TODO: follow/unfollow button
          ),
        ],
      ),
    );
  }
}
