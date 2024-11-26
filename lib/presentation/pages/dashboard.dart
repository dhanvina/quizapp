import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/presentation/pages/quiz_preview.dart';
import 'package:quizapp/utils/constants.dart';

import '../state_management/question_provider.dart';
import '../state_management/quiz_provider.dart';
import 'LiveQuizPreview.dart';

class PaperSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final questionProvider =
        Provider.of<QuestionProvider>(context, listen: false);
    questionProvider.loadPapers(context);
    questionProvider.loadUserName();

    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    quizProvider.getQuizzes();

    return Scaffold(
      backgroundColor: Constants.limeGreen,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<QuestionProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.papers.isEmpty) {
              return const Center(
                child: Text(
                  "No quizzes available at the moment.",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              );
            }

            final studentName = provider.userName;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with greeting and profile icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "GOOD MORNING, $studentName",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 4),
                        ],
                      ),
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, color: Constants.green),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Quizzes Container
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: Constants.offWhite,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Practice Quizzes Section
                          const Text(
                            "Practice Quizzes",
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              color: Constants.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ...provider.papers.map((paper) {
                            return QuizTile(
                              title: paper.title,
                              subtitle: "${paper.time} Minutes - Level: Easy",
                              buttonText: "TRY",
                              onPressed: () {
                                provider.selectPaper(
                                    provider.papers.indexOf(paper));
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => QuizPreview(
                                      title: paper.title,
                                      time: paper.time,
                                      numberOfQuestions: paper.questions.length,
                                      paper_type: '',
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),

                          const SizedBox(height: 30),

                          // Live Quizzes Section
                          if (quizProvider.liveQuizzes.isNotEmpty) ...[
                            const Text(
                              "Live Quizzes",
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                color: Constants.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 20),
                            ...quizProvider.liveQuizzes.map((quiz) {
                              return QuizTile(
                                title: quiz.title,
                                subtitle: "${quiz.timeLimit} Minutes",
                                buttonText: "JOIN",
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LiveQuizPreview(
                                        title: quiz.title,
                                        time: quiz.timeLimit,
                                        paper_type: quiz.paperType,
                                        numberOfQuestions:
                                            quiz.questions.length,
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ] else ...[
                            const Text(
                              "No live quizzes available.",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// Widget for individual quiz tile
class QuizTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback onPressed;

  const QuizTile({
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.menu_book, color: Constants.green, size: 40),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Constants.green,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              buttonText,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
