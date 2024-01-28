//lib/models/teacher.dart
class Teacher {
  final int teacher_id;
  final String teacher_name;

  Teacher({required this.teacher_id, required this.teacher_name});

  Map<String, dynamic> toMap() {
    return {
      'teacher_id': teacher_id,
      'teacher_name': teacher_name,
    };
  }

  factory Teacher.fromMap(Map<String, dynamic> map) {
    return Teacher(
      teacher_id: map['teacher_id'],
      teacher_name: map['teacher_name'],
    );
  }
}
