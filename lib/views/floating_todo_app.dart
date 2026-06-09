import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import '../viewmodels/timer_viewmodel.dart';
import '../viewmodels/todo_viewmodel.dart';
import 'collapsed_view.dart';
import 'expanded_view.dart';

class FloatingTodoApp extends StatefulWidget {
  const FloatingTodoApp({super.key});

  @override
  State<FloatingTodoApp> createState() => _FloatingTodoAppState();
}

class _FloatingTodoAppState extends State<FloatingTodoApp> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late final TodoViewModel _todoViewModel;
  late final TimerViewModel _timerViewModel;

  String _activeTab = 'tarefas';
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _todoViewModel = TodoViewModel();
    _timerViewModel = TimerViewModel();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _todoViewModel.dispose();
    _timerViewModel.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _toggleExpand() async {
    setState(() {
      _isExpanded = !_isExpanded;
    });
    if (_isExpanded) {
      await windowManager.setSize(const Size(320, 480), animate: true);
    } else {
      await windowManager.setSize(const Size(80, 80), animate: true);
    }
  }

  void _handleTabChanged(String newTab) {
    setState(() {
      _activeTab = newTab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListenableBuilder(
        listenable: Listenable.merge([_todoViewModel, _timerViewModel]),
        builder: (context, _) {
          return _isExpanded
              ? ExpandedView(
                  todoViewModel: _todoViewModel,
                  timerViewModel: _timerViewModel,
                  onToggleExpand: _toggleExpand,
                  activeTab: _activeTab,
                  onTabChanged: _handleTabChanged,
                )
              : CollapsedView(
                  todoViewModel: _todoViewModel,
                  timerViewModel: _timerViewModel,
                  onToggleExpand: _toggleExpand,
                  pulseController: _pulseController,
                );
        },
      ),
    );
  }
}
