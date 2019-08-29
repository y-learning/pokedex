import 'package:flutter/material.dart';

class EvolutionImage extends StatelessWidget {
  final String assetName;

  const EvolutionImage(this.assetName);

  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4),
        child: Image(
          height: 100,
          width: 100,
          image: AssetImage(assetName),
        ),
      ),
    );
  }
}
