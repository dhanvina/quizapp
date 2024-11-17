// import '../entities/vedic_math_entity.dart';
// import '../repository/vedic_math_repository.dart';
//
// class FetchPracticePaper {
//   final VedicMathRepositoryInterface repository;
//
//   FetchPracticePaper(this.repository);
//
//   Future<List<VedicMathPracticePaperEntity>> call() async {
//     final questionPaperModels = await repository.getVedicQuestionPapers();
//     return questionPaperModels.map((paperModel) {
//       return VedicMathPracticePaperEntity(
//         title: paperModel.title,
//         time: paperModel.time,
//         paper_type: paperModel.paper_type,
//         questions: paperModel.questions.map((q) {
//           // Include the type when mapping to the Question entity
//           return VedicMathQuestionEntity(
//             type: q.type, // Pass the type field from the data model
//             question: q.question,
//             answer: q.answer,
//           );
//         }).toList(),
//       );
//     }).toList();
//   }
// }
