import 'package:flutter/material.dart';

import '../../domain/entities/question.dart';

class QuestionList extends StatelessWidget {
  final List<Question> questions;

  const QuestionList({Key? key, required this.questions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: questions.length,
      itemBuilder: (context, index) {
        final question = questions[index];
        return ListTile(
          title: Text('Question ID: ${question.question}'),
          subtitle: Text(
              'Input: ${question.options.join(', ')}\nResult: ${question.answer}'),
        );
      },
    );
  }
}
