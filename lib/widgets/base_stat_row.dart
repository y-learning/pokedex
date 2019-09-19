import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokedex/widgets/vertical_separator.dart';

import 'base_stats_slider.dart';

class StatRow extends StatelessWidget {
  final String statLabel;
  final String stat;
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
          width: ScreenUtil.getInstance().setWidth(62),
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
        VerticalSeparator(
          height: ScreenUtil.getInstance().setHeight(28),
          color: separatorColor,
        ),
        BaseStatText(
          stat: stat,
          width: ScreenUtil.getInstance().setWidth(42),
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
        SizedBox(width: ScreenUtil.getInstance().setWidth(24)),
        Expanded(
          child: BaseStatSlider(
            stat: double.parse(stat),
            activeColor: textColor,
            inactiveColor: separatorColor.withAlpha(170),
          ),
        )
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
