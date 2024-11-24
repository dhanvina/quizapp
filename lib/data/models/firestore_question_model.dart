import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionModel {
  final String question;
  final String correctOption;
  final List<String>? options; // Optional for MCQ questions

  QuestionModel({
    required this.question,
    required this.correctOption,
    this.options,
  });

  factory QuestionModel.fromMap(Map<String, dynamic> data) {
    return QuestionModel(
      question: data['question'],
      correctOption: data['correct_option'],
      options:
          data['options'] != null ? List<String>.from(data['options']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'correct_option': correctOption,
      'options': options,
    };
  }
}

class QuizModel {
  final String quizId;
  final String title;
  final bool isLive;
  final String paperType;
  final int timeLimit;
  final List<QuestionModel> questions;

  QuizModel({
    required this.quizId,
    required this.title,
    required this.isLive,
    required this.paperType,
    required this.timeLimit,
    required this.questions,
  });

  factory QuizModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return QuizModel(
      quizId: doc.id,
      title: data['title'],
      isLive: data['is_Live'] == 1,
      paperType: data['paper_type'],
      timeLimit: data['time_limit'],
      questions: (data['questions'] as List)
          .map((q) => QuestionModel.fromMap(q))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'quiz_id': quizId,
      'title': title,
      'is_Live': isLive ? 1 : 0,
      'paper_type': paperType,
      'time_limit': timeLimit,
      'questions': questions.map((q) => q.toMap()).toList(),
    };
  }
}
