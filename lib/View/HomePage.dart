import '../Model/apiMethods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/Providers/TodoProvider.dart';
import '../Model/Classes/TodoTask.dart';
import '../Model/apiMethods.dart';
import 'LastActivityPage.dart';
import 'MainTasksPage.dart';
import 'MessagesPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TodoTask> todoList = [];
  double _width = 0;
  int _selectedIndex = 0;
  late List<Widget> _pages = [];
  bool fetched = false;

  @override
  void initState() {
    super.initState();
    Provider.of<TodoProvider>(context, listen: false).fetchTodos();
    // _initializeTodos();
  }

  Future<void> _initializeTodos() async {
    try {
      final todos = await fetchToDos();
      setState(() {
        todoList = todos;
        fetched = true;
        _pages = [MainTasksPage(), MessagesPage(), LastActivityPage()];
      });
    } catch (e) {
      debugPrint("Error fetching todos: $e");
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    final todoProvider = Provider.of<TodoProvider>(context);

    _pages = [MainTasksPage(), MessagesPage(), LastActivityPage()];

    return Scaffold(
      appBar: _width > 600
          ? AppBar(
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              ),
            )
          : null,
      drawer: _width > 600 ? customDrawer() : null,
      body: todoProvider.fetched
          ? _pages[_selectedIndex]
          : const Center(child: CircularProgressIndicator()),
      bottomNavigationBar: _width < 600 ? bottomNavigationBar() : null,
    );
  }

  BottomNavigationBar bottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: SizedBox(),
          label: "Today's Tasks",
        ),
        BottomNavigationBarItem(
          icon: SizedBox(),
          label: "Messages",
        ),
        BottomNavigationBarItem(
          icon: SizedBox(),
          label: "Last Activity",
        ),
      ],
      selectedItemColor: Colors.blue[300],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }

  Drawer customDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          Builder(builder: (context) {
            return ListTile(
              title: const Text("Today's Tasks"),
              onTap: () {
                _onItemTapped(0);
                Scaffold.of(context).closeDrawer();
              },
            );
          }),
          Builder(builder: (context) {
            return ListTile(
              title: const Text('Messages'),
              onTap: () {
                _onItemTapped(1);
                Scaffold.of(context).closeDrawer();
              },
            );
          }),
          Builder(builder: (context) {
            return ListTile(
              title: const Text('Last Activity'),
              onTap: () {
                _onItemTapped(2);
                Scaffold.of(context).closeDrawer();
              },
            );
          }),
        ],
      ),
    );
  }
}
