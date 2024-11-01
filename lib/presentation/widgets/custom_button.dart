// presentation/widgets/custom_button.dart
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;

  const CustomButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 220,
        height: 83.13,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: Color(0xFFFFFFFF),
            backgroundColor: color,
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.6),
            ),
          ),
          child: Text(
            label, // Use the passed label
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
