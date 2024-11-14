// models/question_model.dart
import '../../domain/entities/question.dart';

class QuestionModel {
  final String type;
  final String question;
  final List<dynamic>? options;
  final double answer;

  QuestionModel(
      {required this.type,
      required this.question,
      this.options,
      required this.answer});

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      type: json['type'] as String,
      question: json['question'] as String,
      // options: List<int>.from(json['options'] as List),
      options: json['type'] == 'multiple_choice'
          ? List<dynamic>.from(json['options'])
          : null,
      answer: json['answer'] as double,
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
  final List<QuestionModel> questions;

  QuestionPaperModel(
      {required this.title, required this.time, required this.questions});

  factory QuestionPaperModel.fromJson(Map<String, dynamic> json) {
    return QuestionPaperModel(
      title: json['title'] as String,
      time: json['time'] as int,
      questions: (json['questions'] as List)
          .map((q) => QuestionModel.fromJson(q))
          .toList(),
    );
  }

  QuestionPaper toEntity() {
    return QuestionPaper(
      title: title,
      time: time,
      questions: questions.map((q) => q.toEntity()).toList(),
    );
  }
}
