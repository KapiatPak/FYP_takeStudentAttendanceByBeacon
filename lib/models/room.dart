class Room {
  final int room_id;
  final String room_name;
  final int beacon_id;

  Room(
      {required this.room_id,
      required this.room_name,
      required this.beacon_id});

  Map<String, dynamic> toMap() {
    return {
      'room_id': room_id,
      'room_name': room_name,
      'beacon_id': beacon_id,
    };
  }
}
