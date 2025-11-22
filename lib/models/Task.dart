class Task {
  final int? id;
  final String title;
  final String? description;
  final String status;
  final String date;

  Task({
    this.id,
    required this.title,
    this.description,
    required this.status,
    required this.date,
  });

  // Convert Task object to Map (for inserting into database)
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'title': title,
      'description': description,
      'status': status,
      'date': date,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  // Create Task object from Map (for reading from database)
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
        id: map['id'] as int?,
        title: map['title'] as String,
        description: map['description'] as String?,
        status: map['status'] as String,
        date: map['date'] as String,
        );
    }
}