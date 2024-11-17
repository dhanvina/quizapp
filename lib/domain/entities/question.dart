class Question {
  final String type;
  final String question;
  final List<dynamic>? options;
  final double answer;

  Question(
      {required this.type,
      required this.question,
      this.options,
      required this.answer});
}

class QuestionPaper {
  final String title;
  final int time;
  final String paper_type;
  final List<Question> questions;

  QuestionPaper({
    required this.title,
    required this.time,
    required this.paper_type,
    required this.questions,
  });
}
