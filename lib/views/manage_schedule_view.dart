import 'package:flutter/material.dart';
import '../services/db_service.dart';

class ManageDataView extends StatefulWidget {
  @override
  _ManageDataViewState createState() => _ManageDataViewState();
}

class _ManageDataViewState extends State<ManageDataView> {
  int _selectedIndex = 0; // 当前选中的索引

  final _pages = [
    TeacherPage(),
    ModulePage(),
    ClassSchedulePage(),
    StudentPage(),
    AttendancePage(),
    RoomPage(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Data'),
      ),
      body: Row(
        children: <Widget>[
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.person),
                selectedIcon: Icon(Icons.person_outline),
                label: Text('Teacher'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.book),
                selectedIcon: Icon(Icons.book_outlined),
                label: Text('Module'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.schedule),
                selectedIcon: Icon(Icons.schedule_outlined),
                label: Text('Class Schedule'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.school),
                selectedIcon: Icon(Icons.school_outlined),
                label: Text('Student'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.access_time),
                selectedIcon: Icon(Icons.access_time_outlined),
                label: Text('Attendance'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.room),
                selectedIcon: Icon(Icons.room_outlined),
                label: Text('Room'),
              ),
            ],
          ),
          VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: _pages[_selectedIndex], // 显示选中的页面
          ),
        ],
      ),
    );
  }
}

// #region TeacherPage
class TeacherPage extends StatefulWidget {
  @override
  _TeacherPageState createState() => _TeacherPageState();
}

// TeacherPage State
class _TeacherPageState extends State<TeacherPage> {
  late List<Map<String, dynamic>> _teachers;
  final _dbService = DatabaseService.instance;

  @override
  void initState() {
    super.initState();
    _loadTeachers();
  }

  void _loadTeachers() async {
    _teachers = await _dbService.getTeachers();
    setState(() {});
  }

