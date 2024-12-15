import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/presentation/pages/quiz_completed_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/firestore_quiz.dart';
import '../state_management/quiz_provider.dart';
import '../widgets/vedic_text.dart';

/// VedicMathPage is a quiz page for practicing Vedic mathematics.
class VedicMathPage extends StatefulWidget {
  final Quiz quiz;

  const VedicMathPage({
    required this.quiz,
    Key? key,
  }) : super(key: key);

  @override
  _VedicMathPageState createState() => _VedicMathPageState();
}

class _VedicMathPageState extends State<VedicMathPage> {
  final Map<int, num> _userAnswers =
      {}; // Store user answers for each question.
  int _score = 0; // Store the quiz score.
  late Timer totalTimer; // Timer for quiz duration.
  late int totalQuizTimeInSeconds; // Total time for the quiz in seconds.
  Timer? quizTimer;

  Duration elapsedQuizTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    // Convert quiz time limit from minutes to seconds.
    totalQuizTimeInSeconds = widget.quiz.timeLimit * 60;

    if (widget.quiz.questions.isNotEmpty) {
      // Start the timer if there are questions in the quiz.
      _startTotalTimer();
      _startQuizTimer();
    }
  }

  /// Starts a timer to track the total quiz duration.
  void _startTotalTimer() {
    totalTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (totalQuizTimeInSeconds > 0) {
          totalQuizTimeInSeconds--;
        } else {
          totalTimer.cancel();
          _onSubmitQuiz();
        }
      });
    });
  }

  void _startQuizTimer() {
    quizTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        elapsedQuizTime += const Duration(seconds: 1);
      });
    });
  }

  void _stopQuizTimer() {
    quizTimer?.cancel();
  }

  Future<void> _saveElapsedTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('quiz_time', elapsedQuizTime.inSeconds);
    log('[Timer] Saved quiz time: ${elapsedQuizTime.inSeconds} seconds');
  }

  /// Formats the remaining time as MM:SS.
  String get formattedTotalQuizTime {
    final minutes = (totalQuizTimeInSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalQuizTimeInSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  /// Handles quiz submission and navigates to the results page.
  Future<void> _onSubmitQuiz() async {
    _calculateScore(widget.quiz.questions);
    debugPrint("Quiz submitted. Score: $_score");
    _stopQuizTimer();
    await _saveElapsedTime();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizCompletedPage(),
      ),
    );
  }

  /// Calculates the score based on user answers and correct answers.
  void _calculateScore(List<QuizQuestion> questions) {
    int score = 0;
    for (int i = 0; i < questions.length; i++) {
      final correctAnswer = questions[i].correctOption.toString();
      final userAnswer = _userAnswers[i]?.toString();

      if (userAnswer != null && userAnswer == correctAnswer) {
        score++;
      }

      // Update provider score
      Provider.of<QuizProvider>(context, listen: false).updateScore(score);
      debugPrint("Calculated score: $score");
    }

    setState(() {
      _score = score;
    });
    debugPrint("Calculated score: $_score");
  }

  /// Shows a confirmation dialog before submitting the quiz.
  void _showSubmitDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.green,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Submit Quiz',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'You have completed the quiz. Would you like to submit your results?',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      debugPrint("User confirmed submission.");
                      _onSubmitQuiz();
                    },
                    child: const Text(
                      'SUBMIT',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final quiz = widget.quiz;

    if (quiz.questions.isEmpty) {
      // Handle the case where the quiz has no questions.
      debugPrint("No questions available for this quiz.");
      return Scaffold(
        appBar: AppBar(title: const Text("Quiz Not Found")),
        body:
            const Center(child: Text("No questions available for this quiz.")),
      );
    }

    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Center(
          child: Text(
            quiz.title,
            textAlign: TextAlign.center,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            elevation: 5,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        formattedTotalQuizTime,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: quiz.questions.asMap().entries.map((entry) {
                          final index = entry.key;
                          final question = entry.value;

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: VedicText(
                              questionText: question.question,
                              onAnswerChanged: (answer) {
                                setState(() {
                                  _userAnswers[index] =
                                      num.tryParse(answer) ?? 0;
                                });
                                debugPrint(
                                    "Answer updated for question $index: $answer");
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _showSubmitDialog,
                      child: const Text("Submit"),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Cancel the timer when the page is disposed.
    totalTimer.cancel();
    quizTimer?.cancel();
    debugPrint("Timer disposed.");
    super.dispose();
  }
}
