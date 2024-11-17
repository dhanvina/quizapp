import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/domain/entities/question.dart';
import 'package:quizapp/presentation/pages/quiz_completed_page.dart';
import 'package:quizapp/presentation/state_management/question_provider.dart';

import '../widgets/vedic_text.dart';

class VedicMathPage extends StatefulWidget {
  final int quizTimeInMinutes;
  final String title;

  VedicMathPage({
    required this.quizTimeInMinutes,
    required this.title,
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
    totalQuizTimeInSeconds = widget.quizTimeInMinutes * 60;
    startTotalTimer();
    Provider.of<QuestionProvider>(context, listen: false).loadPapers(context);
  }

  void startTotalTimer() {
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

  void _onSubmitQuiz() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizCompletedPage(),
      ),
    );
  }

  void _calculateScore(List<Question> questions) {
    int score = 0;
    for (int i = 0; i < questions.length; i++) {
      final correctAnswer = questions[i].answer?.toString();
      final userAnswer = _userAnswers[i]?.toString();

      if (correctAnswer != null &&
          userAnswer != null &&
          userAnswer == correctAnswer) {
        score++;
      }
    }

    // Update score in QuestionProvider
    Provider.of<QuestionProvider>(context, listen: false).updateScore(score);

    setState(() {
      _score = score;
    });
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
              Text(
                'Submit Quiz',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              Text(
                'You have completed the quiz. Would you like to submit your results?',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                      _onSubmitQuiz();
                    },
                    child: Text(
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
    final questionProvider = Provider.of<QuestionProvider>(context);

    // Filter papers to show only those with paper_type "vedic"
    final filteredPapers = questionProvider.papers
        .where((paper) => paper.paper_type == "vedic")
        .toList();

    // Filter further by the title passed through widget.title
    final selectedPaper =
        filteredPapers.firstWhere((paper) => paper.title == widget.title);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: selectedPaper == null
          ? const Center(child: Text("Paper not found"))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 5,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(selectedPaper.title),
                        subtitle: Text('Time: ${selectedPaper.time} minutes'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: selectedPaper.questions.length,
                          itemBuilder: (context, index) {
                            final question = selectedPaper.questions[index];
                            return VedicText(
                              questionText: question.question,
                              onAnswerChanged: (answer) {
                                setState(() {
                                  _userAnswers[index] =
                                      num.tryParse(answer) ?? 0;
                                });
                              },
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            _calculateScore(selectedPaper.questions);
                            _showSubmitDialog(); // Show the dialog
                          },
                          child: const Text("Submit"),
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
