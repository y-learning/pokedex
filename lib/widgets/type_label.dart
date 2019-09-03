import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TypeLabel extends StatelessWidget {
  final String type;
  final Color color;
  final String typeIcon;

  final double height;
  final double width;
  final Widget widget;

  final EdgeInsetsGeometry padding;

  final double typeIconSize;

  final double titleSize;

  const TypeLabel(
    this.type, {
    this.color,
    this.typeIcon,
    this.height,
    this.width,
    this.widget,
    this.padding,
    this.typeIconSize,
    this.titleSize,
  });

  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(color: color, blurRadius: 6.0, spreadRadius: 1.0),
        ],
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            typeIcon,
            width: ScreenUtil.getInstance().setWidth(typeIconSize),
            height: ScreenUtil.getInstance().setHeight(typeIconSize),
          ),
          Expanded(
            child: Text(
              type,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil.getInstance().setSp(titleSize),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          if (widget != null) widget,
        ],
      ),
    );
  }
}
