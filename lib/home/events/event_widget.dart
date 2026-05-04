import 'package:flutter/cupertino.dart';
import 'package:travel_together/models/event.dart';

class EventWidget extends StatelessWidget {
  final Event event;
  final bool showUser;

  const EventWidget({
    super.key,
    required this.event,
    this.showUser = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(event.name),
      ],
    );
  }
}
