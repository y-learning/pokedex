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
    this.width = 170,
  });

  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
        ),
        width: width,
        height: height,
        child: Text(
          type,
          style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.bold),
        ),
        alignment: Alignment.center,
      ),
    );
  }
}
