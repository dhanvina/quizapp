class Question {
  final String type;
  final String question;
  final dynamic answer;

  Question({
    required this.type,
    required this.question,
    required this.answer,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      type: json['type'] as String,
      question: json['question'] as String,
      answer: json['answer'],
    );
  }

  Question toEntity() {
    return Question(
      type: type,
      question: question,
      answer: answer,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'question': question,
      'answer': answer,
    };
  }
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

  factory QuestionPaper.fromJson(Map<String, dynamic> json) {
    var questionsJson = json['questions'] as List;
    List<Question> questionsList =
        questionsJson.map((q) => Question.fromJson(q)).toList();

    return QuestionPaper(
      title: json['title'] as String,
      time: json['time'] as int,
      paper_type: json['paper_type'] as String,
      questions: questionsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'time': time,
      'paper_type': paper_type,
      'questions': questions.map((q) => q.toJson()).toList(),
    };
  }
}
