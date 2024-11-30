import 'package:logger/logger.dart';
import 'package:quizapp/data/models/question_model.dart';

// Initialize the logger instance for logging
final Logger logger = Logger();

// Abstract class for the QuestionRepositoryInterface that defines operations for handling question papers
abstract class QuestionRepositoryInterface {
  // Fetches all question papers from the data source.
  // Logs the action and possible exceptions.
  Future<List<QuestionPaperModel>> getQuestionPapers();
}
