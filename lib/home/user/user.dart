import 'package:flutter/material.dart';
import 'package:travel_together/home/user/profile_info.dart';
import 'package:travel_together/models/user.dart';
import 'package:travel_together/services/auth_service.dart';
import 'package:travel_together/services/user_service.dart';
import 'package:travel_together/widgets/pill_button.dart';

class UserPage extends StatefulWidget {
  final String uuid;
  final bool isLogged;

  const UserPage({super.key, required this.uuid, this.isLogged = false});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _authController = AuthController(AmplifyAuthService());
  final _userController = UserController(AmplifyUserService());
  User? _user;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      _isLoading = true;
    });

    _userController.getUserById(widget.uuid).then((userObject) => {
      if(userObject.uuid.isNotEmpty) {
        setState(() {
          _user = userObject;
          _isLoading = false;
        })
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoading ? Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _user?.name ?? "",
              style: TextStyle(
                fontSize: 40,
              ),
            ),
            if(widget.isLogged) ...[
              PillButton(
                text: "Log Out",
                primary: false,
                occupyAllScreen: false,
                icon: Icons.logout,
                onPressed: () {
                  _authController.logOut();
                  Navigator.pushReplacementNamed(context, "/");
                },
              ),
            ],
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ProfileInfo(
              amount: 0, //TODO: dynamic parameter
              label: "Following",
              action: () {}
            ),
            ProfileInfo(
                amount: 0, //TODO: dynamic parameter
                label: "Followers",
                action: () {}
            ),
            ProfileInfo(
                amount: 0, //TODO: dynamic parameter
                label: "Events",
                action: () {}
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Text(
              "Events",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            if(widget.isLogged) ...[
              SizedBox(width: 12),
              PillButton(
                text: "",
                primary: false,
                occupyAllScreen: false,
                icon: Icons.add,
                onPressed: () {},
              ),
            ],
          ],
        ),
      ],
    ) : Center(child: CircularProgressIndicator());
  }
}
