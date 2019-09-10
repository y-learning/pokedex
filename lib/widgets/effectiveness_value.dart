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
            value.substring(0, value.length - 1),
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
              letterSpacing: -2,
              fontSize: ScreenUtil.getInstance().setSp(22),
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            value.substring(value.length - 1, value.length),
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: ScreenUtil.getInstance().setSp(16),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

//Text(
//'x',
//maxLines: 1,
//textAlign: TextAlign.center,
//style: TextStyle(
//fontSize: ScreenUtil.getInstance().setSp(16),
//fontWeight: FontWeight.w400,
//),
//),
