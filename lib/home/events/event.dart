import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travel_together/models/event.dart';
import 'package:travel_together/models/user.dart';
import 'package:travel_together/services/event_service.dart';
import 'package:travel_together/services/user_service.dart';
import 'package:travel_together/widgets/pill_button.dart';

class EventPage extends StatefulWidget {
  final Event event;

  const EventPage({super.key, required this.event});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final _userController = UserController(AmplifyUserService());
  final _eventController = EventController(AmplifyEventService());
  bool _isMine = true;
  bool _free = false;
  bool _participating = false;
  bool _loadingParticipants = false;
  bool _loadingEnrollment = false;
  List<User> _participants = [];
  User? _author;
  User? _me;

  Future<void> _loadAuthor() async {
    final user = await _userController.getUserById(widget.event.authorUUID);
    final myUUID = await _userController.getCurrentUserUUID();
    final me = await _userController.getUserById(myUUID);
    if(user.uuid != "") {
      setState(() {
        _author = user;
        _me = me;
        _isMine = user.uuid == myUUID;
        _participating = widget.event.participants.contains(user.id);
        _free = widget.event.participants.length < widget.event.maxParticipants;
      });
    }
  }

  Future<void> _loadParticipants() async {
    setState(() {
      _loadingParticipants = true;
    });
    final users = await _userController.getUsersByIDs(widget.event.participants);
    setState(() {
      _loadingParticipants = false;
      _participants = users;
    });
  }

  Future<void> _enrollDismiss() async {
    setState(() {
      _loadingEnrollment = true;
    });
    if(_participating) {
      if(await _eventController.dismiss(widget.event.id, _me!.id)) {
        setState(() {
          _participating = false;
          _participants.remove(_me!);
          widget.event.participants.remove(_me!.id);
        });
      } else {
        Fluttertoast.showToast(
          msg: "Error dismissing event",
          gravity: ToastGravity.BOTTOM,
        );
      }
    } else {
      if(await _eventController.enroll(widget.event.id, _me!.id)) {
        setState(() {
          _participating = true;
          _participants.add(_me!);
          widget.event.participants.add(_me!.id);
        });
      } else {
        Fluttertoast.showToast(
          msg: "Error enrolling event",
          gravity: ToastGravity.BOTTOM,
        );
      }
    }
    setState(() {
      _loadingEnrollment = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadAuthor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Viaggio"),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 15,
        ),
        child: ListView(
          children: [
            Text(
              widget.event.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
              )
            ),
            const Divider(),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.location_on),
                const SizedBox(width: 6),
                Text(
                  widget.event.location,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.date_range),
                const SizedBox(width: 6),
                Text(
                  "${widget.event.date.day}/${widget.event.date.month}/${widget.event.date.year} ${widget.event.date.hour}:${widget.event.date.minute}",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.timelapse),
                const SizedBox(width: 6),
                Text(
                  widget.event.duration,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text("Creato da"),
                const SizedBox(width: 5),
                SelectableText(
                  _author?.name ?? '...',
                  onTap: () => Navigator.pushNamed(
                    context,
                    "/user",
                    arguments: {
                      "uuid": _author?.uuid,
                      "logged": false,
                    }
                  ),
                  style: TextStyle(
                    fontWeight: FontWeight(700),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              "Descrizione:",
              style: TextStyle(fontSize: 26),
            ),
            const SizedBox(height: 12),
            Text(widget.event.description),
            const SizedBox(height: 12),
            ExpansionTile(
              title: Text(
                "Posti liberi: ${widget.event.participants.length}/${widget.event.maxParticipants}",
                style: TextStyle(fontSize: 26),
              ),
              onExpansionChanged: (bool expanding) {
                if(expanding && _participants.isEmpty) {
                  _loadParticipants();
                }
              },
              children: [
                const SizedBox(height: 12),
                _loadingParticipants ? CircularProgressIndicator() :
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return SelectableText(
                      _participants[index].name,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24),
                      onTap: () => Navigator.pushNamed(
                        context,
                        "/user",
                        arguments: {
                          "uuid": _participants[index].uuid,
                          "logged": false,
                        }
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 12);
                  },
                  itemCount: _participants.length,
                ),
                if(_free && _me != null) ...[
                  const SizedBox(height: 12),
                  !_loadingEnrollment ? PillButton(
                    text: _participating ? "Non Partecipare" : "Partecipa",
                    icon: _participating ? Icons.cancel_outlined : Icons.confirmation_num_outlined,
                    onPressed: () => _enrollDismiss(),
                  ) : CircularProgressIndicator(),
                ],
                const SizedBox(height: 12),
              ],
            ),
            const SizedBox(height: 12),
            ExpansionTile(
              title: Text(
                "Come ci arriveremo:",
                style: TextStyle(fontSize: 26),
              ),
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Center(
                      child: Text(
                        widget.event.transportation[index],
                        style: TextStyle(fontSize: 26),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Icon(Icons.arrow_downward);
                  },
                  itemCount: widget.event.transportation.length,
                ),
                const SizedBox(height: 12),
              ],
            ),
            const SizedBox(height: 12),
            if(_isMine) ...[
              PillButton(
                text: "Modifica",
                icon: Icons.edit,
                primary: false,
                onPressed: () => Navigator.pushNamed(
                  context,
                  "/event_edit",
                  arguments: {
                    "event": widget.event,
                  },
                ),
              ),
              PillButton(
                text: "Cancella",
                icon: Icons.remove,
                primary: false,
                onPressed: () async {
                  await _eventController.removeEventByID(widget.event.id); //TODO: dialog
                  Navigator.pop(context, true);
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
