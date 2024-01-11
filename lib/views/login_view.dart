//lib/views/login_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/login_controller.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginController = Provider.of<LoginController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('登入'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: '用戶名',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                // 更新用戶名
                loginController.username = value;
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: '密碼',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              onChanged: (value) {
                // 更新密碼
                loginController.password = value;
              },
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              child: Text('登入'),
              onPressed: () {
                // 執行登入操作
                loginController.login();
              },
            ),
          ],
        ),
      ),
    );
  }
}