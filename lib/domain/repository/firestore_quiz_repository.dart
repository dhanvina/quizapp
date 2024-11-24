import 'package:quizapp/domain/entities/firestore_quiz.dart';

abstract class QuizRepository {
  Future<List<Quiz>> getQuizzes();
  Future<Quiz> getQuizById(String quizId);
  Future<List<Quiz>> getQuizzesByType(String paperType);
}
