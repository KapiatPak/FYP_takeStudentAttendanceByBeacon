//lib/controllers/login_controller.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// LoginController 类，用于管理登录状态
class LoginController with ChangeNotifier {
  String _username = '';
  String _password = '';

  String get username => _username;
  String get password => _password;

  set username(String username) {
    _username = username;
    notifyListeners();  // 通知监听器，数据已更新
  }

  set password(String password) {
    _password = password;
    notifyListeners();  // 通知监听器，数据已更新
  }

  Future<void> login() async {
    // 登录逻辑（这里只是一个示例，您需要实现实际的登录逻辑）
    try {
      // 模拟网络请求等待
      await Future.delayed(Duration(seconds: 2));
      // 假装登录总是成功的
      print('Logged in with username: $_username and password: $_password');
      // 这里您可以添加导航到主屏幕的逻辑
    } catch (e) {
      // 如果登录失败，处理错误
      print('Login failed: $e');
      // 这里您可以添加错误处理逻辑
    }
  }
}

// 将 LoginController 与 UI 结合使用
void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => LoginController(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginController = Provider.of<LoginController>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            onChanged: (value) => loginController.username = value,
            decoration: InputDecoration(labelText: 'Username'),
          ),
          TextField(
            onChanged: (value) => loginController.password = value,
            obscureText: true,
            decoration: InputDecoration(labelText: 'Password'),
          ),
          ElevatedButton(
            onPressed: () {
              loginController.login();
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}