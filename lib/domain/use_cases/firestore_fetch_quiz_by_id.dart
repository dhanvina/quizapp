import 'package:quizapp/domain/entities/firestore_quiz.dart';
import 'package:quizapp/domain/repository/firestore_quiz_repository.dart';

class GetQuizByIdUseCase {
  final QuizRepository repository;

  GetQuizByIdUseCase(this.repository);

  Future<Quiz> call(String quizId) async {
    return await repository.getQuizById(quizId);
  }
}
