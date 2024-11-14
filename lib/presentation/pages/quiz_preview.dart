import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quizapp/presentation/pages/countdown_page.dart';
import 'package:quizapp/presentation/pages/motivation_screen1.dart';
import 'package:quizapp/presentation/pages/motivation_screen2.dart';

class QuizPreview extends StatefulWidget {
  final String title;
  final int time;
  final int numberOfQuestions;

  const QuizPreview(
      {required this.title,
      required this.time,
      required this.numberOfQuestions});

  @override
  _QuizPreviewState createState() => _QuizPreviewState();
}

class _QuizPreviewState extends State<QuizPreview> {
  String formatTime(int totalMinutes) {
    final int minutes = totalMinutes % 60;
    final int seconds = 0;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 400,
        height: 600,
        decoration: BoxDecoration(
          color: Color(0xFFA2D12C),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/quiz_preview.png',
              height: 225.81,
              width: 309.45,
            ),
            const SizedBox(height: 2.0),
            // Test information box
            Container(
              width: 350,
              height: 210,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: 15.0),
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    "There are a total of ${widget.numberOfQuestions} questions",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    "Time - ${formatTime(widget.time)}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      // Navigate to TestPreparationScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MotivationScreen1(),
                        ),
                      );

                      // Wait for 5 seconds
                      await Future.delayed(Duration(seconds: 10));

                      // Navigate to the next screen (replace with your actual screen)
                      if (!mounted)
                        return; // Check if the widget is still mounted
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MotivationScreen2(), // Replace with your next screen
                        ),
                      );

                      await Future.delayed(Duration(seconds: 12));

                      if (!mounted)
                        return; // Check if the widget is still mounted
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CountdownPage(
                            quizTimeInMinutes: widget.time,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(7),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF00A455), // Custom color #00A455
                        borderRadius: BorderRadius.circular(
                            8), // Adjust the radius for rounded corners, or remove for a rectangle
                        border: Border.all(color: Colors.transparent),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10), // Adjust padding as needed
                      child: const Text(
                        'NEXT',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16, // Adjust font size as needed
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
