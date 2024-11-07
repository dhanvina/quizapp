import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quizapp/presentation/pages/question_page.dart'; // Import the QuestionPage

class CountdownPage extends StatefulWidget {
  final int quizTimeInMinutes; // dynamic quiz time in seconds

  const CountdownPage({super.key, required this.quizTimeInMinutes});

  @override
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {
  int _currentTime = 3; // 3 seconds countdown
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_currentTime > 0) {
          _currentTime--;
        } else {
          _timer.cancel();
          // After countdown finishes, navigate to QuestionPage
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => QuestionPage(
                quizTimeInMinutes: widget
                    .quizTimeInMinutes, // Pass the time dynamically in minutes
              ),
            ),
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          '$_currentTime', // Show the 3-second countdown
          style: TextStyle(
            fontSize: 100,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
