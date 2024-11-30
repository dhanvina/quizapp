import 'package:logger/logger.dart';

import '../../domain/entities/firestore_quiz.dart';
import '../../domain/repository/firestore_quiz_repository.dart';
import '../data_sources/quiz_data_source.dart';

// Initialize logger instance for logging
final Logger logger = Logger();

class QuizRepositoryImpl implements QuizRepository {
  final QuizDataSource dataSource;

  QuizRepositoryImpl(this.dataSource);

  // Fetch all quizzes from the data source
  @override
  Future<List<Quiz>> getQuizzes() async {
    logger.i('Fetching all quizzes from data source...');
    try {
      // Fetch quizzes from the data source
      final models = await dataSource.getQuizzes();

      // Log the number of quizzes fetched
      logger.d('Fetched ${models.length} quizzes.');

      // Convert models to Quiz entities and return
      return models
          .map((model) => Quiz(
                quizId: model.quizId,
                title: model.title,
                isLive: model.is_Live,
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
    } catch (e, stackTrace) {
      logger.e('Error fetching quizzes from data source',
          error: e, stackTrace: stackTrace);
      rethrow; // Rethrow the error after logging it
    }
  }

  // Fetch a single quiz by its ID
  @override
  Future<Quiz> getQuizById(String quizId) async {
    logger.i('Fetching quiz with ID: $quizId...');
    try {
      // Fetch the quiz by ID from the data source
      final model = await dataSource.fetchQuizById(quizId);

      // Log the fetched quiz details
      logger.d('Fetched quiz with ID: $quizId, Title: ${model.title}');

      // Convert the model to Quiz entity and return
      return Quiz(
        quizId: model.quizId,
        title: model.title,
        isLive: model.is_Live,
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
    } catch (e, stackTrace) {
      logger.e('Error fetching quiz by ID: $quizId',
          error: e, stackTrace: stackTrace);
      rethrow; // Rethrow the error after logging it
    }
  }

  // Fetch quizzes filtered by paper type
  @override
  Future<List<Quiz>> getQuizzesByType(String paperType) async {
    logger.i('Fetching quizzes of type: $paperType...');
    try {
      // Fetch quizzes from the data source
      final quizModels = await dataSource.getQuizzes();

      // Filter quizzes by paper type
      final filteredQuizzes =
          quizModels.where((quiz) => quiz.paperType == paperType).toList();

      // Log the number of quizzes matching the paper type
      logger.d('Found ${filteredQuizzes.length} quizzes of type: $paperType.');

      // Convert filtered models to Quiz entities and return
      return filteredQuizzes
          .map((model) => Quiz(
                quizId: model.quizId,
                title: model.title,
                isLive: model.is_Live,
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
    } catch (e, stackTrace) {
      logger.e('Error fetching quizzes by type: $paperType',
          error: e, stackTrace: stackTrace);
      rethrow; // Rethrow the error after logging it
    }
  }
}
