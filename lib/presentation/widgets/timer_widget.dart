import 'dart:async';

import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  final int quizTimeInMinutes;
  final VoidCallback onTimerEnd;

  TimerWidget({required this.quizTimeInMinutes, required this.onTimerEnd});

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late int _remainingSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.quizTimeInMinutes * 60;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer?.cancel();
        widget.onTimerEnd();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        alignment: Alignment.center,
        width: 120,
        height: 45,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Color(0xFF9DCC29),
            borderRadius: BorderRadius.circular(71),
            border: Border.all(
              color: Color(0xFF9D0707),
              width: 3,
            )),
        child: Text(
          _formatTime(_remainingSeconds),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFFCE2E2E),
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            height: 45.8 / 35.65,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }
}
