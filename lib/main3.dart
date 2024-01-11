//lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/login_controller.dart';
import 'views/login_view.dart';
// 其他需要导入的文件

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginController()),
        // 其他Provider
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Attendance App',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginView(),
        // 其他路由
      },
    );
  }
}