import 'package:logger/logger.dart';
import 'package:quizapp/domain/entities/firestore_quiz.dart';

// Initialize the logger instance for logging
final Logger logger = Logger();

// Abstract class for QuizRepository that defines the operations for quiz-related tasks
abstract class QuizRepository {
  // Fetches all quizzes from the data source.
  // Logs the action and possible exceptions.
  Future<List<Quiz>> getQuizzes();

  // Fetches a specific quiz by its unique ID.
  // Logs the action and any exceptions that occur.
  Future<Quiz> getQuizById(String quizId);

  // Fetches quizzes filtered by a specific paper type (e.g., multiple choice, true/false).
  // Logs the action and any exceptions.
  Future<List<Quiz>> getQuizzesByType(String paperType);
}
