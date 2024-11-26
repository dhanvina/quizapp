class QuizModel {
  final String quizId;
  final String title;
  final bool isLive;
  final String paperType;
  final String timeLimit;
  final List<QuestionModel> questions;

  QuizModel({
    required this.quizId,
    required this.title,
    required this.isLive,
    required this.paperType,
    required this.timeLimit,
    required this.questions,
  });

  // Unified factory constructor
  factory QuizModel.fromFirestore(Map<String, dynamic> json) {
    return QuizModel(
      quizId: json['quiz_id'],
      title: json['title'],
      isLive: json['is_live'] ?? false, // Default to false if missing
      paperType: json['paper_type'],
      timeLimit: json['time_limit'],
      questions: (json['questions'] as List<dynamic>)
          .map((q) => QuestionModel.fromFirestore(q as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'quiz_id': quizId,
      'title': title,
      'is_live': isLive,
      'paper_type': paperType,
      'time_limit': timeLimit,
      'questions': questions.map((q) => q.toFirestore()).toList(),
    };
  }
}

// QuestionModel
class QuestionModel {
  final String question;
  final String correctOption;
  final List<String>? options;

  QuestionModel({
    required this.question,
    required this.correctOption,
    this.options,
  });

  factory QuestionModel.fromFirestore(Map<String, dynamic> json) {
    return QuestionModel(
      question: json['question'],
      correctOption: json['correct_option'],
      options:
          json['options'] != null ? List<String>.from(json['options']) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'question': question,
      'correct_option': correctOption,
      'options': options,
    };
  }
}
