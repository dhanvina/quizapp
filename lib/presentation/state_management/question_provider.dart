// providers/question_provider.dart
import 'package:flutter/material.dart';

import '../../data/models/question_model.dart';
import '../../domain/entities/question.dart';
import '../../domain/repository/question_repository_interface.dart';

class QuestionProvider extends ChangeNotifier {
  final QuestionRepositoryInterface repository;
  List<QuestionPaper> _papers = [];
  int currentQuestionIndex = 0;
  int selectedPaperIndex = 0;
  int score = 0;
  String paperTitle = "";
  int paperTime = 0;
  int? selectedOption;

  QuestionProvider({required this.repository});

  List<QuestionPaper> get papers => _papers;

  Future<void> loadPapers(BuildContext context) async {
    // Assuming repository.getQuestionPapers() returns List<QuestionPaperModel>
    final fetchedPapers = await repository.getQuestionPapers();
    _papers = _convertToQuestionPapers(fetchedPapers);

    if (_papers.isNotEmpty) {
      paperTitle = _papers[0].title;
      paperTime = _papers[0].time;
    }
    notifyListeners();
  }

  Question get currentQuestion {
    return papers[selectedPaperIndex].questions[currentQuestionIndex];
  }

  void checkAnswer(int selectedAnswer) {
    if (selectedAnswer == currentQuestion.answer) {
      score++; // Increment score if the answer is correct
    }
    nextQuestion();
    notifyListeners();
  }

  int get totalScore => score;

  void selectOption(int option) {
    selectedOption = option;
    notifyListeners();
  }

  void resetSelectedOption() {
    selectedOption = null;
    notifyListeners();
  }

  void nextQuestion() {
    if (currentQuestionIndex < totalQuestions - 1) {
      currentQuestionIndex++;
      notifyListeners();
    } else {
      notifyListeners();
    }
  }

  int get totalQuestions {
    return papers.isNotEmpty
        ? papers[selectedPaperIndex].questions.length
        : 0; // Return 0 if there are no papers loaded
  }

  void selectPaper(int index) {
    selectedPaperIndex = index;
    currentQuestionIndex = 0;
    score = 0;
    notifyListeners();
  }

  bool get isLastQuestion =>
      currentQuestionIndex == papers[selectedPaperIndex].questions.length - 1;

  List<QuestionPaper> _convertToQuestionPapers(
      List<QuestionPaperModel> questionPaperModels) {
    return questionPaperModels.map((qpm) {
      return QuestionPaper(
        title: qpm.title, // Get title from QuestionPaperModel
        time: qpm.time, // Get time from QuestionPaperModel
        questions: qpm.questions
            .map((qm) => qm.toEntity())
            .toList(), // Convert QuestionModel to Question
      );
    }).toList();
  }
}
