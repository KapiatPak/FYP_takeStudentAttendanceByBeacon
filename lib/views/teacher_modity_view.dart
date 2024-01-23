import 'package:flutter/material.dart';

class TeacherModityPage extends StatefulWidget {
  @override
  _TeacherModityPageState createState() => _TeacherModityPageState();
}

class _TeacherModityPageState extends State<TeacherModityPage> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    ModitySchedulePage(),
    QuestionPage(),
    SchedulePage(),
    RecordPage(),
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
        title: Text('Teacher'),
      ),
      body: _children[_currentIndex], // Display the active tab content
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        backgroundColor: Colors.white, // Set the background color
        selectedItemColor: Colors.blue, // Set the color of the selected item
        unselectedItemColor:
            Colors.grey, // Set the color of the unselected items
        type: BottomNavigationBarType
            .fixed, // Fixed type ensures all items are visible
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.access_time),
            label: 'Function1',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.table_chart),
            label: 'Function2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Function3',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Function4',
          ),
        ],
      ),
    );
  }
}

//Placeholder for the Modity Schedule Page
class ModitySchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Modity Schedule Page'));
  }
}

//Placeholder for the QuestionPage
class QuestionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('QuestionPage'));
  }
}

//Placeholder for the SchedulePage
class SchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('SchedulePage'));
  }
}

//Placeholder for the RecordPage
class RecordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('RecordPage'));
  }
}
