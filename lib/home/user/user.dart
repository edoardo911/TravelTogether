import 'package:flutter/material.dart';
import 'package:travel_together/home/events/event_widget.dart';
import 'package:travel_together/home/user/profile_info.dart';
import 'package:travel_together/models/event.dart';
import 'package:travel_together/models/user.dart';
import 'package:travel_together/services/auth_service.dart';
import 'package:travel_together/services/event_service.dart';
import 'package:travel_together/services/user_service.dart';
import 'package:travel_together/widgets/icon_button_pill.dart';
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
  final _eventController = EventController(AmplifyEventService());

  User? _user;
  bool _isLoading = false;
  List<Event> _events = [];

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    final user = await _userController.getUserById(widget.uuid);
    if(user.uuid != "") {
      final events = await _eventController.getEventsByAuthorUUID(user.uuid);

      setState(() {
        _isLoading = false;
        _user = user;
        _events.clear();
        _events = events;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoading ? ListView(
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
                label: "Seguiti",
                action: () {}
            ),
            ProfileInfo(
                amount: 0, //TODO: dynamic parameter
                label: "Seguaci",
                action: () {}
            ),
            ProfileInfo(
                amount: _events.length,
                label: "Viaggi",
                action: () {}
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Text(
              "Viaggi",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            if(widget.isLogged) ...[
              SizedBox(width: 12),
              IconButtonPill(
                primary: false,
                icon: Icons.add,
                onPressed: () async {
                  final result = await Navigator.pushNamed(
                    context,
                    "/event_edit",
                    arguments: {
                      "event": null,
                    },
                  );
                  if(result == true) {
                    _loadData();
                  }
                },
              ),
            ],
          ],
        ),
        const SizedBox(height: 24),
        ..._events.expand((e) => [
          EventWidget(
            refresh: () => _loadData(),
            event: e,
            loggedIn: widget.isLogged
          ),
          const SizedBox(height: 16),
        ]).toList()..removeLast(),
      ],
    ) : Center(child: CircularProgressIndicator());
  }
}
