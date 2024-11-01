import 'dart:async';

import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  final int quizTimeInSeconds;
  final VoidCallback onTimerEnd;

  const TimerWidget({
    Key? key,
    required this.quizTimeInSeconds,
    required this.onTimerEnd,
  }) : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late int timeRemaining;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    timeRemaining = widget.quizTimeInSeconds;
    _startTimer();
  }

  @override
  void didUpdateWidget(TimerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.quizTimeInSeconds != oldWidget.quizTimeInSeconds) {
      _resetTimer();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeRemaining == 0) {
        widget.onTimerEnd();
        timer.cancel();
      } else {
        setState(() {
          timeRemaining--;
        });
      }
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      timeRemaining = widget.quizTimeInSeconds;
    });
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '$timeRemaining seconds left',
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
