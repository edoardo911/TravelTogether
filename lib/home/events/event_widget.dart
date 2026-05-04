import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travel_together/models/event.dart';
import 'package:travel_together/models/user.dart';
import 'package:travel_together/services/event_service.dart';
import 'package:travel_together/services/user_service.dart';
import 'package:travel_together/widgets/pill_button.dart';

class EventWidget extends StatefulWidget {
  final Event event;
  final bool loggedIn;
  final VoidCallback refresh;

  const EventWidget({
    super.key,
    required this.refresh,
    required this.event,
    this.loggedIn = true,
  });

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  User? _user;
  final _userController = UserController(AmplifyUserService());
  final _eventController = EventController(AmplifyEventService());

  @override
  void initState() {
    super.initState();
    if(!widget.loggedIn) {
      _loadUser();
    }
  }

  Future<void> _loadUser() async {
    final user = await _userController.getUserById(widget.event.authorUUID);
    if(user.uuid != "") {
      setState(() {
        _user = user;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Ink(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: () {}, //TODO: navigate to event page
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.event.name,
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  if(widget.loggedIn) ...[
                    PillButton(
                      text: "",
                      icon: Icons.delete_outline,
                      occupyAllScreen: false,
                      primary: false,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Conferma Eliminazione"),
                              content: const Text("Sei sicuro di voler eliminare questo viaggio?"),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("No"),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Fluttertoast.showToast(
                                      msg: "Cancellato il viaggio ${widget.event.name}",
                                      gravity: ToastGravity.BOTTOM,
                                    );
                                    if(await _eventController.removeEventByID(widget.event.id)) {
                                      widget.refresh();
                                    }
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Si"),
                                ),
                              ]
                            );
                          }
                        );
                      },
                    ),
                  ],
                ],
              ),
              if(_user != null) ...[
                Text("Creato da: ${_user!.name}"),
              ],
              Divider(),
              const SizedBox(height: 6),
              Text(
                "${widget.event.date.day}/${widget.event.date.month}/${widget.event.date.year} ${widget.event.date.hour}:${widget.event.date.minute}, ${widget.event.location}",
                style: TextStyle(
                  fontWeight: FontWeight(800),
                ),
              ),
              const SizedBox(height: 12),
              Text(widget.event.description),
              const SizedBox(height: 12),
              Text(
                "Posti: ${widget.event.participants.length}/${widget.event.maxParticipants}",
                style: TextStyle(
                  fontWeight: FontWeight(800),
                ),
              ),
              Text(
                "Tratta: ${widget.event.transportation.join(", ")}",
                style: TextStyle(
                  fontWeight: FontWeight(800),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}