class TodoTask {
  int? id;
  String? todo;
  bool? completed;
  int? userId;

  TodoTask(
      {required this.id,
      required this.todo,
      required this.completed,
      required this.userId});

  factory TodoTask.fromJson(Map<dynamic, dynamic> json) {
    return TodoTask(
      id: json['id'] as int? ?? 0,
      todo: json['todo'] as String? ?? 'not found',
      completed: json['completed'] as bool? ?? false,
      userId: json['userId'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'todo': todo,
      'completed': completed,
      'userId': userId,
    };
  }

  @override
  String toString() {
    return 'TodoTask {userId: $userId, id: $id, todo: $todo, completed: $completed}';
  }
}
