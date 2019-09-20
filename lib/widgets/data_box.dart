import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataBox extends StatelessWidget {
  final List<Widget> widgets;
  final String subtitle;

  const DataBox({this.widgets, this.subtitle});

  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (var widget in widgets) widget,
            SizedBox(height: 4),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: ScreenUtil.getInstance().setSp(20),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DataBoxTitle extends StatelessWidget {
  final String title;
  final Color color;
  final int titleMaxLines;

  const DataBoxTitle(this.title, {this.color, this.titleMaxLines = 1});

  Widget build(BuildContext context) {
    return AutoSizeText(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontSize: ScreenUtil.getInstance().setSp(32),
        fontWeight: FontWeight.w600,
      ),
      maxLines: titleMaxLines,
    );
  }
}
