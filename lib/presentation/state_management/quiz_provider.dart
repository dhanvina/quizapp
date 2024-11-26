// quiz_provider.dart
import 'package:flutter/material.dart';

import '../../domain/entities/firestore_quiz.dart';
import '../../domain/use_cases/firestore_fetch_quiz.dart';

class QuizProvider with ChangeNotifier {
  final GetQuizzesUseCase getQuizzesUseCase;
  List<Quiz> quizzes = [];
  bool isLoading = false;

  QuizProvider(this.getQuizzesUseCase);

  Future<void> getQuizzes() async {
    // Mark as loading and notify listeners
    _setLoading(true);

    try {
      // Fetch quizzes
      quizzes = await getQuizzesUseCase.execute();
    } finally {
      // Mark as not loading and notify listeners
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  List<Quiz> get liveQuizzes => quizzes.where((quiz) => quiz.isLive).toList();
}
