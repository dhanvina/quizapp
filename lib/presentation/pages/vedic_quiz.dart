// import 'package:flutter/material.dart';
// import 'package:logger/logger.dart'; // Import logger for logging
// import 'package:quizapp/domain/entities/firestore_quiz.dart';
// import 'package:quizapp/utils/constants.dart';
//
// final Logger logger = Logger(); // Initialize logger instance
//
// class VedicQuizPage extends StatefulWidget {
//   final Quiz quiz;
//
//   const VedicQuizPage({Key? key, required this.quiz}) : super(key: key);
//
//   @override
//   _VedicQuizPageState createState() => _VedicQuizPageState();
// }
//
// class _VedicQuizPageState extends State<VedicQuizPage> {
//   final Map<int, TextEditingController> _controllers = {};
//
//   @override
//   void initState() {
//     super.initState();
//     if (widget.quiz.questions.isNotEmpty) {
//       // Initialize controllers only if there are questions
//       for (int i = 0; i < widget.quiz.questions.length; i++) {
//         _controllers[i] = TextEditingController();
//       }
//       logger.i(
//           "Initialized controllers for ${widget.quiz.questions.length} questions.");
//     } else {
//       logger.w("No questions found in the quiz.");
//     }
//   }
//
//   @override
//   void dispose() {
//     // Dispose of controllers to avoid memory leaks
//     for (var controller in _controllers.values) {
//       controller.dispose();
//     }
//     super.dispose();
//     logger.i("Disposed controllers.");
//   }
//
//   void _submitAnswers() {
//     int correctCount = 0;
//
//     for (int i = 0; i < widget.quiz.questions.length; i++) {
//       final question = widget.quiz.questions[i];
//       final userAnswer = double.tryParse(_controllers[i]!.text);
//
//       // Log the user's answer for each question
//       logger.i('User answer for "${question.question}": $userAnswer');
//
//       if (userAnswer != null && userAnswer == question.correctOption) {
//         correctCount++;
//       }
//     }
//
//     // Show results in a dialog
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text("Quiz Results"),
//         content: Text(
//           "You got $correctCount/${widget.quiz.questions.length} questions correct.",
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("OK"),
//           ),
//         ],
//       ),
//     );
//
//     logger.i(
//         "Quiz completed. Correct answers: $correctCount/${widget.quiz.questions.length}");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Constants.limeGreen,
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView.builder(
//           itemCount: widget.quiz.questions.length,
//           itemBuilder: (context, index) {
//             final question = widget.quiz.questions[index];
//             return Padding(
//               padding: const EdgeInsets.only(bottom: 16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "${index + 1}. ${question.question}",
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   TextFormField(
//                     controller: _controllers[index],
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       hintText: "Enter your answer",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ElevatedButton(
//           onPressed: _submitAnswers,
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Constants.green,
//             padding: const EdgeInsets.symmetric(vertical: 16),
//           ),
//           child: const Text(
//             "Submit",
//             style: TextStyle(fontSize: 16, color: Colors.white),
//           ),
//         ),
//       ),
//     );
//   }
// }
