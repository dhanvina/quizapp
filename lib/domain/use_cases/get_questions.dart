// domain/usecases/get_questions.dart
import '../entities/question.dart';
import '../repository/question_repository_interface.dart';

class GetQuestions {
  final QuestionRepositoryInterface repository;

  GetQuestions(this.repository);

  Future<List<QuestionPaper>> call() async {
    final questionPaperModels = await repository.getQuestionPapers();
    return questionPaperModels.map((paperModel) {
      return QuestionPaper(
        title: paperModel.title,
        time: paperModel.time,
        questions: paperModel.questions.map((q) {
          // Include the type when mapping to the Question entity
          return Question(
            type: q.type, // Pass the type field from the data model
            question: q.question,
            options: q.type == 'multiple_choice' ? q.options : null,
            answer: q.answer,
          );
        }).toList(),
      );
    }).toList();
  }
}
