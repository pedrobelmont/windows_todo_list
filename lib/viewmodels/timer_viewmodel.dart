import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:window_manager/window_manager.dart';

class TimerViewModel extends ChangeNotifier {
  Timer? _timer;
  int _secondsRemaining = 25 * 60;
  int _totalDurationSeconds = 25 * 60;
  bool _isTimerRunning = false;
  bool _isTimerPaused = false;
  String _timerMode = 'foco'; // 'foco', 'pausaCurta', 'pausaLonga'
  bool _timerCompletedNotification = false;

  int get secondsRemaining => _secondsRemaining;
  int get totalDurationSeconds => _totalDurationSeconds;
  bool get isTimerRunning => _isTimerRunning;
  bool get isTimerPaused => _isTimerPaused;
  String get timerMode => _timerMode;
  bool get timerCompletedNotification => _timerCompletedNotification;

  bool get isActive => _isTimerRunning || _isTimerPaused || _timerCompletedNotification;

  double get timerPercent => _totalDurationSeconds > 0
      ? (_secondsRemaining / _totalDurationSeconds)
      : 0.0;

  String get formattedTime {
    final minutes = (_secondsRemaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsRemaining % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void startTimer() {
    if (_isTimerRunning) return;
    _timerCompletedNotification = false;
    _isTimerRunning = true;
    _isTimerPaused = false;
    notifyListeners();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        _secondsRemaining--;
        notifyListeners();
      } else {
        _onTimerFinished();
      }
    });
  }

  void pauseTimer() {
    if (!_isTimerRunning) return;
    _timer?.cancel();
    _isTimerRunning = false;
    _isTimerPaused = true;
    notifyListeners();
  }

  void resetTimer() {
    _timer?.cancel();
    _isTimerRunning = false;
    _isTimerPaused = false;
    _timerCompletedNotification = false;
    _initializeTimerDuration();
    notifyListeners();
  }

  void setTimerMode(String mode) {
    _timer?.cancel();
    _timerMode = mode;
    _isTimerRunning = false;
    _isTimerPaused = false;
    _timerCompletedNotification = false;
    _initializeTimerDuration();
    notifyListeners();
  }

  void dismissNotification() {
    _timerCompletedNotification = false;
    notifyListeners();
  }

  void skipTimerMode() {
    if (_timerMode == 'foco') {
      setTimerMode('pausaCurta');
    } else if (_timerMode == 'pausaCurta') {
      setTimerMode('pausaLonga');
    } else {
      setTimerMode('foco');
    }
  }

  void _initializeTimerDuration() {
    if (_timerMode == 'foco') {
      _secondsRemaining = 25 * 60;
      _totalDurationSeconds = 25 * 60;
    } else if (_timerMode == 'pausaCurta') {
      _secondsRemaining = 5 * 60;
      _totalDurationSeconds = 5 * 60;
    } else {
      _secondsRemaining = 15 * 60;
      _totalDurationSeconds = 15 * 60;
    }
  }

  void _onTimerFinished() async {
    _timer?.cancel();
    _isTimerRunning = false;
    _isTimerPaused = false;
    _timerCompletedNotification = true;
    notifyListeners();

    // Traz a janela para foco para alertar
    await windowManager.show();
    await windowManager.focus();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
