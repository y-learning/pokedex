import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EffectivenessText extends StatelessWidget {
  final String text;
  final Color color;

  EffectivenessText({this.text, this.color});

  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: ScreenUtil.getInstance().setWidth(112),
      child: Text(
        text,
        maxLines: 3,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontSize: ScreenUtil.getInstance().setSp(24),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
