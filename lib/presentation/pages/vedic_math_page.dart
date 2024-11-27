import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/domain/entities/question.dart';
import 'package:quizapp/presentation/pages/quiz_completed_page.dart';
import 'package:quizapp/presentation/pages/send_data_to_sheets.dart';
import 'package:quizapp/presentation/state_management/question_provider.dart';

import '../widgets/vedic_text.dart';

class VedicMathPage extends StatefulWidget {
  final int quizTimeInMinutes;
  final String title;

  const VedicMathPage({
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
    _startTotalTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<QuestionProvider>(context, listen: false).loadPapers(context);
    });
  }

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

  String get formattedTotalQuizTime {
    final minutes = (totalQuizTimeInSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalQuizTimeInSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void _onSubmitQuiz() async {
    // Call the sendIDToSheet function before navigation
    await GoogleSheetsAPI.sendIDToSheet(); // This will send the ID to the sheet

    // Debug: Print a statement after sending data
    print("Data sent to Google Sheets");
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
              const Center(
                child: Text(
                  'Submit Quiz',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),
              const Center(
                child: Text(
                  'You have completed the quiz. Would you like to submit your results?',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),
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
    final questionProvider = Provider.of<QuestionProvider>(context);

    final filteredPapers = questionProvider.papers
        .where((paper) => paper.paper_type == "vedic")
        .toList();

    final selectedPaper = filteredPapers.firstWhere(
      (paper) => paper.title == widget.title,
      orElse: () => throw Exception('Paper not found'),
    );

    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Center(
          child: Text(widget.title, textAlign: TextAlign.center),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        '$formattedTotalQuizTime',
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              selectedPaper.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Text(
                            'Time: ${selectedPaper.time} minutes',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: selectedPaper.questions.length,
                        itemBuilder: (context, index) {
                          final question = selectedPaper.questions[index];
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: VedicText(
                              questionText: question.question,
                              onAnswerChanged: (answer) {
                                setState(() {
                                  _userAnswers[index] =
                                      num.tryParse(answer) ?? 0;
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: ElevatedButton(
                        onPressed: () {
                          _calculateScore(selectedPaper.questions);
                          _showSubmitDialog();
                        },
                        child: const Text("Submit"),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    )
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
    totalTimer.cancel();
    super.dispose();
  }
}
