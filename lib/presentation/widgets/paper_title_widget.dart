// presentation/widgets/paper_title_widget.dart
import 'package:flutter/material.dart';

class PaperTitleWidget extends StatelessWidget {
  final String title;

  const PaperTitleWidget({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 195.23,
      height: 41,
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Rubik',
          fontWeight: FontWeight.w500,
          fontSize: 27.09,
          height: 1.5, // Line height of 150%
          color: Color(0xFF0C092A),
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}
