import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'base_stats_slider.dart';

class StatRow extends StatelessWidget {
  final String statLabel;
  final double stat;
  final Color textColor;
  final Color separatorColor;

  const StatRow({
    @required this.stat,
    @required this.statLabel,
    this.textColor,
    this.separatorColor,
  });

  Widget build(BuildContext context) {
    return Row(
      children: [
        BaseStatText(
          stat: statLabel,
          width: ScreenUtil.getInstance().setWidth(90),
          margin: EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(24)),
          fontWeight: FontWeight.w700,
          color: textColor,
          padding: EdgeInsets.only(
            right: ScreenUtil.getInstance().setWidth(24),
            top: ScreenUtil.getInstance().setWidth(8),
            bottom: ScreenUtil.getInstance().setWidth(8),
          ),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(color: separatorColor, width: 2),
            ),
          ),
        ),
        BaseStatText(
          stat: '${stat.floor()}',
          width: ScreenUtil.getInstance().setWidth(66),
          fontWeight: FontWeight.w600,
          color: textColor,
          padding: EdgeInsets.only(
            right: ScreenUtil.getInstance().setWidth(24),
          ),
        ),
        Expanded(child: BaseStatSlider(stat: stat))
      ],
    );
  }
}

class BaseStatText extends StatelessWidget {
  final String stat;
  final double width;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Decoration decoration;
  final FontWeight fontWeight;
  final Color color;

  const BaseStatText({
    @required this.stat,
    this.width,
    this.padding,
    this.margin,
    this.decoration,
    this.fontWeight,
    this.color,
  });

  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      padding: padding,
      decoration: decoration,
      child: Text(
        stat,
        style: TextStyle(
          color: color,
          fontSize: ScreenUtil.getInstance().setSp(24),
          fontWeight: fontWeight,
        ),
        textAlign: TextAlign.end,
      ),
    );
  }
}
