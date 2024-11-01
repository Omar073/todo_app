import 'package:flutter/material.dart';
import 'package:todo_app/Model/Classes/Todo.dart';

class TodoCard extends StatefulWidget {
  const TodoCard({super.key, required this.onChange, required this.todo});
  final Todo todo;
  final void Function() onChange;

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.todo.title ?? '',
                  style: const TextStyle(fontSize: 16),
                  softWrap: true,
                  overflow: TextOverflow.clip,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: widget.onChange,
                  child: widget.todo.isCompleted ?? false
                      ? const Icon(Icons.check_circle, size: 20)
                      : const Icon(Icons.check_circle_outline, size: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Created by: u${widget.todo.userId}',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
