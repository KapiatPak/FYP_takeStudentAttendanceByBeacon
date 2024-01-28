class Teacher {
  final int module_id;
  final String module_name;
  final int teacher_id;

  Teacher(
      {required this.module_id,
      required this.module_name,
      required this.teacher_id});

  Map<String, dynamic> toMap() {
    return {
      'module_id': module_id,
      'module_name': module_name,
      'teacher_id': teacher_id,
    };
  }
}
