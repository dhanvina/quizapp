import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:quizapp/data/models/vedic_math_model.dart';

class VedicMathDataSource {
  Future<List<QuestionPaper>> fetchQuestionPapers() async {
    final jsonString = await rootBundle.loadString('assets/vedic_math.json');
    final Map<String, dynamic> decodedJson = json.decode(jsonString);
    final questionPapersJson = decodedJson['question_papers'] as List;
    return questionPapersJson
        .map((paper) => QuestionPaper.fromJson(paper))
        .toList();
  }
}
