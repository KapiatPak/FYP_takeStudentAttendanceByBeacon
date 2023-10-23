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
      home: HomePage(),
      routes: {
        '/record': (context) => RecordPage(),
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

  @override
  void initState() {
    super.initState();
    updateTime();
  }

  void updateTime() {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('HH:mm').format(now);
    String displayTime = formattedTime.substring(0, 2) + ':00 - ' + formattedTime.substring(0, 2) + ':30';
    setState(() {
      currentTime = displayTime;
      buttonEnabled = !formattedTime.endsWith(':00') && !formattedTime.endsWith(':30');
    });
    Future.delayed(const Duration(minutes: 30), updateTime);
  }

  void recordTime() {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('HH:mm').format(now);
    Navigator.pushNamed(
      context,
      '/record',
      arguments: formattedTime,
    );
    setState(() {
      buttonEnabled = false;
    });
    Future.delayed(const Duration(minutes: 30), () {
      setState(() {
        buttonEnabled = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: [
          if (currentTime != null)
            Container(
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
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(
        title: Text('Record'),
      ),
      body: Center(
        child: Text('Recorded Time: $args'),
      ),
    );
  }
}