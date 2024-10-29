import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/presentation/pages/quiz_completed_page.dart';

import '../state_management/question_provider.dart';
import '../widgets/app_bar_widget.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFA2D12C),
      body: Consumer<QuestionProvider>(
        builder: (context, questionProvider, _) {
          if (questionProvider.papers.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          final question = questionProvider.currentQuestion;

          return Column(
            children: [
              AppBarWidget(),
              QuestionIndicator(
                currentIndex: questionProvider.currentQuestionIndex,
                totalQuestions: questionProvider.totalQuestions,
              ),
              TimerWidget(
                quizTimeInMinutes: widget.quizTimeInMinutes,
                onTimerEnd: _onTimerEnd, // Pass in the timer end callback
              ),
              QuestionText(question: question.question),
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
                // SubmitButton(onPressed: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => QuizCompletedPage(),
                //     ),
                //   );
                // }),
                SubmitButton(onPressed: _onSubmitQuiz),
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
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuizCompletedPage(),
        ),
      );
    } else {
      // questionProvider.nextQuestion();
      setState(() {
        selectedOption = null; // Reset selectedOption for the next question
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
    // Automatically navigate to QuizCompletedPage when time runs out
    _onSubmitQuiz();
  }
}
