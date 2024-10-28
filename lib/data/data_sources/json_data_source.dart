// json_data_source.dart
import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/question_model.dart';

class JsonDataSource {
  Future<List<QuestionPaperModel>> loadQuestionPapers() async {
    final String response =
        await rootBundle.loadString('assets/questions.json');
    final Map<String, dynamic> jsonData = json.decode(response);

    if (jsonData.containsKey('question_papers')) {
      return (jsonData['question_papers'] as List)
          .map((paper) => QuestionPaperModel.fromJson(paper))
          .toList();
    } else {
      throw Exception(
          'Invalid JSON structure: "question_papers" key not found');
    }
  }
}
