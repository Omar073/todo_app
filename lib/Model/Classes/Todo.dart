import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  String id;
  String title;
  bool isCompleted;
  int userId;

  Todo({
    required this.id,
    required this.title,
    required this.isCompleted,
    required this.userId,
  });

  factory Todo.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Todo(
      id: doc.id,
      title: data['title'],
      isCompleted: data['isCompleted'],
      userId: data['userId'],
    );
  }
}