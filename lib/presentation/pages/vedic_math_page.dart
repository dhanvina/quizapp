import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/presentation/pages/quiz_completed_page.dart';
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
  final Map<int, num> _userAnswers = {};
  int _score = 0;
  late Timer totalTimer;
  late int totalQuizTimeInSeconds;

  @override
  void initState() {
    super.initState();
    totalQuizTimeInSeconds = widget.quiz.timeLimit * 60;
    if (widget.quiz.questions.isNotEmpty) {
      _startTotalTimer();
    }
  }

  void _startTotalTimer() {
    totalTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (totalQuizTimeInSeconds > 0) {
        setState(() {
          totalQuizTimeInSeconds--;
        });
      } else {
        totalTimer.cancel();
        _onSubmitQuiz();
      }
    });
  }

  String get formattedTotalQuizTime {
    final minutes = (totalQuizTimeInSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalQuizTimeInSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void _onSubmitQuiz() {
    _calculateScore(widget.quiz.questions);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizCompletedPage(),
      ),
    );
  }

  void _calculateScore(List<QuizQuestion> questions) {
    int score = 0;
    for (int i = 0; i < questions.length; i++) {
      final correctAnswer = questions[i].correctOption.toString();
      final userAnswer = _userAnswers[i]?.toString();
      if (userAnswer != null && userAnswer == correctAnswer) {
        score++;
      }
    }
    // Update provider once with the final score
    Provider.of<QuizProvider>(context, listen: false).updateScore(score);
    setState(() {
      _score = score;
    });
    debugPrint("Final calculated score: $_score");
  }

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
      return Scaffold(
        appBar: AppBar(title: const Text("Quiz Not Found")),
        body: const Center(child: Text("No questions available for this quiz.")),
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
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: quiz.questions.length,
                itemBuilder: (context, index) {
                  final question = quiz.questions[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: VedicText(
                      questionText: question.question,
                      onAnswerChanged: (answer) {
                        setState(() {
                          _userAnswers[index] = num.tryParse(answer) ?? 0;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: _showSubmitDialog,
        child: const Text("Submit"),
      ),
    );
  }

  @override
  void dispose() {
    totalTimer.cancel();
    super.dispose();
  }
}
