import 'package:flutter/material.dart';

class EvolutionConditionBox extends StatelessWidget {
  final assetName;
  final String hoverMessage;
  final Color hoverColor;

  const EvolutionConditionBox({
    this.assetName,
    this.hoverMessage,
    this.hoverColor,
  });

  Widget build(BuildContext context) {
    return Container(
      child: Tooltip(
        padding: EdgeInsets.symmetric(horizontal: 16),
        message: hoverMessage,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: hoverColor,
        ),
        child: Image(
          width: 30,
          image: AssetImage(assetName),
        ),
      ),
    );
  }
}
