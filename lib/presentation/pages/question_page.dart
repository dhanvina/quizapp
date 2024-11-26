import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/presentation/pages/quiz_completed_page.dart';
import 'package:quizapp/presentation/widgets/background.dart';
import 'package:quizapp/presentation/widgets/falling_overlay.dart';
import 'package:quizapp/presentation/widgets/timer_widget_sec.dart';
import 'package:quizapp/utils/constants.dart';

import '../state_management/question_provider.dart';
import '../widgets/option_buttons.dart';
import '../widgets/question_indicator.dart';
import '../widgets/question_text.dart';

class QuestionPage extends StatefulWidget {
  final String quizTimeInMinutes;

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
  bool _isMovingToNextQuestion = false;
  TextEditingController _answerController = TextEditingController();
  double? userAnswer;

  @override
  void initState() {
    super.initState();
    questionProvider = Provider.of<QuestionProvider>(context, listen: false);
    timePerQuestion =
        // (widget.quizTimeInMinutes * 60) ~/ questionProvider.totalQuestions;
        totalQuizTimeInSeconds = (widget.quizTimeInMinutes * 60) as int;
    startTotalTimer();
  }

  @override
  void dispose() {
    totalTimer.cancel();
    _answerController.dispose();
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
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
                            if (question.type == "multiple_choice")
                              OptionButtons(
                                questionProvider: questionProvider,
                                question: question,
                                onOptionSelected: (option) {
                                  setState(() {
                                    selectedOption = option;
                                  });
                                  questionProvider.checkAnswer(
                                      double.parse(option.toString()));

                                  _handleAnswer(questionProvider);
                                },
                              )
                            else if (question.type == "fill")
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: _answerController,
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true, signed: false),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'^\d*\.?\d*$')),
                                        LengthLimitingTextInputFormatter(10),
                                      ],
                                      decoration: InputDecoration(
                                        hintText: "Enter your answer",
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: () {
                                        String cleanedInput =
                                            _answerController.text.trim();
                                        double userAnswer = double.parse(
                                            cleanedInput); // Try to parse as double
                                        print(
                                            'Cleaned input: ${userAnswer.runtimeType}');

                                        if (_answerController.text.isNotEmpty) {
                                          final userAnswer = double.parse(
                                              _answerController.text.trim());
                                          if (userAnswer != null) {
                                            questionProvider
                                                .checkAnswer(userAnswer);
                                            _handleAnswer(questionProvider);
                                          } else {
                                            showOverlayTransitionMessage(
                                                context,
                                                "Please enter a valid numeric answer.");
                                          }
                                        } else {
                                          showOverlayTransitionMessage(context,
                                              "Please enter an answer.");
                                        }
                                        _answerController.clear();
                                      },
                                      child: Text("Next"),
                                    ),
                                  ],
                                ),
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
                  }),
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
      _showSubmitDialog();
    } else if (!_isMovingToNextQuestion) {
      setState(() {
        _isMovingToNextQuestion = true;
      });
      setState(() {
        selectedOption = null;
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
      _onSubmitQuiz();
    } else {
      questionProvider.nextQuestion();
    }

    setState(() {
      _isMovingToNextQuestion = false;
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

  void showOverlayTransitionMessage(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => FallingOverlay(message: message),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}
