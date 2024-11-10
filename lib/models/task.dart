class Task {
  String title;
  String description;
  DateTime dueDate;
  String category;
  bool isCompleted;

  Task(this.title, this.description, this.dueDate, this.category,
      {this.isCompleted = false});
}
