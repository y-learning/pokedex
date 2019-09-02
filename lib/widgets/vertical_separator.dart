import 'package:flutter/material.dart';

import '../constants.dart';

class VerticalSeparator extends StatelessWidget {
  final double height;

  const VerticalSeparator({this.height = 60});

  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 32,
      child: Container(
        color: kGhostTypeColor4,
        height: height,
        width: 2,
      ),
    );
  }
}
