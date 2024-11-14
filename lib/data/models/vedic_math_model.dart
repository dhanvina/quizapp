// lib/data/models/vedic_math_model.dart
class VedicMathQuestion {
  final String type;
  final String question;
  final num answer;  // Use `num` to allow both int and double values

  VedicMathQuestion({
    required this.type,
    required this.question,
    required this.answer,
  });

  factory VedicMathQuestion.fromJson(Map<String, dynamic> json) {
    return VedicMathQuestion(
      type: json['type'] as String,
      question: json['question'] as String,
      answer: json['answer'] as num,  // Can parse both int and double
    );
  }
}

class VedicMathPracticePaper {
  final String title;
  final int time;
  final List<VedicMathQuestion> questions;

  VedicMathPracticePaper({
    required this.title,
    required this.time,
    required this.questions,
  });

  factory VedicMathPracticePaper.fromJson(Map<String, dynamic> json) {
    var questionsJson = json['questions'] as List;
    List<VedicMathQuestion> questionsList = questionsJson
        .map((question) => VedicMathQuestion.fromJson(question))
        .toList();

    return VedicMathPracticePaper(
      title: json['title'] as String,
      time: json['time'] as int,
      questions: questionsList,
    );
  }
}
