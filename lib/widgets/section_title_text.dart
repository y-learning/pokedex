import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionTitleText extends StatelessWidget {
  final String data;
  final Color textColor;

  const SectionTitleText(this.data, {this.textColor});

  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        color: textColor,
        fontSize: ScreenUtil.getInstance().setSp(39),
        fontWeight: FontWeight.w800,
      ),
      textAlign: TextAlign.center,
    );
  }
}
