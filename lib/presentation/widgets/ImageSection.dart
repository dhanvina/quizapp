import 'package:flutter/material.dart';

class ImageSection extends StatelessWidget {
  const ImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/quiz_preview.png',
      height: 225.81,
      width: 309.45,
    );
  }
}
