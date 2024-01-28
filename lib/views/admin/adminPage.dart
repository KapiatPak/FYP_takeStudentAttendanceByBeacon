//lib/views/admin/adminPage.dart
import 'package:flutter/material.dart';
import 'tabs/TeacherPage.dart';
import 'tabs/ModulePage.dart';
import 'tabs/ClassSchedulePage.dart';
import 'tabs/StudentPage.dart';
import 'tabs/AttendancePage.dart';
import 'tabs/RoomPage.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _selectedIndex = 0; // 当前选中的索引

  final _pages = [
    TeacherPage(),
    ModulePage(),
    ClassSchedulePage(),
    StudentPage(),
    AttendancePage(),
    RoomPage(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Data'),
      ),
      body: Row(
        children: <Widget>[
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.person),
                selectedIcon: Icon(Icons.person_outline),
                label: Text('Teacher'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.book),
                selectedIcon: Icon(Icons.book_outlined),
                label: Text('Module'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.schedule),
                selectedIcon: Icon(Icons.schedule_outlined),
                label: Text('Class Schedule'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.school),
                selectedIcon: Icon(Icons.school_outlined),
                label: Text('Student'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.access_time),
                selectedIcon: Icon(Icons.access_time_outlined),
                label: Text('Attendance'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.room),
                selectedIcon: Icon(Icons.room_outlined),
                label: Text('Room'),
              ),
            ],
          ),
          VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: _pages[_selectedIndex], // 显示选中的页面
          ),
        ],
      ),
    );
  }
}


