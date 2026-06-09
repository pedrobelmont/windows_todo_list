import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import '../viewmodels/timer_viewmodel.dart';
import '../viewmodels/todo_viewmodel.dart';
import 'widgets/tab_row.dart';
import 'widgets/timer_view.dart';
import 'widgets/todo_tile.dart';

class ExpandedView extends StatefulWidget {
  final TodoViewModel todoViewModel;
  final TimerViewModel timerViewModel;
  final VoidCallback onToggleExpand;
  final String activeTab;
  final Function(String) onTabChanged;

  const ExpandedView({
    super.key,
    required this.todoViewModel,
    required this.timerViewModel,
    required this.onToggleExpand,
    required this.activeTab,
    required this.onTabChanged,
  });

  @override
  State<ExpandedView> createState() => _ExpandedViewState();
}

class _ExpandedViewState extends State<ExpandedView> {
  final TextEditingController _todoController = TextEditingController();

  void _submitTodo() {
    final text = _todoController.text.trim();
    if (text.isNotEmpty) {
      widget.todoViewModel.addTodo(text);
      _todoController.clear();
    }
  }

  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final incompleteCount = widget.todoViewModel.incompleteCount;
    final todos = widget.todoViewModel.todos;

    return Center(
      child: Container(
        width: 300,
        height: 460,
        decoration: BoxDecoration(
          color: const Color(0xEE111827),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.12),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 20,
              spreadRadius: 2,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            DragToMoveArea(
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 12, top: 16, bottom: 12),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white.withValues(alpha: 0.06),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Minhas Tarefas',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            incompleteCount == 0 ? 'Tudo concluído! 🎉' : '$incompleteCount pendentes',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_fullscreen_rounded, color: Colors.white70, size: 18),
                      onPressed: widget.onToggleExpand,
                      tooltip: 'Minimizar',
                      splashRadius: 20,
                    ),
                  ],
                ),
              ),
            ),
            TabRow(
              activeTab: widget.activeTab,
              onTabChanged: widget.onTabChanged,
            ),
            Expanded(
              child: widget.activeTab == 'tarefas'
                  ? (todos.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          itemCount: todos.length,
                          itemBuilder: (context, index) {
                            return TodoTile(
                              todo: todos[index],
                              viewModel: widget.todoViewModel,
                            );
                          },
                        ))
                  : TimerView(timerViewModel: widget.timerViewModel),
            ),
            if (widget.activeTab == 'tarefas')
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.white.withValues(alpha: 0.06),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _todoController,
                        style: const TextStyle(color: Colors.white, fontSize: 13),
                        onSubmitted: (_) => _submitTodo(),
                        decoration: InputDecoration(
                          hintText: 'Adicione uma tarefa...',
                          hintStyle: TextStyle(
                            color: Colors.white.withValues(alpha: 0.35),
                            fontSize: 13,
                          ),
                          filled: true,
                          fillColor: Colors.white.withValues(alpha: 0.06),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: const Color(0xFF6366F1).withValues(alpha: 0.5),
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color(0xFF6366F1), Color(0xFFA855F7)],
                        ),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.add_rounded, color: Colors.white),
                        onPressed: _submitTodo,
                        iconSize: 20,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                        splashRadius: 18,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.spa_rounded,
            size: 48,
            color: Colors.white.withValues(alpha: 0.2),
          ),
          const SizedBox(height: 12),
          Text(
            'Nenhuma tarefa pendente',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.4),
              fontSize: 13,
            ),
          ),
          Text(
            'Aproveite o seu dia! ☀️',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.3),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
