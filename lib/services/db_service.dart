import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('attendance.db');
    print('database created successfully'); //debug
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    // SQL type constants
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    // const textType = 'TEXT NOT NULL';
    // const integerType = 'INTEGER NOT NULL';
    // const timeType = 'TEXT NOT NULL';
    const textType = 'TEXT';
    const integerType = 'INTEGER';
    const timeType = 'TEXT';
    // Create tables
    await db.execute('''
      CREATE TABLE Teacher (
        teacher_id $idType,
        teacher_name $textType
      )
    ''');
    print('Teacher table created successfully'); //debug

    await db.execute('''
      CREATE TABLE Module (
        module_id $idType,
        module_name $textType,
        teacher_id $integerType,
        FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
      )
    ''');

    await db.execute('''
      CREATE TABLE Class_schedule (
        class_date $textType,
        class_time $timeType,
        module_id $integerType,
        student_id $integerType,
        room_id $integerType,
        PRIMARY KEY (class_date, class_time, module_id, student_id, room_id),
        FOREIGN KEY (module_id) REFERENCES Module(module_id),
        FOREIGN KEY (student_id) REFERENCES Student(student_id),
        FOREIGN KEY (room_id) REFERENCES Room(room_id)
      )
    ''');

    await db.execute('''
      CREATE TABLE Student (
        student_id $idType,
        student_name $textType
      )
    ''');

    await db.execute('''
      CREATE TABLE Attendance (
        attendance_id $idType,
        attendance_time $timeType,
        module_id $integerType,
        student_id $integerType,
        room_id $integerType,
        FOREIGN KEY (module_id) REFERENCES Module(module_id),
        FOREIGN KEY (student_id) REFERENCES Student(student_id),
        FOREIGN KEY (room_id) REFERENCES Room(room_id)
      )
    ''');

    await db.execute('''
      CREATE TABLE Room (
        room_id $idType,
        room_name $textType,
        beacon_id $textType
      )
    ''');
  }

  // #region DummyData Testing
  Future<void> initialize() async {
    // 初始化数据库
    await database;

    // Insert dummy data
    final db = await instance.database;
    await db.rawInsert(
        'INSERT INTO Teacher (teacher_id, teacher_name) VALUES (?, ?)',
        [1, 'Mr. Tan']);
    await db.rawInsert(
        'INSERT INTO Teacher (teacher_id, teacher_name) VALUES (?, ?)',
        [2, 'Mr. Lim']);

    await db.rawInsert(
        'INSERT INTO Module (module_id, module_name, teacher_id) VALUES (?, ?, ?)',
        [1, 'Mobile App Development', 1]);
    await db.rawInsert(
        'INSERT INTO Module (module_id, module_name, teacher_id) VALUES (?, ?, ?)',
        [2, 'Web App Development', 1]);

    await db.rawInsert(
        'INSERT INTO Class_schedule (class_date, class_time, module_id, student_id, room_id) VALUES (?, ?, ?, ?, ?)',
        ['2021-10-01', '09:00:00', 1, 1, 1]);

    await db.rawInsert(
        'INSERT INTO Student (student_id, student_name) VALUES (?, ?)',
        [1, 'John']);

    // await db.rawInsert(
    //     'INSERT INTO Attendance (attendance_id, attendance_time, module_id, student_id, room_id) VALUES (?, ?, ?, ?, ?)',
    //     [1, '09:00:00', 1, 1, 1]);

    await db.rawInsert(
        'INSERT INTO Room (room_id, room_name, beacon_id) VALUES (?, ?, ?)',
        [1, 'Room 1', 'N51']);

    // 验证假数据
    await _verifyDummyData();
  }

  Future<void> _verifyDummyData() async {
    // 查询各个表以验证数据
    final db = await instance.database;
    print('Teachers: ${await db.query('Teacher')}');
    print('Modules: ${await db.query('Module')}');
    print('Class_schedule: ${await db.query('Class_schedule')}');
    print('Students: ${await db.query('Student')}');
    print('Attendance: ${await db.query('Attendance')}');
    print('Rooms: ${await db.query('Room')}');
  }
  // #endregion

  // #region CRUD operations for Teacher table
  Future<int> createTeacher(Map<String, dynamic> teacher) async {
    final db = await instance.database;
    return await db.insert('Teacher', teacher);
  }

  Future<List<Map<String, dynamic>>> getTeachers() async {
    final db = await instance.database;
    return await db.query('Teacher');
  }

  Future<int> updateTeacher(Map<String, dynamic> teacher) async {
    final db = await instance.database;
    return db.update(
      'Teacher',
      teacher,
      where: 'teacher_id = ?',
      whereArgs: [teacher['teacher_id']],
    );
  }

  Future<int> deleteTeacher(int id) async {
    final db = await instance.database;
    return await db.delete(
      'Teacher',
      where: 'teacher_id = ?',
      whereArgs: [id],
    );
  }
  // #endregion

  // #region CRUD operations for Module table
  Future<int> createModule(Map<String, dynamic> module) async {
    final db = await instance.database;
    return await db.insert('Module', module);
  }

  Future<List<Map<String, dynamic>>> getModules() async {
    final db = await instance.database;
    return await db.query('Module');
  }

  Future<int> updateModule(Map<String, dynamic> module) async {
    final db = await instance.database;
    return db.update(
      'Module',
      module,
      where: 'module_id = ?',
      whereArgs: [module['module_id']],
    );
  }

  Future<int> deleteModule(int id) async {
    final db = await instance.database;
    return await db.delete(
      'Module',
      where: 'module_id = ?',
      whereArgs: [id],
    );
  }
  // #endregion

  // #region CRUD operations for Class_schedule table

  Future<int> createClassSchedule(Map<String, dynamic> classSchedule) async {
    final db = await instance.database;
    return await db.insert('Class_schedule', classSchedule);
  }

  Future<List<Map<String, dynamic>>> getClassSchedules() async {
    final db = await instance.database;
    return await db.query('Class_schedule');
  }

  Future<int> updateClassSchedule(Map<String, dynamic> classSchedule) async {
    final db = await instance.database;
    return db.update(
      'Class_schedule',
      classSchedule,
      where:
          'class_date = ? AND class_time = ? AND module_id = ? AND student_id = ? AND room_id = ?',
      whereArgs: [
        classSchedule['class_date'],
        classSchedule['class_time'],
        classSchedule['module_id'],
        classSchedule['student_id'],
        classSchedule['room_id'],
      ],
    );
  }

  Future<int> deleteClassSchedule({
    required String classDate,
    required String classTime,
    required int moduleId,
    required int studentId,
    required int roomId,
  }) async {
    final db = await instance.database;
    return await db.delete(
      'Class_schedule',
      where:
          'class_date = ? AND class_time = ? AND module_id = ? AND student_id = ? AND room_id = ?',
      whereArgs: [classDate, classTime, moduleId, studentId, roomId],
    );
  }
  // #endregion

  // #region CRUD operations for Student table

  Future<int> createStudent(Map<String, dynamic> student) async {
    final db = await instance.database;
    return await db.insert('Student', student);
  }

  Future<List<Map<String, dynamic>>> getStudents() async {
    final db = await instance.database;
    return await db.query('Student');
  }

  Future<int> updateStudent(Map<String, dynamic> student) async {
    final db = await instance.database;
    return db.update(
      'Student',
      student,
      where: 'student_id = ?',
      whereArgs: [student['student_id']],
    );
  }

  Future<int> deleteStudent(int id) async {
    final db = await instance.database;
    return await db.delete(
      'Student',
      where: 'student_id = ?',
      whereArgs: [id],
    );
  }

