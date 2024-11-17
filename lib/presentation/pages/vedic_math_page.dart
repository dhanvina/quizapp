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
      final correctAnswer = questions[i].answer;
      final userAnswer = _userAnswers[i];
      if (userAnswer != null && userAnswer == correctAnswer) {
        score++;
      }
    }
    setState(() {
      _score = score;
    });
  }

  @override
  Widget build(BuildContext context) {
    final questionProvider = Provider.of<QuestionProvider>(context);

    // First filter by paper_type "vedic"
    final filteredPapers = questionProvider.papers
        .where((paper) => paper.paper_type == "vedic")
        .toList();

    // Now filter further by the title passed through widget.title
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
                                _userAnswers[index] = num.tryParse(answer) ?? 0;
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
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Score"),
                              content: Text(
                                "Your score: $_score / ${selectedPaper.questions.length}",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text("OK"),
                                ),
                              ],
                            ),
                          );
                        },
                        child: const Text("Submit"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
