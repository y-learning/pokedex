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
  final double shadowBlurRadius;
  final double shadowSpreadRadius;

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
    this.shadowBlurRadius = 6.0,
    this.shadowSpreadRadius = 1.0,
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
          BoxShadow(
            color: color,
            blurRadius: shadowBlurRadius,
            spreadRadius: shadowSpreadRadius,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: ScreenUtil.getInstance().setWidth(typeIconSize),
            height: ScreenUtil.getInstance().setWidth(typeIconSize),
            child: SvgPicture.asset(typeIcon),
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
