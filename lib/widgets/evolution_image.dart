import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EvolutionImage extends StatelessWidget {
  final String assetName;

  const EvolutionImage(this.assetName);

  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4),
        child: Image(
          width: ScreenUtil.getInstance().setWidth(112),
          image: AssetImage(assetName),
        ),
      ),
    );
  }
}