// #endregion

// #region CRUD operations for Attendance table

  Future<int> createAttendance(Map<String, dynamic> attendance) async {
    final db = await instance.database;
    return await db.insert('Attendance', attendance);
  }

  Future<List<Map<String, dynamic>>> getAttendances() async {
    final db = await instance.database;
    return await db.query('Attendance');
  }

  Future<int> updateAttendance(Map<String, dynamic> attendance) async {
    final db = await instance.database;
    return db.update(
      'Attendance',
      attendance,
      where: 'attendance_id = ?',
      whereArgs: [attendance['attendance_id']],
    );
  }

  Future<int> deleteAttendance(int id) async {
    final db = await instance.database;
    return await db.delete(
      'Attendance',
      where: 'attendance_id = ?',
      whereArgs: [id],
    );
  }

// #endregion

// #region CRUD operations for Room table

  Future<int> createRoom(Map<String, dynamic> room) async {
    final db = await instance.database;
    return await db.insert('Room', room);
  }

  Future<List<Map<String, dynamic>>> getRooms() async {
    final db = await instance.database;
    return await db.query('Room');
  }

  Future<int> updateRoom(Map<String, dynamic> room) async {
    final db = await instance.database;
    return db.update(
      'Room',
      room,
      where: 'room_id = ?',
      whereArgs: [room['room_id']],
    );
  }

  Future<int> deleteRoom(int id) async {
    final db = await instance.database;
    return await db.delete(
      'Room',
      where: 'room_id = ?',
      whereArgs: [id],
    );
  }

// #endregion

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
