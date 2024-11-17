import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quizapp/presentation/pages/question_page.dart';
import 'package:quizapp/presentation/pages/vedic_math_page.dart';

class CountdownPage extends StatefulWidget {
  final int quizTimeInMinutes;
  final String paperType;
  final String title;
  final int numberOfQuestions;

  const CountdownPage({
    super.key,
    required this.quizTimeInMinutes,
    required this.paperType,
    required this.title,
    required this.numberOfQuestions,
  });

  @override
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {
  int _currentTime = 3;
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
          if (widget.paperType == 'vedic') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => VedicMathPage(
                  quizTimeInMinutes: widget.quizTimeInMinutes,
                  title: widget.title,
                ),
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => QuestionPage(
                  quizTimeInMinutes: widget.quizTimeInMinutes,
                ),
              ),
            );
          }
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
          '$_currentTime',
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
