import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/presentation/pages/quiz_completed_page.dart';
import 'package:quizapp/presentation/widgets/app_bar_widget.dart';
import 'package:quizapp/presentation/widgets/background.dart';
import 'package:quizapp/presentation/widgets/timer_widget_sec.dart';
import 'package:quizapp/utils/constants.dart';

import '../state_management/question_provider.dart';
import '../widgets/option_buttons.dart';
import '../widgets/question_indicator.dart';
import '../widgets/question_text.dart';
import '../widgets/submit_button.dart';

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

  // Add variables for the total quiz timer
  late int totalQuizTimeInSeconds;
  late Timer totalTimer;

  @override
  void initState() {
    super.initState();
    questionProvider = Provider.of<QuestionProvider>(context, listen: false);
    timePerQuestion =
        (widget.quizTimeInMinutes * 60) ~/ questionProvider.totalQuestions;
    // Initialize total quiz timer
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
          _onSubmitQuiz(); // End quiz when time runs out
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
    // Use MediaQuery to get screen dimensions for responsiveness
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
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
              // Timer widget on the top right
              Positioned(
                top: 0,
                right: 16.0, // Add some padding from the right edge
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0), // Add padding inside the container
                  decoration: BoxDecoration(
                    color: Colors.white, // Set background color to white
                    borderRadius: BorderRadius.circular(
                        8.0), // Optional: add rounded corners
                  ),
                  child: Text(
                    'Total Duration-$formattedTotalQuizTime',
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
                      // Set width and height relative to screen size for responsiveness
                      width: screenWidth * 0.6,
                      constraints: BoxConstraints(
                        maxHeight: screenHeight *
                            0.8, // Use a max height for flexibility
                      ),
                      padding: EdgeInsets.all(screenWidth * 0.02),
                      decoration: BoxDecoration(
                        color: Constants.limeGreen.withOpacity(1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Question Number',
                                style: TextStyle(
                                  fontSize:
                                      24, // Adjust the font size as needed
                                  fontWeight: FontWeight.bold, // Make it bold
                                  fontFamily: 'Poppins', // Use Poppins font
                                ),
                              ),
                              TimerWidgetSec(
                                key: ValueKey(
                                    questionProvider.currentQuestionIndex),
                                quizTimeInSeconds: timePerQuestion,
                                onTimerEnd: _moveToNextQuestion,
                              ),
                            ],
                          ),
                          QuestionIndicator(
                            currentIndex: questionProvider.currentQuestionIndex,
                            totalQuestions: questionProvider.totalQuestions,
                          ),
                          Container(
                              width: screenWidth * 0.3,
                              height: screenHeight * 0.3,
                              padding: const EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                color: Constants.offWhite.withOpacity(1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: QuestionText(question: question.question)),
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
                          if (_isLastQuestionAnswered)
                            SubmitButton(onPressed: _onSubmitQuiz),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleAnswer(QuestionProvider questionProvider) {
    if (questionProvider.isLastQuestion) {
      setState(() {
        _isLastQuestionAnswered = true;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuizCompletedPage(),
        ),
      );
    } else {
      setState(() {
        selectedOption = null;
      });
      questionProvider.resetSelectedOption();
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

  void _onTimerEnd() {
    _onSubmitQuiz();
  }

  void _moveToNextQuestion() {
    if (!questionProvider.isLastQuestion) {
      questionProvider.nextQuestion();
      setState(() {
        selectedOption = null;
      });
    } else {
      _onSubmitQuiz();
    }
  }
}
