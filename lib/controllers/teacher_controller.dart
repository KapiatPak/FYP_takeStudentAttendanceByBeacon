//lib/controllers/teacher_controller.dart
import 'package:sqflite/sqflite.dart';
import '../models/teacher.dart';

class TeacherController {
  final Database db;

  TeacherController(this.db);

  Future<void> addTeacher(Teacher teacher) async {
    await db.insert(
      'Teacher',
      teacher.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Teacher>> getTeachers() async {
    final List<Map<String, dynamic>> maps = await db.query('Teacher');
    return List.generate(maps.length, (i) {
      return Teacher(
        teacher_id: maps[i]['teacher_id'],
        teacher_name: maps[i]['teacher_name'],
      );
    });
  }

  Future<void> updateTeacher(Teacher teacher) async {
    await db.update(
      'Teacher',
      teacher.toMap(),
      where: 'teacher_id = ?',
      whereArgs: [teacher.teacher_id],
    );
  }

  Future<void> deleteTeacher(int id) async {
    await db.delete(
      'Teacher',
      where: 'teacher_id = ?',
      whereArgs: [id],
    );
  }
}