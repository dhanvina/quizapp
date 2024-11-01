import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/presentation/pages/quiz_completed_page.dart';
import 'package:quizapp/presentation/widgets/app_bar_widget.dart';
import 'package:quizapp/presentation/widgets/background.dart';
import 'package:quizapp/utils/constants.dart';

import '../state_management/question_provider.dart';
import '../widgets/option_buttons.dart';
import '../widgets/question_indicator.dart';
import '../widgets/question_text.dart';
import '../widgets/submit_button.dart';
import '../widgets/timer_widget.dart';

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

  @override
  void initState() {
    super.initState();
    questionProvider = Provider.of<QuestionProvider>(context, listen: false);
    timePerQuestion =
        (widget.quizTimeInMinutes * 60) ~/ questionProvider.totalQuestions;
  }

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get screen dimensions for responsiveness
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          const FarmBackgroundWidget(),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBarWidget(), // Place AppBarWidget outside the container
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
                  height: screenHeight * 0.85,
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Constants.limeGreen.withOpacity(1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TimerWidget(
                        key: ValueKey(questionProvider.currentQuestionIndex),
                        quizTimeInSeconds: timePerQuestion,
                        onTimerEnd: _moveToNextQuestion,
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
