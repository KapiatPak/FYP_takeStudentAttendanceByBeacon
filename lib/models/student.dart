class Student {
  final int id;
  final String name;
  final String email;

  Student({required this.id, required this.name, required this.email});

  // Convert a Student into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}