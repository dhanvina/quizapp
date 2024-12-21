import 'package:logger/logger.dart';

import '../../data/models/quiz_result_model.dart';

// Initialize logger instance for logging
final Logger logger = Logger();

class QuizResult {
  final String quizId;
  final int score;
  final bool isLive;

  QuizResult({
    required this.quizId,
    required this.score,
    required this.isLive,
  }) {
    logger.i('QuizResult created: $quizId');
    logger.i('Score: $score');
  }

  // Convert QuizResult to QuizResultModel
  QuizResultModel toDataModel() {
    return QuizResultModel(
      quizId: quizId,
      score: score,
      isLive: isLive,
    );
  }

  // Convert QuizResultModel to QuizResult
  static QuizResult fromDataModel(QuizResultModel model) {
    return QuizResult(
      quizId: model.quizId,
      score: model.score,
      isLive: model.isLive,
    );
  }
}