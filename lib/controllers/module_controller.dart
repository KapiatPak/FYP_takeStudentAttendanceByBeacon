import 'package:sqflite/sqflite.dart';
import '../models/module.dart';

class ModuleController {
  final Database db;

  ModuleController(this.db);

  Future<void> addTeacher(Teacher teacher) async {
    await db.insert(
      'Modules', // 确认表名与你的数据库架构匹配
      teacher.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Teacher>> getTeachers() async {
    final List<Map<String, dynamic>> maps = await db.query('Modules'); // 确认表名与你的数据库架构匹配
    return List.generate(maps.length, (i) {
      return Teacher(
        module_id: maps[i]['module_id'],
        module_name: maps[i]['module_name'],
        teacher_id: maps[i]['teacher_id'],
      );
    });
  }

  Future<void> updateTeacher(Teacher teacher) async {
    await db.update(
      'Modules', // 确认表名与你的数据库架构匹配
      teacher.toMap(),
      where: 'module_id = ?',
      whereArgs: [teacher.module_id],
    );
  }

  Future<void> deleteTeacher(int module_id) async {
    await db.delete(
      'Modules', // 确认表名与你的数据库架构匹配
      where: 'module_id = ?',
      whereArgs: [module_id],
    );
  }
}