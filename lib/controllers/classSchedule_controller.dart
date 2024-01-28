import 'package:sqflite/sqflite.dart';
import '../models/class_schedule.dart';

class ClassScheduleController {
  final Database db;

  ClassScheduleController(this.db);

  Future<void> addClassSchedule(ClassSchedule schedule) async {
    await db.insert(
      'ClassSchedules', // 确认表名与你的数据库架构匹配
      schedule.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ClassSchedule>> getClassSchedules() async {
    final List<Map<String, dynamic>> maps = await db.query('ClassSchedules'); // 确认表名与你的数据库架构匹配
    return List.generate(maps.length, (i) {
      return ClassSchedule(
        class_date: maps[i]['class_date'],
        class_time: maps[i]['class_time'],
        module_id: maps[i]['module_id'],
        student_id: maps[i]['student_id'],
        room_id: maps[i]['room_id'],
      );
    });
  }

  Future<void> updateClassSchedule(ClassSchedule schedule) async {
    await db.update(
      'ClassSchedules', // 确认表名与你的数据库架构匹配
      schedule.toMap(),
      where: 'module_id = ? AND student_id = ? AND room_id = ?',
      whereArgs: [schedule.module_id, schedule.student_id, schedule.room_id],
    );
  }

  Future<void> deleteClassSchedule(int module_id, int student_id, int room_id) async {
    await db.delete(
      'ClassSchedules', // 确认表名与你的数据库架构匹配
      where: 'module_id = ? AND student_id = ? AND room_id = ?',
      whereArgs: [module_id, student_id, room_id],
    );
  }
}