import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'themes/app_theme.dart';

void main() => runApp(TaskApp());

class TaskApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task App',
      theme: AppTheme.lightTheme,
      home: TaskHomePage(),
    );
  }
}
