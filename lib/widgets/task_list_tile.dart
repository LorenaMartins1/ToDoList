import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskListTile extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onToggleComplete;

  TaskListTile({
    required this.task,
    required this.onTap,
    required this.onDelete,
    required this.onToggleComplete,
  });

  @override
  Widget build(BuildContext context) {
    bool isOverdue = DateTime.now().isAfter(task.dueDate) && !task.isCompleted;
    return Card(
      color: task.isCompleted
          ? Colors.grey.shade300
          : isOverdue
              ? Colors.red.shade200
              : Colors.purple.shade300,
      child: ListTile(
        title: Text(
          task.title,
          style: TextStyle(
            color: task.isCompleted ? Colors.grey : Colors.white,
            decoration: task.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: Text(
          'Categoria: ${task.category} - Vencimento: ${task.dueDate}',
          style: TextStyle(
            color: task.isCompleted ? Colors.grey : Colors.white70,
            decoration: task.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        onTap: onTap,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                task.isCompleted
                    ? Icons.check_box
                    : Icons.check_box_outline_blank,
                color: Colors.white,
              ),
              onPressed: onToggleComplete,
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.white),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
