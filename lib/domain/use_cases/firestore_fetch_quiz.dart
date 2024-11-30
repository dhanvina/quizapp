import 'package:logger/logger.dart';
import 'package:quizapp/domain/entities/firestore_quiz.dart';
import 'package:quizapp/domain/repository/firestore_quiz_repository.dart';

// Initialize the logger instance for logging
final Logger logger = Logger();

// Use case to fetch quizzes from the repository
class GetQuizzesUseCase {
  final QuizRepository repository;

  // Constructor accepting the QuizRepository instance
  GetQuizzesUseCase(this.repository);

  /// Executes the use case to fetch quizzes.
  /// Logs the beginning and the outcome of the fetch operation.
  /// Returns a list of quizzes fetched from the repository.
  Future<List<Quiz>> execute() async {
    try {
      logger
          .i('Executing GetQuizzesUseCase: Fetching quizzes from repository.');

      // Fetch quizzes from the repository
      final quizzes = await repository.getQuizzes();

      logger.i(
          'GetQuizzesUseCase executed successfully. Number of quizzes fetched: ${quizzes.length}');

      return quizzes;
    } catch (e) {
      logger.e('Error executing GetQuizzesUseCase: $e');
      rethrow; // Re-throw the exception so it can be handled by the caller
    }
  }
}
