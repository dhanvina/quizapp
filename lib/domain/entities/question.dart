class Question {
  final String question;
  final List<int> options;
  final int answer;

  Question(
      {required this.question, required this.options, required this.answer});
}

class QuestionPaper {
  final String title;
  final int time;
  final List<Question> questions;

  QuestionPaper({
    required this.title,
    required this.time,
    required this.questions,
  });
}
