import 'package:logger/logger.dart';
import 'package:quizapp/domain/entities/firestore_quiz.dart';
import 'package:quizapp/domain/repository/firestore_quiz_repository.dart';

// Initialize the logger instance for logging
final Logger logger = Logger();

// Use case to fetch a single quiz by its ID from the repository
class GetQuizByIdUseCase {
  final QuizRepository repository;

  // Constructor accepting the QuizRepository instance
  GetQuizByIdUseCase(this.repository);

  /// Executes the use case to fetch a quiz by its ID.
  /// Logs the beginning and the outcome of the fetch operation.
  /// Returns the fetched quiz or throws an error if the operation fails.
  Future<Quiz> execute(String quizId) async {
    try {
      logger.i(
          'Executing GetQuizByIdUseCase: Fetching quiz with quizId: $quizId');

      // Fetch the quiz by its ID from the repository
      final quiz = await repository.getQuizById(quizId);

      logger.i(
          'GetQuizByIdUseCase executed successfully. Quiz fetched: ${quiz.title}');

      return quiz;
    } catch (e) {
      logger.e('Error executing GetQuizByIdUseCase: $e');
      rethrow; // Re-throw the exception so it can be handled by the caller
    }
  }
}
