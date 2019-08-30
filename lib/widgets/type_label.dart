import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TypeLabel extends StatelessWidget {
  final String type;
  final Color color;
  final double width;
  final double fontSize;

  const TypeLabel(
    this.type, {
    this.color,
    this.fontSize = 20,
    this.width = 180,
  });

  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: ScreenUtil.getInstance().setHeight(5),
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(100),
        ),
        child: AutoSizeText(
          type,
          maxLines: 1,
          style: TextStyle(
            color: Colors.white,
            fontSize: ScreenUtil.getInstance().setSp(32),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
