import 'package:flutter/material.dart';

class VerticalSeparator extends StatelessWidget {
  final double height;

  const VerticalSeparator({this.height = 60});

  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 32,
      child: Container(
        color: Color(0xFF9374D4),
        height: height,
        width: 2,
      ),
    );
  }
}