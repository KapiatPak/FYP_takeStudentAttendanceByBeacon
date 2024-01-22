import 'package:flutter/material.dart';
import '../../services/db_service.dart';

class ScheduleView extends StatefulWidget {
  @override
  _ScheduleViewState createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  late List<Map<String, dynamic>> _schedules;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSchedules();
  }

  Future<void> _loadSchedules() async {
    try {
      _schedules = await DatabaseService.instance.getClassSchedules();
    } catch (e) {
      // If there's an error, handle it here. For example, show a SnackBar or a dialog.
      _schedules = [];
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Class Schedule'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _schedules.isEmpty
              ? Center(child: Text('No schedules found'))
              : ListView.builder(
                  itemCount: _schedules.length,
                  itemBuilder: (context, index) {
                    final schedule = _schedules[index];
                    return ListTile(
                      title: Text(schedule['name']),
                      subtitle: Text('Time: ${schedule['time']}'),
                    );
                  },
                ),
    );
  }
}