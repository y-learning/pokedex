import 'package:flutter/material.dart';

import '../constants.dart';

class VerticalSeparator extends StatelessWidget {
  final double height;
  final Color color;

  const VerticalSeparator({this.height = 60, this.color});

  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 32,
      child: Container(
        color: color,
        height: height,
        width: 2,
      ),
    );
  }
}
