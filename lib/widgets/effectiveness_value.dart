import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EffectivenessValue extends StatelessWidget {
  final String value;

  EffectivenessValue({this.value});

  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(40),
      height: ScreenUtil.getInstance().setHeight(60),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
              letterSpacing: -2,
              fontSize: ScreenUtil.getInstance().setSp(24),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
