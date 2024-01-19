import 'package:flutter/material.dart';

class StudentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('student'),
      ),
      body: Center(
        child: Text('Welcome to the stdent Page!'),
      ),
    );
  }
}