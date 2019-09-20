import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokedex/widgets/vertical_separator.dart';
import 'base_stats_slider.dart';

class StatRow extends StatelessWidget {
  final String statLabel;
  final int statValue;
  final Color textColor;
  final Color separatorColor;
  final String min;
  final String max;

  const StatRow({
    @required this.statLabel,
    @required this.statValue,
    this.textColor,
    this.separatorColor,
    this.min,
    this.max,
  });

  Widget build(BuildContext context) {
    return Row(
      children: [
        BaseStatLabel(
          stat: statLabel,
          color: textColor,
        ),
        VerticalSeparator(
          height: 42,
          color: separatorColor,
          margin: 24,
        ),
        BaseStatValue(
          stat: statValue,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
        SizedBox(width: ScreenUtil.getInstance().setWidth(24)),
        Expanded(
          child: Baseline(
            baseline: -2.0,
            baselineType: TextBaseline.alphabetic,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    StatLimitText(label: min, textColor: textColor),
                    SizedBox(width: ScreenUtil.getInstance().setWidth(20)),
                    StatLimitText(label: max, textColor: textColor),
                    SizedBox(width: ScreenUtil.getInstance().setWidth(28)),
                  ],
                ),
                BaseStatSlider(
                  stat: statValue.toDouble(),
                  activeColor: textColor,
                  inactiveColor: separatorColor.withAlpha(170),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class BaseStatLabel extends StatelessWidget {
  final String stat;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Decoration decoration;
  final Color color;

  const BaseStatLabel({
    @required this.stat,
    this.padding,
    this.margin,
    this.decoration,
    this.color,
  });

  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: ScreenUtil.getInstance().setWidth(75),
      padding: padding,
      decoration: decoration,
      child: Text(
        stat,
        textAlign: TextAlign.end,
        style: TextStyle(
          color: color,
          fontSize: ScreenUtil.getInstance().setSp(24),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class BaseStatValue extends StatelessWidget {
  final int stat;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Decoration decoration;
  final FontWeight fontWeight;
  final Color color;

  const BaseStatValue({
    @required this.stat,
    this.padding,
    this.margin,
    this.decoration,
    this.fontWeight,
    this.color,
  });

  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: ScreenUtil.getInstance().setWidth(44),
      padding: padding,
      decoration: decoration,
      child: Text(
        '$stat',
        textAlign: TextAlign.end,
        style: TextStyle(
          color: color,
          fontSize: ScreenUtil.getInstance().setSp(24),
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}

class StatLimitText extends StatelessWidget {
  final String label;
  final Color textColor;

  const StatLimitText({this.label, this.textColor});

  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        color: textColor.withAlpha(200),
        fontWeight: FontWeight.w600,
        fontSize: ScreenUtil.getInstance().setSp(19),
      ),
    );
  }
}
