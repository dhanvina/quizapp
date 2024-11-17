import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VedicText extends StatelessWidget {
  final String questionText;
  final ValueChanged<String> onAnswerChanged;

  const VedicText({
    required this.questionText,
    required this.onAnswerChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          questionText,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold, // Bold style
            color: Color(0xFF000000), // Black color (000000)
          ),
        ),
        const SizedBox(height: 15), // Displaying the question text directly
        TextField(
          onChanged: onAnswerChanged,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Enter your answer',
            hintStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.normal,
              color: Color(0xFF000000), // Black hint text color
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black, // Border color
                width: 2.0, // Border width
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blue, // Focused border color
                width: 2.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey, // Border color when enabled
                width: 2.0,
              ),
            ),
          ),
        )
      ],
    );
  }
}
