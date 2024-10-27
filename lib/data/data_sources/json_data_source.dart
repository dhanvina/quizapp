import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/question_model.dart';

class JsonDataSource {
  Future<List<QuestionModel>> loadQuestions() async {
    final String response =
        await rootBundle.loadString('assets/questions.json');
    final Map<String, dynamic> jsonData = json.decode(response);

    List<QuestionModel> questions = [];
    for (var paper in jsonData['question_papers']) {
      for (var question in paper['questions']) {
        questions.add(QuestionModel.fromJson(question));
      }
    }
    return questions;
  }
}
