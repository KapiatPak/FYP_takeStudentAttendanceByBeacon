import 'package:sqflite/sqflite.dart';
import '../models/attendance.dart';

class AttendanceController {
  final Database db;

  AttendanceController(this.db);

  Future<void> addAttendance(Attendance attendance) async {
    await db.insert(
      'Attendances', // 确认表名与你的数据库架构匹配
      attendance.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Attendance>> getAttendances() async {
    final List<Map<String, dynamic>> maps = await db.query('Attendances'); // 确认表名与你的数据库架构匹配
    return List.generate(maps.length, (i) {
      return Attendance(
        attendance_id: maps[i]['attendance_id'],
        attendance_time: maps[i]['attendance_time'],
        module_id: maps[i]['module_id'],
        student_id: maps[i]['student_id'],
        room_id: maps[i]['room_id'],
      );
    });
  }

  Future<void> updateAttendance(Attendance attendance) async {
    await db.update(
      'Attendances', // 确认表名与你的数据库架构匹配
      attendance.toMap(),
      where: 'attendance_id = ?',
      whereArgs: [attendance.attendance_id],
    );
  }

  Future<void> deleteAttendance(int attendance_id) async {
    await db.delete(
      'Attendances', // 确认表名与你的数据库架构匹配
      where: 'attendance_id = ?',
      whereArgs: [attendance_id],
    );
  }
}