import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/presentation/pages/quiz_preview.dart';
import 'package:quizapp/utils/constants.dart';

import '../state_management/quiz_provider.dart';
import '../widgets/quiz_section.dart';

class PaperSelectionPage extends StatefulWidget {
  @override
  _PaperSelectionPageState createState() => _PaperSelectionPageState();
}

class _PaperSelectionPageState extends State<PaperSelectionPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<QuizProvider>(context, listen: false).fetchQuizzes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);

    final liveQuizzes =
        quizProvider.quizzes.where((quiz) => quiz.paper == 'live').toList();
    final practiceQuizzes =
        quizProvider.quizzes.where((quiz) => quiz.paper == 'practice').toList();

    return Scaffold(
      backgroundColor: Constants.limeGreen,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: quizProvider.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : quizProvider.quizzes.isEmpty
                ? const Center(
                    child: Text(
                      "No quizzes available.",
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  )
                : ListView(
                    children: [
                      if (liveQuizzes.isNotEmpty)
                        QuizSection(
                          title: "Live Papers",
                          quizzes: liveQuizzes,
                          onPressed: (quiz) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QuizPreview(
                                  title: quiz.title,
                                  time: quiz.timeLimit,
                                  paper_type: quiz.paperType,
                                  numberOfQuestions: quiz.questionCount,
                                ),
                              ),
                            );
                          },
                        ),
                      if (practiceQuizzes.isNotEmpty)
                        QuizSection(
                          title: "Practice Papers",
                          quizzes: practiceQuizzes,
                          onPressed: (quiz) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QuizPreview(
                                  title: quiz.title,
                                  time: quiz.timeLimit,
                                  paper_type: quiz.paperType,
                                  numberOfQuestions: quiz.questionCount,
                                ),
                              ),
                            );
                          },
                        ),
                    ],
                  ),
      ),
    );
  }
}
