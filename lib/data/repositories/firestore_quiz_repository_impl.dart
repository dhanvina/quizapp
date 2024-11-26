import '../../domain/entities/firestore_quiz.dart';
import '../../domain/repository/firestore_quiz_repository.dart';
import '../data_sources/quiz_data_source.dart';

class QuizRepositoryImpl implements QuizRepository {
  final QuizDataSource dataSource;

  QuizRepositoryImpl(this.dataSource);

  @override
  Future<List<Quiz>> getQuizzes() async {
    final models = await dataSource.getQuizzes();
    return models
        .map((model) => Quiz(
              quizId: model.quizId,
              title: model.title,
              paper: model.paper,
              isLive: model.isLive,
              paperType: model.paperType,
              timeLimit: model.timeLimit,
              questions: model.questions
                  .map((q) => QuizQuestion(
                        question: q.question,
                        options: q.options,
                        correctOption: q.correctOption,
                      ))
                  .toList(),
            ))
        .toList();
  }

  // Fetch a single quiz by ID
  @override
  Future<Quiz> getQuizById(String quizId) async {
    final model = await dataSource.fetchQuizById(quizId);
    return Quiz(
      quizId: model.quizId,
      title: model.title,
      paper: model.paper,
      isLive: model.isLive,
      paperType: model.paperType,
      timeLimit: model.timeLimit,
      questions: model.questions
          .map((q) => QuizQuestion(
                question: q.question,
                options: q.options,
                correctOption: q.correctOption,
              ))
          .toList(),
    );
  }

  @override
  Future<List<Quiz>> getQuizzesByType(String paperType) async {
    final quizModels = await dataSource.getQuizzes();
    final filteredQuizzes =
        quizModels.where((quiz) => quiz.paperType == paperType).toList();
    return filteredQuizzes
        .map((model) => Quiz(
              quizId: model.quizId,
              title: model.title,
              paper: model.paper,
              isLive: model.isLive,
              paperType: model.paperType,
              timeLimit: model.timeLimit,
              questions: model.questions
                  .map((q) => QuizQuestion(
                        question: q.question,
                        options: q.options,
                        correctOption: q.correctOption,
                      ))
                  .toList(),
            ))
        .toList();
  }
}
