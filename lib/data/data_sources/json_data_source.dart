import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/question_model.dart';

class JsonDataSource {
  Future<List<QuestionModel>> loadQuestions() async {
    final String response =
        await rootBundle.loadString('assets/questions.json');
    final Map<String, dynamic> jsonData = json.decode(response);

    if (jsonData.containsKey('question_papers')) {
      List<QuestionModel> questions = [];

      for (var paper in jsonData['question_papers']) {
        if (paper.containsKey('questions')) {
          questions.addAll((paper['questions'] as List)
              .map((question) => QuestionModel.fromJson(question))
              .toList());
        }
      }
      return questions;
    } else {
      throw Exception(
          'Invalid JSON structure: "question_papers" key not found');
    }
  }
}
