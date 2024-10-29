import 'package:flutter/material.dart';
import 'package:quizapp/presentation/state_management/question_provider.dart';
import 'package:quizapp/presentation/widgets/custom_button.dart';

class OptionButtons extends StatefulWidget {
  final QuestionProvider questionProvider;
  final question;
  final Function(int) onOptionSelected;

  const OptionButtons({
    required this.questionProvider,
    required this.question,
    required this.onOptionSelected,
  });

  @override
  _OptionButtonsState createState() => _OptionButtonsState();
}

class _OptionButtonsState extends State<OptionButtons> {
  int? selectedOption;

  @override
  void didUpdateWidget(covariant OptionButtons oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.question != widget.question) {
      setState(() {
        selectedOption = null; // Reset when question changes
      });
    }
  }

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
                label: widget.question.options[0].toString(),
                color: selectedOption == widget.question.options[0]
                    ? Colors.blueAccent
                    : Colors.black,
                onPressed: () {
                  setState(() {
                    selectedOption = widget.question.options[0];
                  });
                  widget.onOptionSelected(widget.question.options[0]);
                },
              ),
              SizedBox(height: 8),
              CustomButton(
                label: widget.question.options[1].toString(),
                color: selectedOption == widget.question.options[1]
                    ? Colors.blueAccent
                    : Colors.black,
                onPressed: () {
                  setState(() {
                    selectedOption = widget.question.options[1];
                  });
                  widget.onOptionSelected(widget.question.options[1]);
                },
              ),
            ],
          ),
          SizedBox(width: 20),
          Column(
            children: [
              CustomButton(
                label: widget.question.options[2].toString(),
                color: selectedOption == widget.question.options[2]
                    ? Colors.blueAccent
                    : Colors.black,
                onPressed: () {
                  setState(() {
                    selectedOption = widget.question.options[2];
                  });
                  widget.onOptionSelected(widget.question.options[2]);
                },
              ),
              SizedBox(height: 8),
              CustomButton(
                label: widget.question.options[3].toString(),
                color: selectedOption == widget.question.options[3]
                    ? Colors.blueAccent
                    : Colors.black,
                onPressed: () {
                  setState(() {
                    selectedOption = widget.question.options[3];
                  });
                  widget.onOptionSelected(widget.question.options[3]);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
