import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Classes/Todo.dart';
import '../Classes/Todo.dart';

enum TaskFilter { all, active, completed }

class TodoProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TaskFilter _filter = TaskFilter.all;
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;
  // bool get isLoading => _isLoading;
  TaskFilter get filter => TaskFilter.all;

  Future<void> fetchTodos() async {
    final user = _auth.currentUser;
    if (user != null) {
      final snapshot = await _firestore
          .collection('todos')
          .where('userId', isEqualTo: user.uid)
          .get();
      _todos = snapshot.docs.map((doc) => Todo.fromFirestore(doc)).toList();
      notifyListeners();
    }
  }

  Future<void> addTodo(Todo todo) async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('todos').add({
        'userId': user.uid,
        'title': todo.title,
        'isCompleted': todo.isCompleted,
      });
      fetchTodos();
    }
  }

  Future<void> updateTodo(Todo todo) async {
    await _firestore.collection('todos').doc(todo.id).update({
      'title': todo.title,
      'isCompleted': todo.isCompleted,
    });
    fetchTodos();
  }

  Future<void> deleteTodo(String id) async {
    await _firestore.collection('todos').doc(id).delete();
    fetchTodos();
  }

  void toggleTaskCompletion(Todo todoTask) {
    todoTask.isCompleted = !todoTask.isCompleted;
    updateTodo(todoTask);
    notifyListeners();
  }

  void setFilter(TaskFilter filter) {
    _filter = filter;
    notifyListeners();
  }
}