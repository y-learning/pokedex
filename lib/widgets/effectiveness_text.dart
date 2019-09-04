import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants.dart';

class EffectivenessText extends StatelessWidget {
  final String text;

  EffectivenessText({this.text});

  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: ScreenUtil.getInstance().setWidth(112),
      child: Text(
        text,
        maxLines: 3,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: kGhostTypeColor1,
          fontSize: ScreenUtil.getInstance().setSp(24),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
