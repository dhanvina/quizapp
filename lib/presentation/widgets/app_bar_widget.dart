// app_bar_widget.dart
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "Mount Carmel English School",
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          fontSize: 25.99,
          height: 41.6 / 25.99,
          color: Color(0xFF000000),
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
    );
  }
}
