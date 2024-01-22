import 'package:flutter/material.dart';

class StudentAttendanceView extends StatefulWidget {
  @override
  _StudentAttendanceViewState createState() => _StudentAttendanceViewState();
}

class _StudentAttendanceViewState extends State<StudentAttendanceView> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    TakeAttendancePage(),
    SchedulePage(),
    AttendanceRecordPage(),
    PersonalInfoPage(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student'),
      ),
      body: _children[_currentIndex], // Display the active tab content
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        backgroundColor: Colors.white, // Set the background color
        selectedItemColor: Colors.blue, // Set the color of the selected item
        unselectedItemColor: Colors.grey, // Set the color of the unselected items
        type: BottomNavigationBarType.fixed, // Fixed type ensures all items are visible
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.access_time),
            label: 'Take Attendance',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.table_chart),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Record',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Info',
          ),
        ],
      ),
    );
  }
}

// Placeholder widget for Take Attendance Page
class TakeAttendancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Take Attendance Page'));
  }
}

// Placeholder widget for Schedule Page
class SchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Schedule Page'));
  }
}

// Placeholder widget for Attendance Record Page
class AttendanceRecordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Attendance Record Page'));
  }
}

// Placeholder widget for Personal Info Page
class PersonalInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Personal Info Page'));
  }
}