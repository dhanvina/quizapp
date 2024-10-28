// question_repository_interface.dart
import 'package:quizapp/data/models/question_model.dart';

abstract class QuestionRepositoryInterface {
  Future<List<QuestionPaperModel>> getQuestionPapers();
}
