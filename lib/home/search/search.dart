import 'package:flutter/material.dart';
import 'package:travel_together/home/events/event_widget.dart';
import 'package:travel_together/home/user/user_widget.dart';
import 'package:travel_together/models/event.dart';
import 'package:travel_together/models/user.dart';
import 'package:travel_together/services/event_service.dart';
import 'package:travel_together/services/user_service.dart';
import 'package:travel_together/widgets/pill_input.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

enum SearchType {
  userName("Utente (per nome)"),
  eventName("Viaggio (per nome)");

  const SearchType(this.label);
  final String label;
}

class _SearchPageState extends State<SearchPage> {
  final _eventController = EventController(AmplifyEventService());
  final _userController = UserController(AmplifyUserService());

  final _searchController = TextEditingController();
  bool _loading = false;
  SearchType _searchType = SearchType.userName;
  SearchType _viewType = SearchType.userName;

  List<User> _users = [];
  List<Event> _events = [];

  Future<void> _search(String val) async {
    if(val.isEmpty) return;

    setState(() {
      _users = [];
      _events = [];
      _viewType = _searchType;
      _loading = true;
    });

    if(_searchType == SearchType.eventName) {
      final events = await _eventController.searchByName(val);
      setState(() {
        _events = events;
        _loading = false;
      });
    } else {
      final users = await _userController.searchByName(val);
      setState(() {
        _users = users;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return !_loading ? ListView(
      children: [
        PillInput(
          hint: "Search",
          controller: _searchController,
          suffixIcon: Icons.search,
          onSubmit: _search,
        ),
        const SizedBox(height: 24),
        DropdownMenu<SearchType>(
          initialSelection: _searchType,
          label: const Text("Cerca per"),
          width: double.infinity,
          onSelected: (SearchType? type) {
            setState(() {
              if(type != null) {
                _searchType = type;
              }
            });
          },
          dropdownMenuEntries: SearchType.values.map<DropdownMenuEntry<SearchType>>((SearchType type) {
            return DropdownMenuEntry<SearchType>(
              value: type,
              label: type.label,
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        for(int i = 0; i < (_viewType == SearchType.eventName ? _events.length : _users.length); i++) ...[
          _viewType == SearchType.eventName ? EventWidget(
            refresh: () {},
            event: _events[i],
            loggedIn: false,
          ) : UserWidget(
            user: _users[i],
          ),
          if(i < (_viewType == SearchType.eventName ? _events.length : _users.length) - 1) const SizedBox(height: 16),
        ],
      ],
    ) : Center(child: CircularProgressIndicator());
  }
}
