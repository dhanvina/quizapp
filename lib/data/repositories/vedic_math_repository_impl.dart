// import 'package:quizapp/data/data_sources/vedic_math_data_source.dart';
// import 'package:quizapp/domain/entities/vedic_math_entity.dart';
// import 'package:quizapp/domain/repository/vedic_math_repository.dart';
//
// class VedicMathRepository implements VedicMathRepositoryInterface {
//   final VedicMathDataSource dataSource;
//
//   VedicMathRepository(this.dataSource);
//
//   @override
//   Future<List<VedicMathPracticePaperEntity>> getVedicQuestionPapers() async {
//     final questionPaperModels = await dataSource.fetchQuestionPapers();
//     return questionPaperModels.map((paperModel) {
//       return VedicMathPracticePaperEntity(
//         title: paperModel.title,
//         time: paperModel.time,
//         paper_type: paperModel.paper_type,
//         questions: paperModel.questions.map((q) {
//           return VedicMathQuestionEntity(
//             type: q.type,
//             question: q.question,
//             answer: q.answer,
//           );
//         }).toList(),
//       );
//     }).toList();
//   }
// }
