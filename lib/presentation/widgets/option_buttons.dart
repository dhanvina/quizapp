// option_buttons.dart
import 'package:flutter/material.dart';
import 'package:quizapp/presentation/widgets/custom_button.dart';

import '../state_management/question_provider.dart';

class OptionButtons extends StatelessWidget {
  final QuestionProvider questionProvider;
  final question;
  final int? selectedOption;
  final Function(int) onOptionSelected;

  const OptionButtons({
    required this.questionProvider,
    required this.question,
    required this.selectedOption,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              CustomButton(
                label: question.options[0].toString(),
                color: selectedOption == question.options[0]
                    ? Colors.blueAccent
                    : Colors.black, // Highlight selected option
                onPressed: () {
                  onOptionSelected(question.options[0]);
                },
              ),
              SizedBox(height: 8),
              CustomButton(
                label: question.options[1].toString(),
                color: selectedOption == question.options[1]
                    ? Colors.blueAccent
                    : Colors.black,
                onPressed: () {
                  onOptionSelected(question.options[1]);
                },
              ),
            ],
          ),
          SizedBox(width: 20),
          Column(
            children: [
              CustomButton(
                label: question.options[2].toString(),
                color: selectedOption == question.options[2]
                    ? Colors.blueAccent
                    : Colors.black,
                onPressed: () {
                  onOptionSelected(question.options[2]);
                },
              ),
              SizedBox(height: 8),
              CustomButton(
                label: question.options[3].toString(),
                color: selectedOption == question.options[3]
                    ? Colors.blueAccent
                    : Colors.black,
                onPressed: () {
                  onOptionSelected(question.options[3]);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
