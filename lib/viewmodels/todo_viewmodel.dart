import 'package:flutter/foundation.dart';
import '../models/todo_item.dart';
import '../models/sub_task.dart';

class TodoViewModel extends ChangeNotifier {
  final List<TodoItem> _todos = [];

  List<TodoItem> get todos => List.unmodifiable(_todos);

  int get incompleteCount => _todos.where((t) => !t.isCompleted).length;
  int get totalCount => _todos.length;

  double get taskCompletionPercent {
    if (_todos.isEmpty) return 0.0;
    return _todos.where((t) => t.isCompleted).length / _todos.length;
  }

  void addTodo(String text) {
    final trimmedText = text.trim();
    if (trimmedText.isNotEmpty) {
      _todos.add(
        TodoItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: trimmedText,
        ),
      );
      notifyListeners();
    }
  }

  void toggleTodo(String id) {
    final index = _todos.indexWhere((t) => t.id == id);
    if (index != -1) {
      final todo = _todos[index];
      todo.isCompleted = !todo.isCompleted;
      // Sincroniza sub-tarefas
      for (var subtask in todo.subtasks) {
        subtask.isCompleted = todo.isCompleted;
      }
      notifyListeners();
    }
  }

  void deleteTodo(String id) {
    _todos.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  void addSubTask(TodoItem todo, String text) {
    final trimmedText = text.trim();
    if (trimmedText.isEmpty) return;
    todo.subtasks.add(
      SubTask(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: trimmedText,
      ),
    );
    _updateParentCompletion(todo);
    notifyListeners();
  }

  void toggleSubTask(TodoItem todo, String subTaskId) {
    final index = todo.subtasks.indexWhere((st) => st.id == subTaskId);
    if (index != -1) {
      todo.subtasks[index].isCompleted = !todo.subtasks[index].isCompleted;
      _updateParentCompletion(todo);
      notifyListeners();
    }
  }

  void deleteSubTask(TodoItem todo, String subTaskId) {
    todo.subtasks.removeWhere((st) => st.id == subTaskId);
    _updateParentCompletion(todo);
    notifyListeners();
  }

  void toggleExpansion(TodoItem todo) {
    todo.isExpanded = !todo.isExpanded;
    notifyListeners();
  }

  void _updateParentCompletion(TodoItem todo) {
    if (todo.subtasks.isEmpty) return;
    final allCompleted = todo.subtasks.every((st) => st.isCompleted);
    todo.isCompleted = allCompleted;
  }
}
