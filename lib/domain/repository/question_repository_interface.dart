import 'package:quizapp/data/models/question_model.dart';

abstract class QuestionRepositoryInterface {
  Future<List<QuestionPaperModel>> getQuestionPapers();
}
