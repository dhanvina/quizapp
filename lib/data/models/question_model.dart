import 'package:logger/logger.dart';

import '../../domain/entities/question.dart';

// Initialize logger instance for logging
final Logger logger = Logger();

class QuestionModel {
  final String type;
  final String question;
  final List<double>? options;
  final double answer;

  // Constructor for the QuestionModel class
  QuestionModel({
    required this.type,
    required this.question,
    this.options,
    required this.answer,
  });

  // Factory constructor to create QuestionModel from JSON data
  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    // Log the incoming JSON data for debugging purposes
    logger.i('Creating QuestionModel from JSON: $json');

    try {
      // Return a new QuestionModel instance
      return QuestionModel(
        type: json['type'] as String,
        question: json['question'] as String,
        options: json['type'] == 'multiple_choice'
            ? List<double>.from(json['options'])
            : null, // Only set options for multiple choice questions
        // Convert the 'answer' field to double safely
        answer: (json['answer'] as num).toDouble(),
      );
    } catch (e, stackTrace) {
      // Log any errors that occur during JSON parsing
      logger.e('Error creating QuestionModel from JSON',
          error: e, stackTrace: stackTrace);
      rethrow; // Re-throw the error to propagate it further
    }
  }

  // Convert the QuestionModel to an entity (domain model)
  Question toEntity() {
    // Log the conversion process
    logger.i('Converting QuestionModel to entity: $this');

    return Question(
      type: type,
      question: question,
      options: options,
      answer: answer,
    );
  }
}

class QuestionPaperModel {
  final String title;
  final int time;
  final String paper_type;
  final List<QuestionModel> questions;

  // Constructor for the QuestionPaperModel class
  QuestionPaperModel({
    required this.title,
    required this.time,
    required this.paper_type,
    required this.questions,
  });

  // Factory constructor to create QuestionPaperModel from JSON data
  factory QuestionPaperModel.fromJson(Map<String, dynamic> json) {
    // Log the incoming JSON data for debugging purposes
    logger.i('Creating QuestionPaperModel from JSON: $json');

    try {
      // Return a new QuestionPaperModel instance
      return QuestionPaperModel(
        title: json['title'] as String,
        time: json['time'] as int,
        paper_type: json['paper_type'] as String,
        questions: (json['questions'] as List)
            .map((q) => QuestionModel.fromJson(q))
            .toList(),
      );
    } catch (e, stackTrace) {
      // Log any errors that occur during JSON parsing
      logger.e('Error creating QuestionPaperModel from JSON',
          error: e, stackTrace: stackTrace);
      rethrow; // Re-throw the error to propagate it further
    }
  }

  // Convert the QuestionPaperModel to an entity (domain model)
  QuestionPaper toEntity() {
    // Log the conversion process
    logger.i('Converting QuestionPaperModel to entity: $this');

    return QuestionPaper(
      title: title,
      time: time,
      paper_type: paper_type,
      questions: questions.map((q) => q.toEntity()).toList(),
    );
  }
}
