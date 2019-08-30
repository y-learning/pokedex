import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'base_stats_slider.dart';

class StatRow extends StatelessWidget {
  final String statLabel;
  final double stat;

  const StatRow({@required this.stat, @required this.statLabel});

  Widget build(BuildContext context) {
    return Row(
      children: [
        BaseStatText(
          stat: statLabel,
          width: ScreenUtil.getInstance().setWidth(90),
          margin: EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(24)),
          padding: EdgeInsets.only(
            right: ScreenUtil.getInstance().setWidth(24),
            top: ScreenUtil.getInstance().setWidth(8),
            bottom: ScreenUtil.getInstance().setWidth(8),
          ),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(color: Color(0xFF9374D4), width: 2),
            ),
          ),
        ),
        BaseStatText(
          stat: '${stat.floor()}',
          width: ScreenUtil.getInstance().setWidth(66),
          padding: EdgeInsets.only(
            right: ScreenUtil.getInstance().setWidth(24),
          ),
        ),
        Expanded(child: BaseStatSlider(value: stat))
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

  const BaseStatText({
    @required this.stat,
    this.width,
    this.padding,
    this.margin,
    this.decoration,
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
          color: Color(0xFF6647B8),
          fontSize: ScreenUtil.getInstance().setSp(24),
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.end,
      ),
    );
  }
}
