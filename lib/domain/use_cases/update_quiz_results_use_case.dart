import 'package:dartz/dartz.dart';
import 'package:quizapp/domain/entities/quiz_result.dart';

import '../repository/student_repository.dart';

// Define the contract for the use case
class UpdateQuizResultsUseCase {
  final StudentRepository quizRepository;

  // Constructor to initialize the repository
  UpdateQuizResultsUseCase(this.quizRepository);

  Future<Either<Exception, void>> call(
      String schoolCode, String rollNumber, QuizResult quizResult) {
    // Use the repository to update the quiz result
    return quizRepository.updateQuizResults(schoolCode, rollNumber, quizResult);
  }
}
