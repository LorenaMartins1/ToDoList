import 'package:flutter/material.dart';
import '../models/task.dart';
import 'task_form_page.dart';
import '../widgets/task_list_tile.dart';

class TaskHomePage extends StatefulWidget {
  @override
  _TaskHomePageState createState() => _TaskHomePageState();
}

class _TaskHomePageState extends State<TaskHomePage> {
  List<Task> tasks = [];

  void _addTask() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => TaskFormPage(onSubmit: (task) {
              setState(() {
                tasks.add(task);
              });
            })));
  }

  void _editTask(Task task, int index) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => TaskFormPage(
              existingTask: task,
              onSubmit: (updatedTask) {
                setState(() {
                  tasks[index] = updatedTask;
                });
              },
            )));
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Gestão de Tarefas',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      backgroundColor: Colors.purple.shade100,
      body: tasks.isEmpty
          ? Center(
              child:
                  Text('Nenhuma tarefa', style: TextStyle(color: Colors.white)))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return TaskListTile(
                  task: task,
                  onTap: () => _editTask(task, index),
                  onDelete: () => _deleteTask(index),
                  onToggleComplete: () => _toggleTaskCompletion(index),
                );
              },
            ),
      floatingActionButton: ElevatedButton(
        onPressed: _addTask,
        child: Text('Adicionar'),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.purple,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
