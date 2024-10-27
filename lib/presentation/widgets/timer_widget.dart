// timer_widget.dart
import 'package:flutter/material.dart';

class TimerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          '00:29',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
