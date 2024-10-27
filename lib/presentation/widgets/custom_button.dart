// presentation/widgets/custom_button.dart
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
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
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isSelected = false; // Track selection state

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 220,
        height: 83.13,
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              _isSelected = !_isSelected; // Toggle selection state
            });
            widget.onPressed(); // Call the passed callback function
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Color(0xFFFFFFFF),
            backgroundColor:
                _isSelected ? Color(0xFF00A455) : Color(0xFF000000),
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.6),
            ),
          ),
          child: Text(
            widget.label, // Use the passed label
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
