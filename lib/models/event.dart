class Event {
  String id;
  String name;
  String description;
  String location;
  int maxParticipants;
  String duration;
  DateTime date;
  List<String> participants = [];
  List<String> transportation = [];

  Event({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.maxParticipants,
    required this.duration,
    required this.date,
    List<String>? participants,
    List<String>? transportation,
  }): participants = participants ?? [], transportation = transportation ?? [];

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json["_id"] ?? json["id"],
      name: json["name"],
      description: json["description"],
      location: json["location"],
      maxParticipants: json["maxParticipants"],
      duration: json["duration"],
      date: DateTime.parse(json["date"]),
      participants: (json["participants"] as List?)?.map((e) => e.toString()).toList() ?? [],
      transportation: (json["transportation"] as List?)?.map((e) => e.toString()).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "location": location,
      "maxParticipants": maxParticipants,
      "duration": duration,
      "date": date.toIso8601String(),
      "participants": participants,
      "transportation": transportation,
    };
  }
}