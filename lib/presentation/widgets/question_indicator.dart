// Changes have to make dynamic wrt number of questions in the json file
import 'package:flutter/material.dart';

class QuestionIndicator extends StatelessWidget {
  final int currentIndex;

  const QuestionIndicator({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(10, (index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 3),
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index == currentIndex ? Colors.green : Colors.grey,
            ),
          );
        }),
      ),
    );
  }
}
