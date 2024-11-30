import 'package:logger/logger.dart';

// Logger instance for structured logging
final Logger logger = Logger();

class QuizModel {
  final String quizId;
  final String title;
  final String paper;
  final bool isLive;
  final String paperType;
  final int timeLimit;
  final List<QuestionModel> questions;

  // Constructor for the QuizModel class
  QuizModel({
    required this.quizId,
    required this.title,
    required this.paper,
    required this.isLive,
    required this.paperType,
    required this.timeLimit,
    required this.questions,
  });

  // Unified factory constructor to create a QuizModel from Firestore data
  factory QuizModel.fromFirestore(Map<String, dynamic> json) {
    // Log the incoming data for troubleshooting
    logger.i('Creating QuizModel from Firestore data: $json');

    try {
      // Create and return the QuizModel instance from the Firestore document data
      return QuizModel(
        quizId: json['quiz_id'] ?? '',
        title: json['title'] ?? '',
        paper: json['paper'] ?? '',
        isLive: json['is_live'] ?? false, // Default to false if missing
        paperType: json['paper_type'] ?? 'unknown',
        timeLimit: json['time_limit'] ?? 0,
        questions: (json['questions'] as List<dynamic> ?? [])
            .map((q) => QuestionModel.fromFirestore(
                q as Map<String, dynamic>, json['paper_type'] ?? 'unknown'))
            .toList(),
      );
    } catch (e, stackTrace) {
      // Log any error that occurs while creating the model
      logger.e('Error creating QuizModel from Firestore',
          error: e, stackTrace: stackTrace);
      rethrow; // Re-throw the error after logging
    }
  }

  // Convert the QuizModel instance back to a Firestore document map
  Map<String, dynamic> toFirestore() {
    // Log the data being converted to Firestore format
    logger.i('Converting QuizModel to Firestore format: $this');

    return {
      'quiz_id': quizId,
      'title': title,
      'paper': paper,
      'is_live': isLive,
      'paper_type': paperType,
      'time_limit': timeLimit,
      'questions': questions.map((q) => q.toFirestore()).toList(),
    };
  }
}

// QuestionModel class to represent individual questions in the quiz
class QuestionModel {
  final String question;
  final double correctOption;
  final List<dynamic>? options;

  // Constructor for QuestionModel class
  QuestionModel({
    required this.question,
    required this.correctOption,
    this.options,
  });

  // Factory constructor to create a QuestionModel from Firestore data
  factory QuestionModel.fromFirestore(
      Map<String, dynamic> json, String paperType) {
    // Log the incoming question data
    logger.i('Creating QuestionModel from Firestore data: $json');

    try {
      // Return the QuestionModel with proper fields and options based on paper type
      return QuestionModel(
        question: json['question'] ??
            'No question provided', // Default to a placeholder if missing
        correctOption: _convertToInt(json['correct_option']),
        options: paperType == 'mcq'
            ? _convertToOptions(json['options'])
            : [], // No options for fill-in-the-blank questions
      );
    } catch (e, stackTrace) {
      // Log errors that occur while creating the QuestionModel
      logger.e('Error creating QuestionModel from Firestore',
          error: e, stackTrace: stackTrace);
      rethrow; // Re-throw the error after logging
    }
  }

  // Helper method to safely convert the correct_option to int or double
  static dynamic _convertToInt(dynamic value) {
    logger.d('Converting correct_option value: $value');

    if (value is int) {
      return value;
    } else if (value is String) {
      return int.tryParse(value) ?? double.tryParse(value) ?? 0;
    } else if (value is double) {
      return value;
    } else {
      return 0; // Default fallback value
    }
  }

  // Helper method to handle and convert options to a List<dynamic> format
  static List<dynamic> _convertToOptions(dynamic value) {
    logger.d('Converting options value: $value');

    if (value == null) {
      return []; // Return an empty list if no options are provided
    }
    return List<dynamic>.from(
        value); // Convert to List<dynamic> to support both int and double options
  }

  // Convert the QuestionModel instance back to Firestore document format
  Map<String, dynamic> toFirestore() {
    logger.i('Converting QuestionModel to Firestore format: $this');
    return {
      'question': question,
      'correct_option': correctOption,
      'options': options,
    };
  }
}
