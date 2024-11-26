class QuizModel {
  final String quizId;
  final String title;
  final String paper;
  final bool isLive;
  final String paperType;
  final int timeLimit;
  final List<QuestionModel> questions;

  QuizModel({
    required this.quizId,
    required this.title,
    required this.paper,
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
      paper: json['paper'],
      isLive: json['is_live'] ?? false, // Default to false if missing
      paperType: json['paper_type'],
      timeLimit: json['time_limit'],
      questions: (json['questions'] as List<dynamic>)
          .map((q) => QuestionModel.fromFirestore(
              q as Map<String, dynamic>, json['paper_type']))
          .toList(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'quiz_id': quizId,
      'title': title,
      'paper': paper,
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
  final double correctOption;
  final List<dynamic>? options;

  QuestionModel({
    required this.question,
    required this.correctOption,
    this.options,
  });

  factory QuestionModel.fromFirestore(
      Map<String, dynamic> json, String paperType) {
    return QuestionModel(
      question: json['question'] ?? 'No question provided',
      correctOption: _convertToInt(json['correct_option']),
      options: paperType == 'mcq'
          ? _convertToOptions(json['options'])
          : [], // No options for fill
    );
  }

  // Helper method to safely convert correct_option to int or double
  static dynamic _convertToInt(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is String) {
      return int.tryParse(value) ?? double.tryParse(value) ?? 0;
    } else if (value is double) {
      return value;
    } else {
      return 0;
    }
  }

  // Helper method to handle missing or null options
  static List<dynamic> _convertToOptions(dynamic value) {
    if (value == null) {
      return [];
    }
    // Convert to List<dynamic> to support both int and double options
    return List<dynamic>.from(value);
  }

  Map<String, dynamic> toFirestore() {
    return {
      'question': question,
      'correct_option': correctOption,
      'options': options,
    };
  }
}
