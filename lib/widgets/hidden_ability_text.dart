import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class HiddenAbilityText extends StatelessWidget {
  final Color color;

  const HiddenAbilityText({this.color});

  Widget build(BuildContext context) {
    return AutoSizeText(
      ' (hidden ability)',
      style: TextStyle(color: color, fontStyle: FontStyle.italic),
    );
  }
}
