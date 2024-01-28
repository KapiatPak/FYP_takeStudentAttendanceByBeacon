import 'package:sqflite/sqflite.dart';
import '../models/room.dart';

class RoomController {
  final Database db;

  RoomController(this.db);

  Future<void> addRoom(Room room) async {
    await db.insert(
      'Room',
      room.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Room>> getRooms() async {
    final List<Map<String, dynamic>> maps = await db.query('Room');
    return List.generate(maps.length, (i) {
      return Room(
        room_id: maps[i]['room_id'],
        room_name: maps[i]['room_name'],
        beacon_id: maps[i]['beacon_id'],
      );
    });
  }

  Future<void> updateRoom(Room room) async {
    await db.update(
      'Room',
      room.toMap(),
      where: 'room_id = ?',
      whereArgs: [room.room_id],
    );
  }

  Future<void> deleteRoom(int room_id) async {
    await db.delete(
      'Room',
      where: 'room_id = ?',
      whereArgs: [room_id],
    );
  }
}