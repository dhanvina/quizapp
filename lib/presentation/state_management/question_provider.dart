// providers/question_provider.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  List<QuestionPaper> _liveQuizzes = [];

  String _userName = "";
  String get userName => _userName;

  bool _isLoading = false; // Track loading state
  bool get isLoading => _isLoading; // Getter to access loading state

  Future<void> loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedInStudent = prefs.getString('loggedInStudent');
    if (loggedInStudent != null) {
      // Assuming the student JSON contains a "name" key
      _userName = jsonDecode(loggedInStudent)['name'];
    } else {
      _userName = "Guest"; // Default value if no user is logged in
    }
    notifyListeners();
  }

  QuestionProvider({required this.repository});

  List<QuestionPaper> get papers => _papers;
  List<QuestionPaper> get liveQuizzes => _liveQuizzes;

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

  void checkAnswer(double selectedAnswer) {
    try {
      double correctAnswer = currentQuestion.answer;
      if (selectedAnswer == correctAnswer) {
        score++; // Increment score if the answer is correct
      }
    } catch (e) {
      // Handle the error if parsing fails
      print("Error parsing answer: $e");
    }
    notifyListeners();
  }

  String get questionType {
    return currentQuestion.type;
  }

  int get totalScore => score;

  void selectOption(int option) {
    selectedOption = option;
    notifyListeners();
  }

  void resetSelectedOption() {
    print('Current Question Index resetSelectedOption');

    selectedOption = null;
    notifyListeners();
  }

  void updateScore(int newScore) {
    score = newScore;
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
        paper_type: qpm.paper_type,
        questions: qpm.questions
            .map((qm) => qm.toEntity())
            .toList(), // Convert QuestionModel to Question
      );
    }).toList();
  }
}
