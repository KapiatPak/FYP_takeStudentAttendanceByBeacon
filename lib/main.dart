// lib/main.dart

import 'package:flutter/material.dart';
import 'views/ScheduleView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Attendance App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ScheduleView(),
    );
  }
}