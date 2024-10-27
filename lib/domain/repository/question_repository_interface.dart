import '../../data/models/question_model.dart';

abstract class QuestionRepositoryInterface {
  Future<List<QuestionModel>> getQuestions();
}
