import 'package:flutter/material.dart';
import 'package:quizapp/utils/constants.dart';

class FallingOverlay extends StatefulWidget {
  final String message;
  const FallingOverlay({required this.message});

  @override
  _FallingOverlayState createState() => _FallingOverlayState();
}

class _FallingOverlayState extends State<FallingOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    _animation = Tween<double>(begin: -50, end: 350).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Positioned(
          top: _animation.value,
          left: 0,
          right: 0,
          child: Material(
            color: Colors.transparent,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Constants.offWhite.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                widget.message,
                style: TextStyle(
                  color: Constants.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
