import 'package:flutter/material.dart';
import 'package:quizapp/domain/use_cases/firestore_fetch_quiz.dart';

import '../../domain/entities/firestore_quiz.dart';

class QuizProvider extends ChangeNotifier {
  final GetQuizzesUseCase _getQuizzesUseCase;

  QuizProvider(this._getQuizzesUseCase);

  bool isLoading = false;
  List<Quiz> quizzes = [];

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
