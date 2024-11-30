import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart'; // Import the logger package
import 'package:quizapp/presentation/pages/vedic_math_page.dart';

import '../../domain/entities/firestore_quiz.dart';

// Initialize logger instance
final Logger logger = Logger();

class CountdownPage extends StatefulWidget {
  final int quizTimeInMinutes;
  final String paperType;
  final String title;
  final int numberOfQuestions;
  final List<QuizQuestion> questions;
  final String quizId;
  final bool isLive;
  final int timeLimit;

  // Constructor for CountdownPage
  const CountdownPage({
    super.key,
    required this.quizTimeInMinutes,
    required this.paperType,
    required this.title,
    required this.numberOfQuestions,
    required this.questions,
    required this.quizId,
    required this.isLive,
    required this.timeLimit,
  });

  @override
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {
  int _currentTime = 3; // Initial countdown time (in seconds)
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    logger.i(
        'Countdown started for quiz: ${widget.title}'); // Log when countdown starts
    _startCountdown();
  }

  // Method to start the countdown timer
  void _startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_currentTime > 0) {
          _currentTime--; // Decrease time by 1 second
          logger.i(
              'Countdown updated: $_currentTime seconds remaining'); // Log updated countdown
        } else {
          _timer.cancel(); // Stop the timer when it reaches 0
          logger.i(
              'Countdown finished. Navigating to the quiz page...'); // Log when countdown finishes

          // Navigate to quiz page based on the paper type
          if (widget.paperType == 'fill') {
            // Log for navigation to VedicQuizPage
            logger.i(
                "Navigating to VedicQuizPage with quiz data: ${widget.title}");

            logger.i("Questions: ${widget.questions}");

            // Assuming you already have the Quiz object (e.g., quizData)
            Quiz quizData = Quiz(
              quizId: widget
                  .quizId, // pass the quizId from your widget or wherever it's defined
              title: widget.title, // pass the title
              isLive: widget.isLive, // pass the isLive status
              paperType: widget.paperType, // pass the paperType
              timeLimit: widget.timeLimit, // pass the timeLimit
              questions: widget.questions, // pass the list of QuizQuestion
            );
            try {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => VedicMathPage(quiz: quizData),
                ),
              );
            } catch (e) {
              logger.e("Error navigating to quiz page: $e");
            }
          } else {
            // Uncomment this block for other paper types (e.g., regular quiz)
            // logger.i('Navigating to regular quiz page');
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => QuestionPage(
            //       quizTimeInMinutes: widget.quizTimeInMinutes,
            //     ),
            //   ),
            // );
          }
        }
      });
    });
  }

  @override
  void dispose() {
    logger.i('Timer disposed.'); // Log when the timer is disposed
    _timer.cancel(); // Stop the timer when the page is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          '$_currentTime', // Display the current countdown time
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
