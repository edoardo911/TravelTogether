import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_together/models/event.dart';
import 'package:travel_together/widgets/pill_button.dart';

class EventEditPage extends StatefulWidget {
  final Event? event;

  const EventEditPage({super.key, this.event});

  @override
  State<EventEditPage> createState() => _EventEditPageState();
}

class _EventEditPageState extends State<EventEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _locationController = TextEditingController();
  final _durationController = TextEditingController();
  final _dateController = TextEditingController();
  final _participantsController = TextEditingController();
  final _transportController = TextEditingController();
  List<String> _transport = [];
  bool _meToo = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      _nameController.text = widget.event?.name ?? "";
      _descController.text = widget.event?.description ?? "";
      _locationController.text = widget.event?.location ?? "";
      _durationController.text = widget.event?.duration ?? "";
      _participantsController.text = "${widget.event?.maxParticipants ?? 1}";
      _transport = widget.event?.transportation ?? [];
      if(widget.event != null) {
        _dateController.text = DateFormat("dd/MM/yyyy HH:mm").format(widget.event!.date);
      } else {
        _dateController.text = DateFormat("dd/MM/yyyy HH:mm").format(DateTime.now());
      }
    });
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if(pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(widget.event == null ? DateTime.now() : widget.event!.date),
      );

      if(pickedTime != null) {
        setState(() {
          final selectedDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          _dateController.text = DateFormat('dd/MM/yyyy HH:mm').format(selectedDate);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event == null ? "Crea Viaggio" : "Modifica Viaggio"),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _nameController,
                  validator: (value) {
                    if(value == "") {
                      return "Inserisci un nome";
                    }
                    return "";
                  },
                  decoration: InputDecoration(
                    labelText: "Nome",
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _descController,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 3,
                  validator: (value) {
                    if(value == "") {
                      return "Inserisci una descrizione";
                    }
                    return "";
                  },
                  decoration: InputDecoration(
                    labelText: "Descizione",
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _locationController,
                  validator: (value) {
                    if(value == "") {
                      return "Inserisci un luogo";
                    }
                    return "";
                  },
                  decoration: InputDecoration(
                    labelText: "Luogo",
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _durationController,
                  validator: (value) {
                    if(value == "") {
                      return "Inserisci una durata";
                    }
                    return "";
                  },
                  decoration: InputDecoration(
                    labelText: "Durata",
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _dateController,
                  readOnly: true,
                  onTap: () => _selectDateTime(context),
                  decoration: InputDecoration(
                    labelText: "Data e ora",
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                ),
                if(widget.event == null) ...[
                  const SizedBox(height: 12),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _participantsController,
                    validator: (value) {
                      if(value == "") {
                        return "Inserisci un numero massimo di partecipanti";
                      }
                      return "";
                    },
                    decoration: InputDecoration(
                      labelText: "Partecipanti",
                    ),
                  ),
                  const SizedBox(height: 12),
                  CheckboxListTile(
                      title: const Text("Partecipa anche l'autore?"),
                      value: _meToo,
                      onChanged: (bool? newValue) {
                        setState(() {
                          _meToo = newValue ?? false;
                        });
                      }
                  ),
                ],
                const SizedBox(height: 12),
                TextFormField(
                  controller: _transportController,
                  decoration: InputDecoration(
                    labelText: "Aggiungi trasporto",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        if(_transportController.text.isNotEmpty) {
                          setState(() {
                            _transport.add(_transportController.text);
                            _transportController.clear();
                          });
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8.0,
                  children: _transport.map((t) => Chip(
                    label: Text(t),
                    onDeleted: () {
                      setState(() {
                        _transport.remove(t);
                      });
                    },
                  )).toList(),
                ),
                const SizedBox(height: 12),
                PillButton(
                  text: "Salva",
                  primary: false,
                  icon: Icons.save,
                  onPressed: () {} //TODO: edit/create
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
