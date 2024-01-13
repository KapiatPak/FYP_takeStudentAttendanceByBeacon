// lib/models/class_schedule.dart
class ClassSchedule {
  final String id;
  final String subject;
  final String time;
  final String teacher;

  ClassSchedule({
    required this.id,
    required this.subject,
    required this.time,
    required this.teacher,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'subject': subject,
      'time': time,
      'teacher': teacher,
    };
  }

  // ... 其余的代码 ...
}