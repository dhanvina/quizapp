import 'dart:async';

import 'package:flutter/material.dart';

class TimerWidgetSec extends StatefulWidget {
  final int quizTimeInSeconds; // Total time for the quiz in seconds
  final VoidCallback onTimerEnd; // Callback when the timer ends

  const TimerWidgetSec({
    Key? key,
    required this.quizTimeInSeconds,
    required this.onTimerEnd,
  }) : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidgetSec> {
  late int remainingTime; // Variable to track remaining time
  late Timer timer; // Timer instance

  @override
  void initState() {
    super.initState();
    remainingTime = widget.quizTimeInSeconds; // Initialize remaining time
    startTimer(); // Start the countdown timer
  }

  @override
  void dispose() {
    timer.cancel(); // Cancel the timer on dispose
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--; // Decrease remaining time
        } else {
          timer.cancel(); // Stop the timer when it reaches zero
          widget.onTimerEnd(); // Call the callback function
        }
      });
    });
  }

  String formatTime(int seconds) {
    // Format time in MM:SS
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFFD9D9D9), // Fill color
            border: Border.all(
              color: const Color(0xFF9D0707), // Border color
              width: 3, // Border width
            ),
            borderRadius:
                BorderRadius.circular(71), // Optional: rounded corners
          ),
          padding: const EdgeInsets.symmetric(
              horizontal: 16.0, vertical: 8.0), // Padding for the container
          child: Row(
            mainAxisSize: MainAxisSize.min, // To wrap the contents tightly
            children: [
              Text(
                formatTime(remainingTime), // Display the remaining time
                style: TextStyle(
                  fontFamily: 'Poppins', // Font family
                  fontWeight: FontWeight.w600, // Semi-bold
                  color: const Color(0xFFCE2E2E), // Text color
                  fontSize: 20, // Adjust font size as needed
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
