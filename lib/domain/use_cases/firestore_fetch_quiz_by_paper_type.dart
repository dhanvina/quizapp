import 'package:logger/logger.dart';
import 'package:quizapp/domain/entities/firestore_quiz.dart';
import 'package:quizapp/domain/repository/firestore_quiz_repository.dart';

// Create a Logger instance
final Logger logger = Logger();

// Use case class to fetch a quiz by its ID from the repository
class GetQuizByIdUseCase {
  final QuizRepository repository;

  // Constructor to initialize the repository
  GetQuizByIdUseCase(this.repository);

  /// Executes the use case to fetch a quiz by its ID.
  /// Logs the execution flow and any potential errors.
  Future<Quiz> execute(String quizId) async {
    try {
      // Log the initiation of the method
      logger.i(
          'Starting GetQuizByIdUseCase execution: Fetching quiz with ID: $quizId');

      // Call the repository method to get the quiz by its ID
      final quiz = await repository.getQuizById(quizId);

      // Log the successful fetching of the quiz
      logger.i(
          'Successfully fetched quiz with ID: $quizId. Quiz title: ${quiz.title}');

      // Return the fetched quiz
      return quiz;
    } catch (e) {
      // Log any errors during the process
      logger
          .e('Error occurred while fetching quiz with ID: $quizId. Error: $e');
      rethrow; // Rethrow the exception to propagate it further
    }
  }
}
