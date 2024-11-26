import 'package:quizapp/domain/entities/firestore_quiz.dart';
import 'package:quizapp/domain/repository/firestore_quiz_repository.dart';

class GetQuizzesUseCase {
  final QuizRepository repository;

  GetQuizzesUseCase(this.repository);

  Future<List<Quiz>> execute() async {
    return await repository.getQuizzes();
  }
}
