import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/record': (context) => RecordPage(recordList: ModalRoute.of(context)!.settings.arguments as List<String>),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String currentTime;
  bool buttonEnabled = true;
  List<String> recordList = [];

  @override
  void initState() {
    super.initState();
    updateTime();
  }

  void updateTime() {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('HH:mm').format(now);
    String displayTime =
        formattedTime.substring(0, 2) + ':00 - ' + formattedTime.substring(0, 2) + ':30';
    setState(() {
      currentTime = displayTime;
      buttonEnabled = !formattedTime.endsWith(':00') && !formattedTime.endsWith(':30');
    });
    Future.delayed(const Duration(minutes: 30), updateTime);
  }

  void recordTime() {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('HH:mm').format(now);
    setState(() {
      recordList.add(formattedTime);
      buttonEnabled = false;
    });
    Navigator.pushNamed(context, '/record', arguments: recordList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Record',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/record', arguments: recordList);
          }
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              currentTime,
              style: TextStyle(fontSize: 24.0),
            ),
          ),
          ElevatedButton(
            onPressed: buttonEnabled ? recordTime : null,
            child: Text('Record Time'),
          ),
        ],
      ),
    );
  }
}

class RecordPage extends StatelessWidget {
  final List<String> recordList;
  static const routeName = '/record';

  RecordPage({required this.recordList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Record'),
      ),
      body: ListView.builder(
        itemCount: recordList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(recordList[index]),
          );
        },
      ),
    );
  }
}