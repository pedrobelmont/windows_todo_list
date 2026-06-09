import 'package:flutter/material.dart';
import '../../models/sub_task.dart';
import '../../models/todo_item.dart';
import '../../viewmodels/todo_viewmodel.dart';

Widget buildSubTaskTile({
  required BuildContext context,
  required TodoViewModel viewModel,
  required TodoItem parentTodo,
  required SubTask subtask,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 28.0, top: 4.0, bottom: 4.0),
    child: Row(
      children: [
        GestureDetector(
          onTap: () => viewModel.toggleSubTask(parentTodo, subtask.id),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: subtask.isCompleted ? const Color(0xFF10B981) : Colors.transparent,
              border: Border.all(
                color: subtask.isCompleted
                    ? const Color(0xFF10B981)
                    : Colors.white.withValues(alpha: 0.25),
                width: 1.2,
              ),
            ),
            child: subtask.isCompleted
                ? const Icon(
                    Icons.check_rounded,
                    size: 10,
                    color: Colors.white,
                  )
                : null,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            subtask.text,
            style: TextStyle(
              color: subtask.isCompleted
                  ? Colors.white.withValues(alpha: 0.35)
                  : Colors.white.withValues(alpha: 0.8),
              fontSize: 12,
              decoration: subtask.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.close_rounded,
            color: Colors.white.withValues(alpha: 0.3),
            size: 14,
          ),
          onPressed: () => viewModel.deleteSubTask(parentTodo, subtask.id),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 22, minHeight: 22),
          splashRadius: 10,
          hoverColor: Colors.red.withValues(alpha: 0.1),
        ),
      ],
    ),
  );
}
