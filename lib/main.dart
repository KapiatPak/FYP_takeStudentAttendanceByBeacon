import 'package:flutter/material.dart';
import 'views/common/login_view.dart';

void main() {
  runApp(MyAttendanceApp());
}

class MyAttendanceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Attendance App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginView(),
    );
  }
}