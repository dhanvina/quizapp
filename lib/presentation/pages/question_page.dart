import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/presentation/pages/quiz_completed_page.dart';
import 'package:quizapp/presentation/widgets/app_bar_widget.dart';
import 'package:quizapp/presentation/widgets/background.dart';
import 'package:quizapp/presentation/widgets/falling_overlay.dart';
import 'package:quizapp/presentation/widgets/timer_widget_sec.dart';
import 'package:quizapp/utils/constants.dart';

import '../state_management/question_provider.dart';
import '../widgets/option_buttons.dart';
import '../widgets/question_indicator.dart';
import '../widgets/question_text.dart';

class QuestionPage extends StatefulWidget {
  final int quizTimeInMinutes;

  const QuestionPage({Key? key, required this.quizTimeInMinutes})
      : super(key: key);

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  bool _isLastQuestionAnswered = false;
  int? selectedOption;
  late int timePerQuestion;
  late QuestionProvider questionProvider;
  late int totalQuizTimeInSeconds;
  late Timer totalTimer;
  bool _isMovingToNextQuestion =
      false; // Flag to prevent multiple next question calls

  @override
  void initState() {
    super.initState();
    questionProvider = Provider.of<QuestionProvider>(context, listen: false);
    timePerQuestion =
        (widget.quizTimeInMinutes * 60) ~/ questionProvider.totalQuestions;
    totalQuizTimeInSeconds = widget.quizTimeInMinutes * 60;
    startTotalTimer();
  }

  @override
  void dispose() {
    totalTimer.cancel();
    super.dispose();
  }

  void startTotalTimer() {
    totalTimer = Timer.periodic(Duration(seconds: 1), (timer) {
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(
            children: [
              FarmBackgroundWidget(),
              Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: AppBarWidget(),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 16.0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        'Total Duration - $formattedTotalQuizTime',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                  Consumer<QuestionProvider>(
                    builder: (context, questionProvider, _) {
                      if (questionProvider.papers.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final question = questionProvider.currentQuestion;

                      return Center(
                        child: Container(
                          width: screenWidth * 0.35,
                          constraints:
                              BoxConstraints(maxHeight: screenHeight * 0.90),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Constants.limeGreen.withOpacity(1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Question Number',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                  TimerWidgetSec(
                                    key: ValueKey(
                                        questionProvider.currentQuestionIndex),
                                    quizTimeInSeconds: timePerQuestion,
                                    onTimerEnd: () {
                                      showOverlayTransitionMessage(context,
                                          "Time's up! Moving to Next Question");
                                      _moveToNextQuestion();
                                    },
                                  ),
                                ],
                              ),
                              QuestionIndicator(
                                currentIndex:
                                    questionProvider.currentQuestionIndex,
                                totalQuestions: questionProvider.totalQuestions,
                              ),
                              SizedBox(height: 10.0),
                              AnimatedSwitcher(
                                duration: Duration(milliseconds: 900),
                                transitionBuilder: (Widget child,
                                    Animation<double> animation) {
                                  return FadeTransition(
                                      opacity: animation, child: child);
                                },
                                child: Container(
                                  key: ValueKey(
                                      questionProvider.currentQuestionIndex),
                                  width: screenWidth * 0.3,
                                  height: screenHeight * 0.3,
                                  padding: const EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
                                    color: Constants.offWhite.withOpacity(1),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child:
                                      QuestionText(question: question.question),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              OptionButtons(
                                questionProvider: questionProvider,
                                question: question,
                                onOptionSelected: (option) {
                                  setState(() {
                                    selectedOption = option;
                                  });
                                  questionProvider.checkAnswer(option);
                                  _handleAnswer(questionProvider);
                                },
                              ),
                              Container(
                                width: 150,
                                height: 120,
                                child: Image.asset(
                                  'assets/quiz_app_abacus.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              if (_isLastQuestionAnswered)
                                SizedBox.shrink(), // Empty space for now
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  void _handleAnswer(QuestionProvider questionProvider) {
    if (questionProvider.isLastQuestion) {
      setState(() {
        _isLastQuestionAnswered = true;
      });
      _showSubmitDialog(); // Show the submit confirmation dialog
    } else if (!_isMovingToNextQuestion) {
      // Prevent multiple next question calls
      setState(() {
        _isMovingToNextQuestion = true;
      });
      setState(() {
        selectedOption = null; // Reset selected option for the new question
      });
      questionProvider.resetSelectedOption();
      showOverlayTransitionMessage(context, "Moving to Next Question");
      _moveToNextQuestion();
    }
  }

  void _onSubmitQuiz() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizCompletedPage(),
      ),
    );
  }

  void _moveToNextQuestion() {
    if (questionProvider.isLastQuestion) {
      _onSubmitQuiz(); // Submit quiz if it's the last question
    } else {
      questionProvider.nextQuestion(); // Move to the next question in the list
    }

    // Reset flag after question moves
    setState(() {
      _isMovingToNextQuestion = false;
    });
  }

  void _showSubmitDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Submit Quiz'),
          content: Text('Are you sure you want to submit your quiz?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                _onSubmitQuiz(); // Submit the quiz
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}

void showOverlayTransitionMessage(BuildContext context, String message) {
  final overlay = OverlayEntry(
    builder: (context) {
      return FallingOverlay(message: message);
    },
  );

  Overlay.of(context)?.insert(overlay);

  Future.delayed(Duration(seconds: 2), () {
    overlay.remove();
  });
}
