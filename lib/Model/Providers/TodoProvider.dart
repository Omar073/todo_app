import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../Classes/TodoTask.dart';
import '../apiMethods.dart';

enum TaskFilter { all, completed, pending }

class TodoProvider with ChangeNotifier {
  List<TodoTask> _todoList = [];
  bool _fetched = false;
  TaskFilter _filter = TaskFilter.all;
  int _totalTasks = 0;
  int _skip = 0;
  final int _limit = 30;
  bool _isLoading = false;

  List<TodoTask> get todoList {
    switch (_filter) {
      case TaskFilter.completed:
        return _todoList.where((task) => task.completed ?? false).toList();
      case TaskFilter.pending:
        return _todoList.where((task) => !(task.completed ?? false)).toList();
      case TaskFilter.all:
      default:
        return _todoList;
    }
  }

  bool get fetched => _fetched;
  bool get isLoading => _isLoading;
  TaskFilter get filter => _filter;

  Future<void> fetchTodos() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();

    try {
      final response = await Dio().get('https://dummyjson.com/todos', queryParameters: {
        'skip': _skip,
        'limit': _limit,
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> json = response.data;
        List<dynamic> data = json['todos'];
        _totalTasks = json['total'];
        _skip += _limit;

        List<TodoTask> newTodos = data.map((todo) => TodoTask.fromJson(todo)).toList();
        _todoList.addAll(newTodos);
        _fetched = true;
      }
    } catch (e) {
      debugPrint("Error fetching todos: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleTaskCompletion(TodoTask task) {
    task.completed = !task.completed!;
    notifyListeners();
  }

  void setFilter(TaskFilter filter) {
    _filter = filter;
    notifyListeners();
  }
}