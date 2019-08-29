import 'package:flutter/material.dart';

class BaseStatText extends StatelessWidget {
  final String stat;
  final double width;

  const BaseStatText({@required this.stat, this.width});

  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Text(
        stat,
        style: TextStyle(
          color: Color(0xFF6647B8),
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.end,
      ),
    );
  }
}
