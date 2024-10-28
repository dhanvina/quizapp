// providers/question_provider.dart
import 'package:flutter/material.dart';

import '../../data/models/question_model.dart';
import '../../domain/entities/question.dart';
import '../../domain/repository/question_repository_interface.dart';

class QuestionProvider extends ChangeNotifier {
  final QuestionRepositoryInterface repository;
  List<QuestionPaper> _papers = [];
  int currentQuestionIndex = 0;
  int selectedPaperIndex = 0;
  int score = 0;

  QuestionProvider({required this.repository});

  List<QuestionPaper> get papers => _papers;

  Future<void> loadPapers(BuildContext context) async {
    final fetchedQuestions = await repository.getQuestions();
    _papers = _convertToQuestionPapers(fetchedQuestions);
    final jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/questions.json');
    notifyListeners();
  }

  Question get currentQuestion {
    // Access the corresponding Question from papers and convert it to QuestionModel
    return papers[selectedPaperIndex].questions[currentQuestionIndex];
  }

  void checkAnswer(int selectedAnswer) {
    if (selectedAnswer == currentQuestion.answer) {
      score++; // Increment score if the answer is correct
    }
    nextQuestion();
  }

  void nextQuestion() {
    if (currentQuestionIndex <
        papers[selectedPaperIndex].questions.length - 1) {
      currentQuestionIndex++;
      notifyListeners();
    }
  }

  void selectPaper(int index) {
    selectedPaperIndex = index;
    currentQuestionIndex = 0;
    score = 0;
    notifyListeners();
  }

  bool get isLastQuestion =>
      currentQuestionIndex == papers[selectedPaperIndex].questions.length - 1;

  List<QuestionPaper> _convertToQuestionPapers(
      List<QuestionModel> questionModels) {
    String paperTitle =
        "Sample Title"; // Replace with your logic to get the title
    int paperTime = 60;
    // Assuming you have a method to group them into QuestionPapers
    // Modify this as per your specific logic
    return [
      QuestionPaper(
        title: paperTitle, // Provide the title
        time: paperTime, // Provide the time
        questions: questionModels
            .map((qm) => qm.toEntity())
            .toList(), // Convert QuestionModel to Question
      ),
    ]; // Adjust the logic if you have multiple papers
  }
}
