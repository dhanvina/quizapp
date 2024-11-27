import 'package:flutter/material.dart';
import 'package:quizapp/domain/use_cases/firestore_fetch_quiz.dart';

import '../../domain/entities/firestore_quiz.dart';
import '../../domain/repository/firestore_quiz_repository.dart';

class QuizProvider extends ChangeNotifier {
  final QuizRepository repository;
  final GetQuizzesUseCase _getQuizzesUseCase;
  bool isLoading = false;
  List<Quiz> quizzes = [];

  QuizProvider(this.repository, this._getQuizzesUseCase);

  Future<void> fetchQuizzes() async {
    isLoading = true;
    notifyListeners();
    try {
      quizzes = await _getQuizzesUseCase.execute();
      print('Loaded quizzes provider: $quizzes');
    } catch (e) {
      print('Error in QuizProvider: $e');
      quizzes = [];
    }
    isLoading = false;
    notifyListeners();
  }
}
