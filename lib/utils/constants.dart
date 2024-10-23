import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants {
  static const Color green = Color(0xFF00A455); // Green
  static const Color darkGray = Color(0xFF1E1E1E); // Dark Gray
  static const Color gray = Color(0xFF2B2E35); // Gray
  static const Color navyBlue = Color(0xFF052652); // Navy Blue
  static const Color black = Color(0xFF000000); // Black
  static const Color lightGray = Color(0xFF979797); // Light Gray
  static const Color offWhite = Color(0xFFF4F4F7); // Off White
  static const Color purple = Color(0xFF280A82); // Purple
  static const Color red = Color(0xFF9D0707); // Red
  static const Color lightRed = Color(0xFFCE2E2E); // Light Red
  static const Color limeGreen = Color(0xFF9DCC29); // Lime Green

  // Define your text styles here as well
  static final TextStyle signInButtonStyle = GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    fontSize: 17,
    color: Constants.offWhite, // Use color from constants
  );

  static final TextStyle footerTextStyle = GoogleFonts.poppins(
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
    fontSize: 30,
  );

  static final TextStyle welcomeTextStyleDark = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: Constants.darkGray, // Color for "Welcome"
  );

  static final TextStyle welcomeTextStyleGreen = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: Constants.green, // Color for "Student"
  );

  static final TextStyle subTextStyle = GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: 18,
    color: Constants.lightGray,
  );
}
