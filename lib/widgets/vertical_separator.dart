import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerticalSeparator extends StatelessWidget {
  final Color color;
  final double height;
  final double margin;

  const VerticalSeparator({this.color, this.height = 55, this.margin = 32});

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ScreenUtil.getInstance().setWidth(margin),
      ),
      color: color,
      height: ScreenUtil.getInstance().setHeight(height),
      width: ScreenUtil.getInstance().setWidth(3),
    );
  }
}
