// lib/views/ScheduleView.dart
import 'package:flutter/material.dart';
import '../controllers/ScheduleController.dart';
import '../models/ClassSchedule.dart';

class ScheduleView extends StatelessWidget {
  final ScheduleController controller = ScheduleController();

  Future<ClassSchedule?> _showAddScheduleDialog(BuildContext context) async {
    final TextEditingController idController = TextEditingController();
    final TextEditingController subjectController = TextEditingController();
    final TextEditingController timeController = TextEditingController();
    final TextEditingController teacherController = TextEditingController();

    return showDialog<ClassSchedule>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Schedule'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: idController,
                decoration: InputDecoration(labelText: 'ID'),
              ),
              TextField(
                controller: subjectController,
                decoration: InputDecoration(labelText: 'Subject'),
              ),
              TextField(
                controller: timeController,
                decoration: InputDecoration(labelText: 'Time'),
              ),
              TextField(
                controller: teacherController,
                decoration: InputDecoration(labelText: 'Teacher'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                final newSchedule = ClassSchedule(
                  id: idController.text,
                  subject: subjectController.text,
                  time: timeController.text,
                  teacher: teacherController.text,
                );
                Navigator.of(context).pop(newSchedule);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Class Schedule'),
      ),
      body: FutureBuilder<List<ClassSchedule>>(
        future: controller.getSchedule(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('An error occurred!'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No schedules available.'));
          } else {
            List<ClassSchedule> schedule = snapshot.data!;
            return ListView.builder(
              itemCount: schedule.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(schedule[index].subject),
                  subtitle: Text(
                      '${schedule[index].time} with ${schedule[index].teacher}'),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newSchedule = await _showAddScheduleDialog(context);
          if (newSchedule != null) {
            await controller.addSchedule(newSchedule);
            // 更新UI
            (context as Element).markNeedsBuild();
          }
        },
        child: Icon(Icons.add),
        tooltip: 'Add Schedule',
      ),
    );
  }
}