  void _addOrUpdateTeacher({Map<String, dynamic>? teacher}) async {
    final _teacherNameController = TextEditingController(
      text: teacher != null ? teacher['teacher_name'] : '',
    );

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(teacher == null ? 'Add Teacher' : 'Update Teacher'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: _teacherNameController,
                  decoration: InputDecoration(labelText: 'Teacher Name'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(teacher == null ? 'Add' : 'Update'),
              onPressed: () async {
                final String name = _teacherNameController.text;
                if (teacher == null) {
                  // Add new teacher
                  await _dbService.createTeacher({'teacher_name': name});
                } else {
                  // Update existing teacher
                  await _dbService.updateTeacher({
                    'teacher_id': teacher['teacher_id'],
                    'teacher_name': name,
                  });
                }
                _loadTeachers(); // Reload the list of teachers
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteTeacher(int id) async {
    await _dbService.deleteTeacher(id);
    _loadTeachers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Management'),
        automaticallyImplyLeading: false, // 移除自动添加的返回箭头
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _dbService.getTeachers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No teachers found'));
          } else {
            _teachers = snapshot.data!;
            return ListView.builder(
              itemCount: _teachers.length,
              itemBuilder: (context, index) {
                var teacher = _teachers[index];
                return ListTile(
                  title: Text(teacher['teacher_name']),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteTeacher(teacher['teacher_id']),
                  ),
                  onTap: () => _addOrUpdateTeacher(teacher: teacher),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _addOrUpdateTeacher(),
      ),
    );
  }
}
// #endregion

// #region ModulePage
class ModulePage extends StatefulWidget {
  @override
  _ModulePageState createState() => _ModulePageState();
}

class _ModulePageState extends State<ModulePage> {
  late List<Map<String, dynamic>> _modules;
  final _dbService = DatabaseService.instance;

  @override
  void initState() {
    super.initState();
    _loadModules();
  }

  void _loadModules() async {
    _modules = await _dbService.getModules();
    setState(() {});
  }

  void _addOrUpdateModule({Map<String, dynamic>? module}) async {
    final _moduleNameController = TextEditingController(
      text: module != null ? module['module_name'] : '',
    );

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(module == null ? 'Add Module' : 'Update Module'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: _moduleNameController,
                  decoration: InputDecoration(labelText: 'Module Name'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(module == null ? 'Add' : 'Update'),
              onPressed: () async {
                final String name = _moduleNameController.text;
                if (module == null) {
                  // Add new module
                  await _dbService.createModule({'module_name': name});
                } else {
                  // Update existing module
                  await _dbService.updateModule({
                    'module_id': module['module_id'],
                    'module_name': name,
                  });
                }
                _loadModules(); // Reload the list of modules
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteModule(int id) async {
    await _dbService.deleteModule(id);
    _loadModules();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Module Management'),
        automaticallyImplyLeading: false, // 移除自动添加的返回箭头
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _dbService.getModules(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No modules found'));
          } else {
            _modules = snapshot.data!;
            return ListView.builder(
              itemCount: _modules.length,
              itemBuilder: (context, index) {
                var module = _modules[index];
                return ListTile(
                  title: Text(module['module_name']),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteModule(module['module_id']),
                  ),
                  onTap: () => _addOrUpdateModule(module: module),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _addOrUpdateModule(),
      ),
    );
  }
}
// #endregion

// #region ClassSchedulePage
class ClassSchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Class Schedule Management'),
      ),
      body: Center(
        child: Text('Class Schedule Management'),
      ),
    );
  }
}
// #endregion

// #region StudentPage
class StudentPage extends StatefulWidget {
  @override
  _StudentPageState createState() => _StudentPageState();
}

// StudentPage State
class _StudentPageState extends State<StudentPage> {
  late List<Map<String, dynamic>> _students;
  final _dbService = DatabaseService.instance;

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  void _loadStudents() async {
    _students = await _dbService.getStudents();
    setState(() {});
  }

  void _addOrUpdateStudent({Map<String, dynamic>? student}) async {
    final _studentNameController = TextEditingController(
      text: student != null ? student['student_name'] : '',
    );

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(student == null ? 'Add Student' : 'Update Student'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: _studentNameController,
                  decoration: InputDecoration(labelText: 'Student Name'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(student == null ? 'Add' : 'Update'),
              onPressed: () async {
                final String name = _studentNameController.text;
                if (student == null) {
                  // Add new student
                  await _dbService.createStudent({'student_name': name});
                } else {
                  // Update existing student
                  await _dbService.updateStudent({
                    'student_id': student['student_id'],
                    'student_name': name,
                  });
                }
                _loadStudents(); // Reload the list of students
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteStudent(int id) async {
    await _dbService.deleteStudent(id);
    _loadStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Management'),
        automaticallyImplyLeading: false, // 移除自动添加的返回箭头
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _dbService.getStudents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No students found'));
          } else {
            _students = snapshot.data!;
            return ListView.builder(
              itemCount: _students.length,
              itemBuilder: (context, index) {
                var student = _students[index];
                return ListTile(
                  title: Text(student['student_name']),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteStudent(student['student_id']),
                  ),
                  onTap: () => _addOrUpdateStudent(student: student),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _addOrUpdateStudent(),
      ),
    );
  }
}
// #endregion

// #region AttendancePage
class AttendancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Management'),
      ),
      body: Center(
        child: Text('Attendance Management'),
      ),
    );
  }
}
// #endregion

// #region RoomPage
class RoomPage extends StatefulWidget {
  @override
  _RoomPageState createState() => _RoomPageState();
}

// RoomPage State
class _RoomPageState extends State<RoomPage> {
  late List<Map<String, dynamic>> _rooms;
  final _dbService = DatabaseService.instance;

  @override
  void initState() {
    super.initState();
    _loadRooms();
  }

  void _loadRooms() async {
    _rooms = await _dbService.getRooms();
    setState(() {});
  }

  void _addOrUpdateRoom({Map<String, dynamic>? room}) async {
    final _roomNameController = TextEditingController(
      text: room != null ? room['room_name'] : '',
    );

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(room == null ? 'Add Room' : 'Update Room'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: _roomNameController,
                  decoration: InputDecoration(labelText: 'Room Name'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(room == null ? 'Add' : 'Update'),
              onPressed: () async {
                final String name = _roomNameController.text;
                if (room == null) {
                  // Add new room
                  await _dbService.createRoom({'room_name': name});
                } else {
                  // Update existing room
                  await _dbService.updateRoom({
                    'room_id': room['room_id'],
                    'room_name': name,
                  });
                }
                _loadRooms(); // Reload the list of rooms
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteRoom(int id) async {
    await _dbService.deleteRoom(id);
    _loadRooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room Management'),
        automaticallyImplyLeading: false, // 移除自动添加的返回箭头
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _dbService.getRooms(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No rooms found'));
          } else {
            _rooms = snapshot.data!;
            return ListView.builder(
              itemCount: _rooms.length,
              itemBuilder: (context, index) {
                var room = _rooms[index];
                return ListTile(
                  title: Text(room['room_name']),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteRoom(room['room_id']),
                  ),
                  onTap: () => _addOrUpdateRoom(room: room),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _addOrUpdateRoom(),
      ),
    );
  }
}
// #endregion