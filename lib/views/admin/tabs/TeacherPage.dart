import 'package:flutter/material.dart';
import '../../../models/teacher.dart';
import '../../../controllers/teacher_controller.dart';
import '../../../services/db_service.dart';

class TeacherPage extends StatefulWidget {
  @override
  _TeacherPageState createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  List<Teacher> _teachers = []; // 初始化为空列表
  TeacherController? _teacherController; // 声明为可空类型
  final _teacherNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initTeacherController();
  }

  void _initTeacherController() async {
    final db = await DatabaseService.instance.database;
    setState(() {
      _teacherController = TeacherController(db);
      _loadTeachers();
    });
  }

  Future<void> _loadTeachers() async {
    if (_teacherController != null) {
      _teachers = await _teacherController!.getTeachers();
      if (mounted) setState(() {}); // 通知框架在数据加载完成后重建UI
    }
  }

  Future<void> _addOrUpdateTeacher({Teacher? teacher}) async {
    if (teacher != null) {
      _teacherNameController.text = teacher.teacher_name;
    } else {
      _teacherNameController.clear();
    }

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
                if (_teacherController != null) {
                  if (teacher == null) {
                    await _teacherController!.addTeacher(Teacher(teacher_id: 0, teacher_name: name));
                  } else {
                    await _teacherController!.updateTeacher(Teacher(teacher_id: teacher.teacher_id, teacher_name: name));
                  }
                  _loadTeachers(); // Reload the list of teachers
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteTeacher(int id) async {
    if (_teacherController != null) {
      await _teacherController!.deleteTeacher(id);
      _loadTeachers();
    }
  }

  @override
  void dispose() {
    _teacherNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Management'),
        automaticallyImplyLeading: false,
      ),
      body: _teachers.isEmpty
          ? Center(child: Text('No teachers found'))
          : ListView.builder(
              itemCount: _teachers.length,
              itemBuilder: (context, index) {
                var teacher = _teachers[index];
                return ListTile(
                  title: Text(teacher.teacher_name),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteTeacher(teacher.teacher_id),
                  ),
                  onTap: () => _addOrUpdateTeacher(teacher: teacher),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _addOrUpdateTeacher(),
      ),
    );
  }
}