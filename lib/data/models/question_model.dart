// models/question_model.dart
import '../../domain/entities/question.dart';

class QuestionModel {
  final String type;
  final String question;
  final List<dynamic>? options;
  final double answer;

  QuestionModel({
    required this.type,
    required this.question,
    this.options,
    required this.answer,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      type: json['type'] as String,
      question: json['question'] as String,
      options: json['type'] == 'multiple_choice'
          ? List<dynamic>.from(json['options'])
          : null,
      // Convert 'answer' to double safely
      answer: (json['answer'] as num).toDouble(),
    );
  }

  Question toEntity() {
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

  QuestionPaperModel({
    required this.title,
    required this.time,
    required this.paper_type,
    required this.questions,
  });

  factory QuestionPaperModel.fromJson(Map<String, dynamic> json) {
    return QuestionPaperModel(
      title: json['title'] as String,
      time: json['time'] as int,
      paper_type: json['paper_type'] as String,
      questions: (json['questions'] as List)
          .map((q) => QuestionModel.fromJson(q))
          .toList(),
    );
  }

  QuestionPaper toEntity() {
    return QuestionPaper(
      title: title,
      time: time,
      paper_type: paper_type,
      questions: questions.map((q) => q.toEntity()).toList(),
    );
  }
}
