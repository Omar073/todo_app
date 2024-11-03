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
  late Future<void> _fetchTodosFuture;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    // Fetch todos only once during initialization
    // Future.microtask(() =>
    //     Provider.of<TodoProvider>(context, listen: false).fetchTodos());
    _fetchTodosFuture = Provider.of<TodoProvider>(context, listen: false).fetchTodos();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
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
            todoProvider.todos.length,
            todoProvider.todos.where((task) => task.isCompleted).length,
          ),
          Expanded(
            child: FutureBuilder(
              future: _fetchTodosFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error loading tasks.'));
                } else if (todoProvider.todos.isEmpty) {
                  return const Center(child: Text('No tasks available.'));
                } else {
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: todoProvider.todos.length,
                    itemBuilder: (context, index) {
                      final todoTask = todoProvider.todos[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TodoCard(
                          onChange: () {
                            todoProvider.toggleTaskCompletion(todoTask);
                          },
                          todo: todoTask,
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget horizontalView() {
    return const Column();
  }
}
