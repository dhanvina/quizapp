// models/question_model.dart
class QuestionModel {
  final String question;
  final List<int> options;
  final int answer;

  QuestionModel(
      {required this.question, required this.options, required this.answer});

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      question: json['question'] as String,
      options: List<int>.from(json['options'] as List),
      answer: json['answer'] as int,
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
}
