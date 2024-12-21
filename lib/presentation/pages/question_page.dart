import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/presentation/pages/quiz_completed_page.dart';
import 'package:quizapp/presentation/widgets/background.dart';
import 'package:quizapp/presentation/widgets/falling_overlay.dart';
import 'package:quizapp/presentation/widgets/timer_widget_sec.dart';
import 'package:quizapp/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/firestore_quiz.dart';
import '../state_management/quiz_provider.dart';
import '../widgets/option_buttons.dart';
import '../widgets/question_indicator.dart';
import '../widgets/question_text.dart';

class QuestionPage extends StatefulWidget {
  final Quiz quiz;

  const QuestionPage({Key? key, required this.quiz}) : super(key: key);

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  late QuizProvider questionProvider;
  late int timePerQuestion;
  late int totalQuizTimeInSeconds;
  Timer? totalTimer;
  Timer? quizTimer;

  Duration elapsedQuizTime = Duration.zero; // Track elapsed time

  bool _isLastQuestionAnswered = false;
  bool _isMovingToNextQuestion = false;
  int? selectedOption;

  final TextEditingController _answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    log('Initializing QuestionPage...');
    questionProvider = Provider.of<QuizProvider>(context, listen: false);
    timePerQuestion = widget.quiz.timeLimit;
    totalQuizTimeInSeconds = timePerQuestion * widget.quiz.questions.length;

    if (widget.quiz.questions.isNotEmpty) {
      _startTotalTimer();
      _startQuizTimer();
    }
  }

  void _startTotalTimer() {
    totalTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (totalQuizTimeInSeconds > 0) {
          totalQuizTimeInSeconds--;
        } else {
          totalTimer?.cancel();
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

  @override
  void dispose() {
    log('Disposing QuestionPage...');
    totalTimer?.cancel();
    quizTimer?.cancel();
    _answerController.dispose();
    super.dispose();
  }

  String get formattedTotalQuizTime {
    final minutes = (totalQuizTimeInSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalQuizTimeInSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    log('Building QuestionPage UI...');
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(
            children: [
              FarmBackgroundWidget(),
              Consumer<QuizProvider>(
                builder: (context, questionProvider, _) {
                  if (widget.quiz.questions.isEmpty) {
                    log('[Loading] Questions not available yet...');
                    return const Center(child: CircularProgressIndicator());
                  }

                  final question = questionProvider.currentQuestion;

                  return Center(
                    child: Container(
                      width: screenWidth * 0.8,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Constants.limeGreen.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Question Number',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TimerWidgetSec(
                                key: ValueKey(
                                    questionProvider.currentQuestionIndex),
                                quizTimeInSeconds: timePerQuestion,
                                onTimerEnd: () {
                                  log('[Timer] Time up for the current question.');
                                  showOverlayTransitionMessage(context,
                                      "Time's up! Moving to Next Question");
                                  _moveToNextQuestion();
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          QuestionIndicator(
                            currentIndex: questionProvider.currentQuestionIndex,
                            totalQuestions: questionProvider.totalQuestions,
                          ),
                          const SizedBox(height: 10.0),
                          QuestionText(
                            questions: widget.quiz.questions,
                            currentIndex: questionProvider.currentQuestionIndex,
                          ),
                          const SizedBox(height: 10.0),
                          OptionButtons(
                            questionProvider: questionProvider,
                            question: question,
                            onOptionSelected: (option) {
                              setState(() {
                                selectedOption = option;
                              });
                              log('[Answer] Option selected: $option');
                              questionProvider
                                  .checkAnswer(double.parse(option.toString()));
                              _handleAnswer(questionProvider);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  void _handleAnswer(QuizProvider questionProvider) {
    if (questionProvider.isLastQuestion) {
      log('[Quiz] Last question answered.');
      setState(() {
        _isLastQuestionAnswered = true;
      });
      _showSubmitDialog();
    } else {
      setState(() {
        _isMovingToNextQuestion = true;
        selectedOption = null;
      });
      questionProvider.resetSelectedOption();
      log('[Quiz] Moving to the next question...');
      showOverlayTransitionMessage(context, "Moving to Next Question");
      _moveToNextQuestion();
    }
  }

  void _moveToNextQuestion() {
    if (questionProvider.isLastQuestion) {
      log('[Quiz] Submitting the quiz...');
      _onSubmitQuiz();
    } else {
      questionProvider.nextQuestion();
      log('[Quiz] Next question displayed.');
    }

    setState(() {
      _isMovingToNextQuestion = false;
    });
  }

  Future<void> _onSubmitQuiz() async {
    log('[Quiz] Navigating to the QuizCompletedPage...');
    _stopQuizTimer();
    await _saveElapsedTime();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuizCompletedPage()),
    );
  }

  void _showSubmitDialog() {
    log('[Dialog] Displaying quiz submission dialog.');
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
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const SizedBox(height: 24),
              const Text(
                'You have completed the quiz. Would you like to submit your results?',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _onSubmitQuiz();
                },
                child: const Text('SUBMIT'),
              ),
            ],
          ),
        );
      },
    );
  }

  void showOverlayTransitionMessage(BuildContext context, String message) {
    log('[Overlay] Showing message: $message');
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => FallingOverlay(message: message),
    );
    overlay.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 3), overlayEntry.remove);
  }
}