import 'package:flutter/material.dart';

class TypeLabel extends StatelessWidget {
  final String type;
  final Color color;
  final double width;
  final double height;
  final double fontSize;

  const TypeLabel(
    this.type, {
    this.color,
    this.fontSize = 20,
    this.height = 32,
    this.width = 180,
  });

  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(
          type,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
