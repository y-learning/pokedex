import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EffectivenessValue extends StatelessWidget {
  final String value;

  EffectivenessValue({this.value});

  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(48),
      height: ScreenUtil.getInstance().setHeight(48),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: AutoSizeText(
        value,
        maxLines: 2,
        textAlign: TextAlign.center,
        style: TextStyle(
          letterSpacing: -1,
          fontSize: ScreenUtil.getInstance().setSp(24),
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
