import 'package:flutter/material.dart';
import '../../models/todo_item.dart';
import '../../viewmodels/todo_viewmodel.dart';
import 'subtask_input_row.dart';
import 'subtask_tile.dart';

class TodoTile extends StatelessWidget {
  final TodoItem todo;
  final TodoViewModel viewModel;

  const TodoTile({super.key, required this.todo, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final totalSubtasks = todo.subtasks.length;
    final completedSubtasks = todo.subtasks.where((st) => st.isCompleted).length;
    final hasSubtasks = totalSubtasks > 0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.04),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => viewModel.toggleTodo(todo.id),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: todo.isCompleted ? const Color(0xFF10B981) : Colors.transparent,
                      border: Border.all(
                        color: todo.isCompleted ? const Color(0xFF10B981) : Colors.white.withValues(alpha: 0.3),
                        width: 1.5,
                      ),
                    ),
                    child: todo.isCompleted
                        ? const Icon(
                            Icons.check_rounded,
                            size: 14,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    todo.text,
                    style: TextStyle(
                      color: todo.isCompleted ? Colors.white.withValues(alpha: 0.35) : Colors.white,
                      fontSize: 13,
                      decoration: todo.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                    ),
                  ),
                ),
                if (hasSubtasks)
                  Container(
                    margin: const EdgeInsets.only(right: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '$completedSubtasks/$totalSubtasks',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                IconButton(
                  icon: Icon(
                    todo.isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                    color: Colors.white.withValues(alpha: 0.4),
                    size: 18,
                  ),
                  onPressed: () => viewModel.toggleExpansion(todo),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
                  splashRadius: 12,
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.white.withValues(alpha: 0.4),
                    size: 18,
                  ),
                  onPressed: () => viewModel.deleteTodo(todo.id),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
                  splashRadius: 12,
                  hoverColor: Colors.red.withValues(alpha: 0.1),
                ),
              ],
            ),
            if (todo.isExpanded) ...[
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(left: 28.0, bottom: 6.0),
                child: Container(
                  height: 1,
                  color: Colors.white.withValues(alpha: 0.05),
                ),
              ),
              ...todo.subtasks.map((subtask) => buildSubTaskTile(
                    context: context,
                    viewModel: viewModel,
                    parentTodo: todo,
                    subtask: subtask,
                  )),
              SubTaskInputRow(
                onAdd: (text) => viewModel.addSubTask(todo, text),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
