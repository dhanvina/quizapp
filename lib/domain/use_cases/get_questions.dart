import '../entities/question.dart';
import '../repository/question_repository_interface.dart';

class GetQuestions {
  final QuestionRepositoryInterface repository;

  GetQuestions(this.repository);

  Future<List<Question>> call() async {
    final questionModels = await repository.getQuestions();
    return questionModels
        .map((qm) => Question(
              question: qm.question,
              options: qm.options,
              answer: qm.answer,
            ))
        .toList();
  }
}
