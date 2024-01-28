import 'package:flutter/material.dart';
import '../../../services/db_service.dart';

class StudentPage extends StatefulWidget {
  @override
  _StudentPageState createState() => _StudentPageState();
}

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