import 'package:flutter/material.dart';

class EvolutionConditionBox extends StatelessWidget {
  final assetName;

  const EvolutionConditionBox(this.assetName);

  Widget build(BuildContext context) {
    return Container(
      child: Image(
        width: 28,
        image: AssetImage(assetName),
      ),
    );
  }
}
