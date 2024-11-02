import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Classes/Todo.dart';

enum TaskFilter { all, active, completed }

class TodoProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Todo> _todos = [];
  bool _isLoading = false;
  TaskFilter _filter = TaskFilter.all;

  List<Todo> get todos => _todos;
  bool get isLoading => _isLoading;
  TaskFilter get filter => _filter;

  Future<void> fetchTodos() async {
    _isLoading = true;
    notifyListeners();

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final querySnapshot = await _firestore
            .collection('todos')
            .where('userId', isEqualTo: user.uid)
            .get();

        _todos = querySnapshot.docs
            .map((doc) => Todo.fromFirestore(doc))
            .toList();
      }
    } catch (e) {
      debugPrint('Error fetching todos: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void addTodo(Todo todo) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final docRef = await _firestore.collection('todos').add({
        'title': todo.title,
        'isCompleted': todo.isCompleted,
        'userId': user.uid,
      });
      todo.id = docRef.id;
      _todos.add(todo);
      notifyListeners();
    }
  }

  void updateTodo(Todo todo) async {
    await _firestore.collection('todos').doc(todo.id).update({
      'title': todo.title,
      'isCompleted': todo.isCompleted,
    });
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todos[index] = todo;
      notifyListeners();
    }
  }

  void toggleTaskCompletion(Todo todoTask) {
    todoTask.isCompleted = !todoTask.isCompleted;
    updateTodo(todoTask);
  }

  void setFilter(TaskFilter filter) {
    _filter = filter;
    notifyListeners();
  }
}