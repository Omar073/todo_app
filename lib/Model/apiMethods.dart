import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'Classes/TodoTask.dart';

Future<List<TodoTask>> fetchToDos() async {
  final response = await Dio().get('https://dummyjson.com/todos');

  if (response.statusCode == 200) {
    debugPrint("status code 200");
    // Parse the JSON response as a Map
    // this map of string and dynamic represents the JSON response
    Map<String, dynamic> json = response.data;
    // Access the "todos" key which contains the list
    List<dynamic> data = json['todos'];

    List<TodoTask> toDos = [];

    for (var todo in data) {
      toDos.add(TodoTask.fromJson(todo));
      // debugPrint(todo.toString());
    }
    debugPrint("\n\n\n done \n\n\n");
    return toDos;
  } else {
    throw Exception('Failed to load todos');
  }
}

Future<TodoTask> fetchToDo(int id) async {
  final response = await Dio().get('https://dummyjson.com/todos/$id');

  if (response.statusCode == 200) {
    return TodoTask.fromJson(response.data);
  } else {
    throw Exception('Failed to load todo');
  }
}
