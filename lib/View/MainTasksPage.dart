import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Model/Providers/TodoProvider.dart';
import 'CustomWidgets/commonWidgets.dart';
import 'CustomWidgets/TodoCard.dart';

class MainTasksPage extends StatefulWidget {
  const MainTasksPage({super.key});

  @override
  State<MainTasksPage> createState() => _MainTasksPageState();
}

class _MainTasksPageState extends State<MainTasksPage> {
  double _width = 0;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    Future.microtask(() => Provider.of<TodoProvider>(context, listen: false).fetchTodos());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      Provider.of<TodoProvider>(context, listen: false).fetchTodos();
    }
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    return _width < 600 ? verticalView() : horizontalView();
  }

  Widget verticalView() {
    final todoProvider = Provider.of<TodoProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          getCustomWidget1(),
          getCustomWidget2(
              todoProvider.todoList.length,
              todoProvider.todoList
                  .where((task) => task.completed ?? false)
                  .length),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: todoProvider.todoList.length + (todoProvider.isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == todoProvider.todoList.length) {
                  return const Center(child: CircularProgressIndicator());
                }
                final todoTask = todoProvider.todoList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TodoCard(
                    todoTask: todoTask,
                    onChange: () {
                      todoProvider.toggleTaskCompletion(todoTask);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget horizontalView() {
    return Column();
  }
}