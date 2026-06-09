import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import '../viewmodels/timer_viewmodel.dart';
import '../viewmodels/todo_viewmodel.dart';

class CollapsedView extends StatelessWidget {
  final TodoViewModel todoViewModel;
  final TimerViewModel timerViewModel;
  final VoidCallback onToggleExpand;
  final AnimationController pulseController;

  const CollapsedView({
    super.key,
    required this.todoViewModel,
    required this.timerViewModel,
    required this.onToggleExpand,
    required this.pulseController,
  });

  @override
  Widget build(BuildContext context) {
    final bool showTimer = timerViewModel.isActive;
    final incompleteCount = todoViewModel.incompleteCount;
    final double taskCompletionPercent = todoViewModel.taskCompletionPercent;

    final double timerPercent = timerViewModel.timerPercent;
    final timeStr = timerViewModel.formattedTime;
    final isCompleted = timerViewModel.timerCompletedNotification;
    final mode = timerViewModel.timerMode;

    Color progressColor;
    if (isCompleted) {
      progressColor = const Color(0xFFEF4444);
    } else if (mode == 'foco') {
      progressColor = const Color(0xFFF97316);
    } else if (mode == 'pausaCurta') {
      progressColor = const Color(0xFF10B981);
    } else {
      progressColor = const Color(0xFF3B82F6);
    }

    return AnimatedBuilder(
      animation: pulseController,
      builder: (context, child) {
        double scale = 1.0;
        if (isCompleted) {
          scale = 1.0 + (pulseController.value * 0.08);
        }
        return Transform.scale(
          scale: scale,
          child: child,
        );
      },
      child: Center(
        child: GestureDetector(
          onPanStart: (_) => windowManager.startDragging(),
          onTap: onToggleExpand,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 68,
                  height: 68,
                  child: CircularProgressIndicator(
                    value: showTimer ? timerPercent : taskCompletionPercent,
                    strokeWidth: 4,
                    backgroundColor: Colors.white.withValues(alpha: 0.1),
                    color: showTimer ? progressColor : Colors.indigoAccent,
                  ),
                ),
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: showTimer
                          ? [progressColor, progressColor.withValues(alpha: 0.7)]
                          : const [Color(0xFF6366F1), Color(0xFFA855F7)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: (showTimer ? progressColor : const Color(0xFF6366F1)).withValues(alpha: 0.4),
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: showTimer
                        ? (isCompleted
                            ? const Icon(Icons.notifications_active_rounded, color: Colors.white, size: 24)
                            : Text(
                                timeStr,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'monospace',
                                ),
                              ))
                        : const Icon(Icons.playlist_add_check_rounded, color: Colors.white, size: 28),
                  ),
                ),
                if (!showTimer && incompleteCount > 0)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Color(0xFFEF4444),
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Text(
                        '$incompleteCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
