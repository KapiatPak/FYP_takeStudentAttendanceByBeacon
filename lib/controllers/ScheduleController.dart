// lib/controllers/ScheduleController.dart
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/ClassSchedule.dart';

class ScheduleController {
  late Future<Database> database;

  ScheduleController() {
    database = initDatabase();
  }

  Future<Database> initDatabase() async {
    // ... 此处是你的初始化代码 ...
    // 返回数据库实例的Future
    return openDatabase(
      join(await getDatabasesPath(), 'class_schedule.db'),
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE schedules(id TEXT PRIMARY KEY, subject TEXT, time TEXT, teacher TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> addSchedule(ClassSchedule schedule) async {
    final db = await database;
    await db.insert(
      'schedules',
      schedule.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ClassSchedule>> getSchedule() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query('schedules');

      return List.generate(maps.length, (i) {
        return ClassSchedule(
          id: maps[i]['id'],
          subject: maps[i]['subject'],
          time: maps[i]['time'],
          teacher: maps[i]['teacher'],
        );
      });
    } catch (e) {
      // 打印錯誤日志
      print(e);
      // 可以選擇將錯誤重新拋出或者處理錯誤
      throw Exception('Failed to load schedule');
    }
  }
  // ... 其余的方法 ...
}
