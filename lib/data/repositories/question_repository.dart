// question_repository.dart
import '../../domain/repository/question_repository_interface.dart';
import '../data_sources/json_data_source.dart';
import '../models/question_model.dart';

class QuestionRepository implements QuestionRepositoryInterface {
  final JsonDataSource dataSource;

  QuestionRepository(this.dataSource);

  @override
  Future<List<QuestionPaperModel>> getQuestionPapers() async {
    return await dataSource.loadQuestionPapers();
  }
}
