import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quizapp/presentation/pages/countdown_page.dart';
import 'package:quizapp/presentation/pages/motivation_screen1.dart';
import 'package:quizapp/presentation/pages/motivation_screen2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizPreview extends StatefulWidget {
  final String title;
  final int time;
  final String paper_type;
  final int numberOfQuestions;

  const QuizPreview({
    required this.title,
    required this.time,
    required this.paper_type,
    required this.numberOfQuestions,
  });

  @override
  _QuizPreviewState createState() => _QuizPreviewState();
}

class _QuizPreviewState extends State<QuizPreview> {
  final TextEditingController _idController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String formatTime(int totalMinutes) {
    final int minutes = totalMinutes % 60;
    final int seconds = 0;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  Future<void> saveId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA2D12C),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 400,
            height: 600,
            decoration: BoxDecoration(
              color: const Color(0xFFA2D12C),
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
                const SizedBox(height: 20.0),
                Container(
                  width: 350,
                  height: 300,
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
                      const SizedBox(height: 15.0),
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Text(
                        "There are a total of ${widget.numberOfQuestions} questions",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Text(
                        "Time - ${formatTime(widget.time)}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // TextFormField for ID input
                            if (widget.title == "Live Quiz") ...[
                              TextFormField(
                                controller: _idController,
                                decoration: InputDecoration(
                                  labelText: "Enter your ID",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your ID';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20.0),
                            ],
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await saveId(_idController.text);

                                  // Perform actions after form is validated
                                  // Navigate to MotivationScreen1
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MotivationScreen1(),
                                    ),
                                  );

                                  // Wait for 10 seconds
                                  await Future.delayed(Duration(seconds: 10));

                                  // Navigate to MotivationScreen2
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MotivationScreen2(),
                                    ),
                                  );

                                  await Future.delayed(Duration(seconds: 12));

                                  // Navigate to CountdownPage
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CountdownPage(
                                        title: widget.title,
                                        quizTimeInMinutes: widget.time,
                                        paperType: widget.paper_type,
                                        numberOfQuestions:
                                            widget.numberOfQuestions,
                                      ),
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                backgroundColor: const Color(0xFF00A455),
                              ),
                              child: const Text(
                                'NEXT',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
