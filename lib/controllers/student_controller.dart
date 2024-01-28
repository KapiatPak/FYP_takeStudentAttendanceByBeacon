import 'package:sqflite/sqflite.dart';
import '../models/student.dart';

class StudentController {
  final Database db;

  StudentController(this.db);

  Future<void> addStudent(Student student) async {
    await db.insert(
      'Student',
      student.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Student>> getStudents() async {
    final List<Map<String, dynamic>> maps = await db.query('Student');
    return List.generate(maps.length, (i) {
      return Student(
        student_id: maps[i]['student_id'],
        student_name: maps[i]['student_name'],
      );
    });
  }

  Future<void> updateStudent(Student student) async {
    await db.update(
      'Student',
      student.toMap(),
      where: 'student_id = ?',
      whereArgs: [student.student_id],
    );
  }

  Future<void> deleteStudent(int id) async {
    await db.delete(
      'Student',
      where: 'student_id = ?',
      whereArgs: [id],
    );
  }
}