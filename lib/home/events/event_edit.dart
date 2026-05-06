import 'package:flutter/material.dart';
import 'package:travel_together/models/event.dart';

class EventEditPage extends StatefulWidget {
  final Event? event;

  const EventEditPage({super.key, this.event});

  @override
  State<EventEditPage> createState() => _EventEditPageState();
}

class _EventEditPageState extends State<EventEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event == null ? "Crea Viaggio" : "Modifica Viaggio"),
        automaticallyImplyLeading: true,
      ),
      body: Placeholder(
      ),
    );
  }
}
