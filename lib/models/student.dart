class Student {
  final int student_id;
  final String student_name;

  Student({required this.student_id, required this.student_name});

  Map<String, dynamic> toMap() {
    return {
      'student_id': student_id,
      'student_name': student_name,
    };
  }

    factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      student_id: map['student_id'],
      student_name: map['student_name'],
    );
  }
}