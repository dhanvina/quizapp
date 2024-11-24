import '../data_sources/quiz_data_source.dart';
import '../models/firestore_question_model.dart';

class QuizRepository {
  final QuizDataSource dataSource;

  QuizRepository(this.dataSource);

  // Fetch all quizzes
  Future<List<QuizModel>> getQuizzes() async {
    return await dataSource.fetchQuizzes();
  }

  // Fetch a single quiz by ID
  Future<QuizModel> getQuizById(String quizId) async {
    return await dataSource.fetchQuizById(quizId);
  }

  // Filter quizzes by paper type
  Future<List<QuizModel>> getQuizzesByType(String paperType) async {
    final quizzes = await getQuizzes();
    return quizzes.where((quiz) => quiz.paperType == paperType).toList();
  }
}
