class Event {
  final String name;
  final String location;
  final String date;
  final String time;
  final String creatorId ;

  Event( {
    required this.creatorId ,
    required this.name,
    required this.location,
    required this.date,
    required this.time,

  });


  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      creatorId : json['creatorId'] ,
      name: json['name'] ,
      location: json['location'] ,
      date: json['date'] ,
      time: json['time'] ,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'location': location,
      'date': date,
      'time': time,
      'creatorId' : creatorId
    };
  }
}