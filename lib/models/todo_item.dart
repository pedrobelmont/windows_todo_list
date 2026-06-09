import 'sub_task.dart';

class TodoItem {
  final String id;
  String text;
  bool isCompleted;
  List<SubTask> subtasks;
  bool isExpanded;

  TodoItem({
    required this.id,
    required this.text,
    this.isCompleted = false,
    List<SubTask>? subtasks,
    this.isExpanded = false,
  }) : subtasks = subtasks ?? [];
}
