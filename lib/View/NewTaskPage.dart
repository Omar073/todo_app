import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Model/Providers/TodoProvider.dart';
import '../Model/Classes/Todo.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({super.key});

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  //fetch current user id
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  void _addTask() {
    if (_titleController.text.isNotEmpty) {
      final newTodo = Todo(
        id: '', // Firestore will generate the ID
        title: _titleController.text,
        isCompleted: false,
        userId: userId,
      );
      debugPrint('Adding new task: ${newTodo.title}');
      Provider.of<TodoProvider>(context, listen: false).addTodo(newTodo);
      Navigator.pop(context);
    }
    else {
      debugPrint('Task title cannot be empty');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Task Title'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addTask,
              child: const Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}