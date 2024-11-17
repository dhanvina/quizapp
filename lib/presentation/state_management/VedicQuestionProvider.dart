// import 'package:flutter/material.dart';
// import 'package:quizapp/domain/entities/vedic_math_entity.dart';
// import 'package:quizapp/domain/repository/vedic_math_repository.dart';
//
// class VedicQuestionProvider with ChangeNotifier {
//   final VedicMathRepositoryInterface _repository;
//   List<VedicMathPracticePaperEntity> _questions = [];
//   List<VedicMathPracticePaperEntity> _papers = [];
//   bool _isLoading = false;
//   String paperTitle = "";
//   int paperTime = 0;
//
//   VedicQuestionProvider(this._repository);
//
//   List<VedicMathPracticePaperEntity> get questions => _questions;
//   bool get isLoading => _isLoading;
//
//   Future<List<VedicMathPracticePaperEntity>> loadQuestions() async {
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       _questions = await _repository.getVedicQuestionPapers();
//     } catch (e) {
//       print('Error loading questions: $e');
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//
//     return _questions;
//   }
//
//   Future<void> loadPapers(BuildContext context) async {
//     // Assuming repository.getQuestionPapers() returns List<QuestionPaperModel>
//     final fetchedPapers = await _repository.getVedicQuestionPapers();
//     _papers = fetchedPapers;
//
//     if (_papers.isNotEmpty) {
//       paperTitle = _papers[0].title;
//       paperTime = _papers[0].time;
//     }
//     notifyListeners();
//   }
//
//   // List<VedicMathPracticePaperEntity> _convertToQuestionPapers(
//   //     List<QuestionPaper> questionPaperModels) {
//   //   return questionPaperModels.map((qpm) {
//   //     return VedicMathPracticePaperEntity(
//   //       title: qpm.title,
//   //       time: qpm.time,
//   //       paper_type: qpm.paper_type,
//   //       questions: qpm.questions.map((question) {
//   //         return VedicMathQuestionEntity(
//   //           type: question.type, // Assuming `Question` has a `type` field
//   //           question: question.question, // Assuming `Question` has a `question` field
//   //           answer: question.answer, // Assuming `Question` has an `answer` field
//   //         );
//   //       }).toList(),
//   //     );
//   //   }).toList();
// }
//
// // void selectQuestion(int index) {
// //   if (index >= 0 && index < _questions.length) {
// //     print("Selected Question: ${_questions[index].title}");
// //   }
// // }
// // }
