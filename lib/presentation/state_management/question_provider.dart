// providers/question_provider.dart
import 'dart:convert';

import 'package:flutter/material.dart';

import '../../data/models/question_model.dart';

class QuestionProvider extends ChangeNotifier {
  List<QuestionPaperModel> papers = [];
  int currentQuestionIndex = 0;
  int selectedPaperIndex = 0;
  int score = 0;

  Future<void> loadPapers(BuildContext context) async {
    final jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/questions.json');
    final Map<String, dynamic> data = json.decode(jsonString);
    papers = (data['papers'] as List)
        .map((p) => QuestionPaperModel.fromJson(p))
        .toList();
    notifyListeners();
  }

  QuestionModel get currentQuestion =>
      papers[selectedPaperIndex].questions[currentQuestionIndex];

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
}
