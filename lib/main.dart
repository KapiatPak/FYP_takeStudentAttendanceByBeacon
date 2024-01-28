import 'package:flutter/material.dart';
import 'views/common/login_view.dart';
import 'services/db_service.dart';

void main() async {
  // 初始化数据库
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService.instance.database;

  // 运行应用
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