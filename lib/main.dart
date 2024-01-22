import 'package:flutter/material.dart';
import 'views/common/login_view.dart';
import 'services/db_service.dart';

void main() async {
  // 确保Flutter绑定已初始化
  WidgetsFlutterBinding.ensureInitialized();

  // 获取数据库服务实例
  final dbService = DatabaseService.instance;

  // 初始化数据库并验证假数据
  // await dbService.initialize();

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