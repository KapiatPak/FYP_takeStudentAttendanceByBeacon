import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../admin/adminPage.dart';
import '../student/student_attendance_view.dart';
import '../teacher/teacher_modity_view.dart';


class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void _trySubmitForm() {
    final isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      FocusScope.of(context).unfocus();
      _formKey.currentState?.save();
      AuthService.login(_email, _password, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MPU Attendance App'),
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@')) {
                        return 'Please enter a valid email.';
                      }
                      return null;
                    },
                    onSaved: (value) => _email = value ?? '',
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Password'),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 7) {
                        return 'Password must be at least 7 characters long.';
                      }
                      return null;
                    },
                    onSaved: (value) => _password = value ?? '',
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _trySubmitForm,
                    child: Text('Login'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => AdminPage()));
                    },
                    child: Text('test button go admin_page'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => StudentAttendanceView()));
                    },
                    child: Text('test button go student_page'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => TeacherModityPage()));
                    },
                    child: Text('test button go teacher_page'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
