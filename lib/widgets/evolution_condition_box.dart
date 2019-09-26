import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil.getInstance().setWidth(32),
        ),
        message: hoverMessage,
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: ScreenUtil.getInstance().setSp(22),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: hoverColor,
        ),
        child: Image(
          width: ScreenUtil.getInstance().setWidth(36),
          image: AssetImage(assetName),
        ),
      ),
    );
  }
}
