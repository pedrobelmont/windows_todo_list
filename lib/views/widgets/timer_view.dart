import 'package:flutter/material.dart';
import '../../viewmodels/timer_viewmodel.dart';

class TimerView extends StatelessWidget {
  final TimerViewModel timerViewModel;

  const TimerView({super.key, required this.timerViewModel});

  @override
  Widget build(BuildContext context) {
    final progress = timerViewModel.timerPercent;
    final timeStr = timerViewModel.formattedTime;
    final mode = timerViewModel.timerMode;
    final isRunning = timerViewModel.isTimerRunning;
    final isCompleted = timerViewModel.timerCompletedNotification;

    Color themeColor;
    String modeLabel;
    if (mode == 'foco') {
      themeColor = const Color(0xFFF97316); // Orange
      modeLabel = 'Foco';
    } else if (mode == 'pausaCurta') {
      themeColor = const Color(0xFF10B981); // Emerald
      modeLabel = 'Pausa Curta';
    } else {
      themeColor = const Color(0xFF3B82F6); // Blue
      modeLabel = 'Pausa Longa';
    }

    if (isCompleted) {
      themeColor = const Color(0xFFEF4444);
      modeLabel = 'Finalizado! 🎉';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 6,
                  backgroundColor: Colors.white.withValues(alpha: 0.06),
                  color: themeColor,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    timeStr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    modeLabel.toUpperCase(),
                    style: TextStyle(
                      color: themeColor.withValues(alpha: 0.8),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildModeChip('foco', 'Foco'),
              const SizedBox(width: 8),
              _buildModeChip('pausaCurta', 'Pausa C.'),
              const SizedBox(width: 8),
              _buildModeChip('pausaLonga', 'Pausa L.'),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.replay_rounded, color: Colors.white60),
                onPressed: timerViewModel.resetTimer,
                iconSize: 24,
                tooltip: 'Reiniciar',
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: isRunning ? timerViewModel.pauseTimer : timerViewModel.startTimer,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: isRunning
                          ? [Colors.white24, Colors.white12]
                          : [themeColor, themeColor.withValues(alpha: 0.7)],
                    ),
                    boxShadow: [
                      if (!isRunning)
                        BoxShadow(
                          color: themeColor.withValues(alpha: 0.3),
                          blurRadius: 10,
                          spreadRadius: 1,
                        )
                    ],
                  ),
                  child: Icon(
                    isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              IconButton(
                icon: Icon(
                  isCompleted ? Icons.check_circle_rounded : Icons.skip_next_rounded,
                  color: isCompleted ? const Color(0xFF10B981) : Colors.white60,
                ),
                onPressed: () {
                  if (isCompleted) {
                    timerViewModel.dismissNotification();
                  } else {
                    timerViewModel.skipTimerMode();
                  }
                },
                iconSize: 24,
                tooltip: isCompleted ? 'Confirmar' : 'Pular',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildModeChip(String mode, String label) {
    final isSelected = timerViewModel.timerMode == mode;
    Color activeColor;
    if (mode == 'foco') {
      activeColor = const Color(0xFFF97316);
    } else if (mode == 'pausaCurta') {
      activeColor = const Color(0xFF10B981);
    } else {
      activeColor = const Color(0xFF3B82F6);
    }

    return GestureDetector(
      onTap: () => timerViewModel.setTimerMode(mode),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? activeColor.withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? activeColor.withValues(alpha: 0.6) : Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white60,
            fontSize: 10,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
