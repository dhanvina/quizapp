import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/firestore_quiz.dart';
import '../../domain/entities/quiz_result.dart';
import '../../domain/repository/firestore_quiz_repository.dart';
import '../../domain/use_cases/firestore_fetch_quiz.dart';
import '../../domain/use_cases/update_quiz_results_use_case.dart';

// Logger instance
final Logger logger = Logger();

/// A provider class for managing quizzes, handling state, and notifying listeners of changes.
class QuizProvider extends ChangeNotifier {
  final QuizRepository quizRepository;
  List<Quiz> papers = [];

  final GetQuizzesUseCase getQuizzesUseCase;
  final UpdateQuizResultsUseCase updateQuizResultsUseCase;

  bool isLoading = false;
  List<Quiz> quizzes = [];
  int currentQuestionIndex = 0;
  int selectedPaperIndex = 0;
  int score = 0;
  String paperTitle = "";
  int paperTime = 0;
  int? selectedOption;
  String _userName = "Guest";
  String get userName => _userName;

  QuizProvider({
    required this.quizRepository,
    required this.getQuizzesUseCase,
    required this.updateQuizResultsUseCase,
  });

  /// Fetches quizzes from the repository and updates the provider's state.
  Future<void> fetchQuizzes() async {
    logger.i('Fetching quizzes started.');
    isLoading = true;
    notifyListeners();

    try {
      quizzes = await getQuizzesUseCase.execute();
      logger
          .i('Quizzes fetched successfully: ${quizzes.length} quizzes loaded.');
    } catch (e) {
      logger.e('Error occurred while fetching quizzes: $e');
      quizzes = [];
    }

    isLoading = false;
    notifyListeners();
    logger.i('Fetching quizzes completed.');
  }

  /// Loads the user's name from shared preferences.
  Future<void> loadUserName() async {
    logger.i('Loading username from SharedPreferences.');
    final prefs = await SharedPreferences.getInstance();
    final loggedInStudent = prefs.getString('loggedInStudent');
    if (loggedInStudent != null) {
      _userName = jsonDecode(loggedInStudent)['name'];
    } else {
      _userName = "Guest";
    }
    notifyListeners();
    logger.i('Username loaded: $_userName');
  }

  /// Gets the current question from the selected quiz.
  QuizQuestion get currentQuestion {
    if (quizzes.isNotEmpty) {
      return quizzes[selectedPaperIndex].questions[currentQuestionIndex];
    }
    throw Exception("No quizzes or questions available.");
  }

  /// Checks the selected answer against the correct answer.
  void checkAnswer(double selectedAnswer) {
    try {
      double correctAnswer = currentQuestion.correctOption;
      if (selectedAnswer == correctAnswer) {
        score++;
        logger.i('Answer correct! Score incremented to $score.');
      } else {
        logger.i('Answer incorrect.');
      }
    } catch (e) {
      logger.e("Error parsing answer: $e");
    }
    notifyListeners();
  }

  void selectOption(int option) {
    selectedOption = option;
    notifyListeners();
    logger.i('Selected option updated: $selectedOption');
  }

  void resetSelectedOption() {
    selectedOption = null;
    notifyListeners();
    logger.i('Selected option reset.');
  }

  void updateScore(int newScore) {
    score = newScore;
    notifyListeners();
    logger.i('Score updated to: $score.');
  }

  Future<void> saveScore() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('quizScore', score);
    logger.i('Score saved to SharedPreferences: $score');
  }

  Future<int?> getScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('quizScore');
  }

  Future<String?> getSavedLiveQuizId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('selectedLiveQuizId');
  }

  void nextQuestion() {
    if (currentQuestionIndex < totalQuestions - 1) {
      currentQuestionIndex++;
      notifyListeners();
      logger.i('Moved to the next question. Index: $currentQuestionIndex.');
    } else {
      logger.i('Last question reached. No more questions to advance.');
    }
  }

  int get totalQuestions {
    return quizzes.isNotEmpty
        ? quizzes[selectedPaperIndex].questions.length
        : 0;
  }

  void selectPaper(int index) {
    selectedPaperIndex = index;
    currentQuestionIndex = 0;
    score = 0;
    notifyListeners();
    logger.i('Selected paper index updated: $selectedPaperIndex.');
  }

  bool get isLastQuestion {
    return currentQuestionIndex ==
        quizzes[selectedPaperIndex].questions.length - 1;
  }

  /// Resets the quiz state including quizId, score, and isLive after submitting results or starting a new quiz.
  Future<void> resetQuiz() async {
    final prefs = await SharedPreferences.getInstance();

    // Reset fields in SharedPreferences
    await prefs.remove('selectedQuizId');
    await prefs.remove('isLive');

    // Reset internal state
    score = 0;
    notifyListeners();

    logger.i('Quiz state has been reset: quizId, score, and isLive cleared.');
  }

  Future<void> updateQuizResults(
      String schoolCode, String rollNumber, bool isLive) async {
    try {
      logger.i('Starting updateQuizResults...');
      final prefs = await SharedPreferences.getInstance();
      final quizId = prefs.getString('selectedQuizId') ?? "unknown_quiz";
      final isLive = prefs.getBool('isLive') ?? false;

      final quizResult = QuizResult(
        quizId: quizId,
        score: score,
        isLive: isLive,
      );

      final result = await updateQuizResultsUseCase.call(
        schoolCode,
        rollNumber,
        quizResult,
      );

      result.fold(
        (failure) {
          logger.e('Failed to update quiz results: $failure');
        },
        (_) async {
          logger.i('Quiz results updated successfully.');
          await resetQuiz();
        },
      );
    } catch (e) {
      logger.e('Error while updating quiz results: $e');
    }
  }
}
