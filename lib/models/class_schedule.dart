class ClassSchedule {
  final String class_date;
  final String class_time;
  final int module_id;
  final int student_id;
  final int room_id;

  ClassSchedule({
    required this.class_date,
    required this.class_time,
    required this.module_id,
    required this.student_id,
    required this.room_id,
  });

  // 将对象转换成Map，通常用于插入数据库操作
  Map<String, dynamic> toMap() {
    return {
      'class_date': class_date,
      'class_time': class_time,
      'module_id': module_id,
      'student_id': student_id,
      'room_id': room_id,
    };
  }

  // // 将Map转换成对象，通常用于从数据库查询数据后，将查询结果转换成对象
  // factory ClassSchedule.fromMap(Map<String, dynamic> map) {
  //   return ClassSchedule(
  //     class_date: map['class_date'],
  //     class_time: map['class_time'],
  //     module_id: map['module_id'],
  //     student_id: map['student_id'],
  //     room_id: map['room_id'],
  //   );
  // }
}
