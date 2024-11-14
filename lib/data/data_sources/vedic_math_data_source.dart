// lib/data/data_sources/vedic_math_data_source.dart
import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/vedic_math_model.dart';

class VedicMathDataSource {
  Future<VedicMathPracticePaper> fetchPracticePaper() async {
    final jsonString = await rootBundle.loadString('assets/vedic_math.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return VedicMathPracticePaper.fromJson(jsonMap);
  }
}
