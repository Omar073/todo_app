import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Model/Providers/TodoProvider.dart';

Widget getCustomWidget1() {
  String formattedDate = DateFormat('EEEE\nd MMMM yyyy').format(DateTime.now());
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 14.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            const Text(
              "Today's Tasks",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Text(
              formattedDate,
              textAlign: TextAlign.center,  // Center-aligns the date text within the column
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
        const SizedBox(
          width: 50,
        ),
        Expanded(
            child: GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Center(
                child: Text(
                  '+ New Task',
                  style: TextStyle(color: Colors.blue[500], fontSize: 20),
                ),
              ),
            ),
          ),
        )),
      ],
    ),
  );
}

Widget getCustomWidget2(int totalTasks, int completedTasks) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Builder(
          builder: (context) {
            return filterButton(context, "All Tasks", TaskFilter.all, totalTasks);
          }
        ),
        Container(color: Colors.black, width: 2, height: 20),
        Builder(
          builder: (context) {
            return filterButton(context, "Completed", TaskFilter.completed, completedTasks);
          }
        ),
        Builder(
          builder: (context) {
            return filterButton(context, "Pending", TaskFilter.pending, totalTasks - completedTasks);
          }
        ),
      ],
    ),
  );

}

Widget filterButton(BuildContext context, String label, TaskFilter filter, int count) {
  final todoProvider = Provider.of<TodoProvider>(context);
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: GestureDetector(
      onTap: () {
        todoProvider.setFilter(filter);
      },
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 15),
          ),
          const SizedBox(
            width: 5,
          ),
          Container(
            decoration: BoxDecoration(
              color: todoProvider.filter == filter ? Colors.blue[700] : Colors.grey,
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.0),
              child: Text("$count", style: TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
    ),
  );

}
