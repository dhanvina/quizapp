import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/firestore_quiz.dart';
import '../../domain/entities/quiz_result.dart';
import '../../domain/repository/firestore_quiz_repository.dart';
import '../../domain/use_cases/firestore_fetch_quiz.dart';
import '../../domain/use_cases/update_quiz_results_use_case.dart';

// Create a Logger instance
final Logger logger = Logger();

/// A provider class for managing quizzes, handling state, and notifying listeners of changes.
class QuizProvider extends ChangeNotifier {
  /// The repository instance for quiz-related data.
  final QuizRepository quizRepository;
  List<Quiz> papers = [];

  /// The use case for fetching quizzes.
  final GetQuizzesUseCase getQuizzesUseCase;

  /// The use case for updating quiz results.
  final UpdateQuizResultsUseCase updateQuizResultsUseCase;

  /// Indicates whether quizzes are being loaded.
  bool isLoading = false;

  /// The list of fetched quizzes.
  List<Quiz> quizzes = [];

  /// The current question index.
  int currentQuestionIndex = 0;

  /// The selected paper index.
  int selectedPaperIndex = 0;

  /// The user's score.
  int score = 0;

  /// The title of the currently selected paper.
  String paperTitle = "";

  /// The time for the currently selected paper.
  int paperTime = 0;

  /// The currently selected option.
  int? selectedOption;

  /// The user's name (default is "Guest").
  String _userName = "Guest";
  String get userName => _userName;

  /// Constructor for initializing the `QuizProvider` with a repository and use case.
  QuizProvider(
      {required this.quizRepository,
      required this.getQuizzesUseCase,
      required this.updateQuizResultsUseCase});

  /// Fetches quizzes from the repository and updates the provider's state.
  Future<void> fetchQuizzes() async {
    logger.i('Fetching quizzes started.');
    isLoading = true;
    notifyListeners();

    try {
      // Execute the use case to fetch quizzes.
      quizzes = await getQuizzesUseCase.execute();

      // Log the quizzes fetched successfully.
      logger
          .i('Quizzes fetched successfully: ${quizzes.length} quizzes loaded.');
    } catch (e) {
      // Log any errors encountered during the fetch.
      logger.e('Error occurred while fetching quizzes: $e');

      // Reset quizzes to an empty list on failure.
      quizzes = [];
    }

    // Update the loading state and notify listeners.
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
        score++; // Increment score if the answer is correct
        logger.i('Answer correct! Score incremented to $score.');
      } else {
        logger.i('Answer incorrect.');
      }
    } catch (e) {
      // Handle the error if parsing fails
      logger.e("Error parsing answer: $e");
    }
    notifyListeners();
  }

  // List<QuestionPaper> get papers => _papers;

  // Future<void> loadPapers(BuildContext context) async {
  //   // Assuming repository.getQuestionPapers() returns List<QuestionPaperModel>
  //   final fetchedPapers = await repository.getQuizzes();
  //   _papers = _convertToQuestionPapers(fetchedPapers);
  //
  //   if (_papers.isNotEmpty) {
  //     paperTitle = _papers[0].title;
  //     paperTime = _papers[0].time;
  //   }
  //   notifyListeners();
  // }

  /// Updates the selected option for the current question.
  void selectOption(int option) {
    selectedOption = option;
    notifyListeners();
    logger.i('Selected option updated: $selectedOption');
  }

  /// Resets the selected option for the current question.
  void resetSelectedOption() {
    selectedOption = null;
    notifyListeners();
    logger.i('Selected option reset.');
  }

  /// Updates the user's score.
  void updateScore(int newScore) {
    score = newScore;
    notifyListeners();
    logger.i('Score updated to: $score.');
  }

  /// Saves the user's score to SharedPreferences.
  Future<void> saveScore() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('quizScore', score);
    logger.i('Score saved to SharedPreferences: $score');
  }

  // Retrieve score from shared preferences.
  Future<int?> getScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('quizScore');
  }

  Future<String?> getSavedLiveQuizId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('selectedLiveQuizId'); // Return saved quizId
  }

  /// Advances to the next question in the selected quiz.
  void nextQuestion() {
    if (currentQuestionIndex < totalQuestions - 1) {
      currentQuestionIndex++;
      notifyListeners();
      logger.i('Moved to the next question. Index: $currentQuestionIndex.');
    } else {
      logger.i('Last question reached. No more questions to advance.');
    }
  }

  /// Gets the total number of questions in the selected quiz.
  int get totalQuestions {
    return quizzes.isNotEmpty
        ? quizzes[selectedPaperIndex].questions.length
        : 0; // Return 0 if no quizzes are available
  }

  /// Selects a quiz paper by index and resets state.
  void selectPaper(int index) {
    selectedPaperIndex = index;
    currentQuestionIndex = 0;
    score = 0;
    notifyListeners();
    logger.i('Selected paper index updated: $selectedPaperIndex.');
  }

  /// Checks if the current question is the last in the quiz.
  bool get isLastQuestion {
    return currentQuestionIndex ==
        quizzes[selectedPaperIndex].questions.length - 1;
  }

  // Call the use case to update the quiz results after quiz completion.
  /// Call the use case to update the quiz results after quiz completion.
  Future<void> updateQuizResults(String schoolCode, String rollNumber) async {
    try {
      // Retrieve the quiz ID from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final quizId = prefs.getString('selectedLiveQuizId');

      // If quizId is null, log an error or return early.
      if (quizId == null) {
        logger.e('Quiz ID is missing. Cannot update quiz results.');
        return;
      }

      // Get the current timestamp
      final timestamp = DateTime.now();

      // Create the QuizResult object
      final quizResult = QuizResult(
        quizId: quizId,
        score: score,
        timestamp: timestamp,
      );

      // Call the use case to update quiz results
      final result = await updateQuizResultsUseCase.call(
          schoolCode, rollNumber, quizResult);

      result.fold(
        (failure) {
          logger.e('Failed to update quiz results: $failure');
        },
        (_) {
          logger.i('Quiz results updated successfully.');
        },
      );
    } catch (e) {
      logger.e('Error while updating quiz results: $e');
    }
  }
}
