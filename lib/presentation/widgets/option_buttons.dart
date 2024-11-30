import 'package:flutter/material.dart';
import 'package:quizapp/presentation/state_management/quiz_provider.dart';
import 'package:quizapp/presentation/widgets/custom_button.dart';
import 'package:quizapp/utils/constants.dart';

class OptionButtons extends StatefulWidget {
  final QuizProvider questionProvider;
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
      padding: EdgeInsets.symmetric(vertical: 5),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final buttonWidth = constraints.maxWidth * 0.4;
          final spacing = 14.0;

          return Wrap(
            alignment: WrapAlignment.center,
            spacing: spacing,
            runSpacing: 8.0,
            children: [
              // Generate buttons dynamically based on the options provided
              for (int i = 0; i < widget.question.options.length; i++)
                SizedBox(
                  width: buttonWidth,
                  child: CustomButton(
                    label: widget.question.options[i].toString(),
                    color: selectedOption == widget.question.options[i]
                        ? Constants.green
                        : Constants.black,
                    onPressed: () {
                      _handleOptionSelection(widget.question.options[i]);
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  void _handleOptionSelection(int option) {
    setState(() {
      selectedOption = option; // Update selected option
    });
    widget.onOptionSelected(option); // Notify parent widget of selection
  }
}
