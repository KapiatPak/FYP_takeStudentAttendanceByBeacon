import 'package:flutter/material.dart';
import '../views/student_attendance_view.dart';

class AuthService {
  static Future<void> login(String email, String password, BuildContext context) async {
    // Replace the following mock logic with your authentication logic.
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay.

    if (email == 'u@e.com' && password == '1111111') {
      // Successful login, navigate to the home page
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => StudentPage()));
    } else {
      // Failed login, show error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid credentials')));
    }
  }
}