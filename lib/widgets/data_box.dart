import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataBox extends StatelessWidget {
  final String title;
  final String subtitle;
  final int titleMaxLines;

  const DataBox(this.title, {this.subtitle, this.titleMaxLines = 1});

  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 100,
        child: Column(
          children: [
            AutoSizeText(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF6647B8),
                fontSize: ScreenUtil.getInstance().setSp(32),
                fontWeight: FontWeight.w600,
              ),
              maxLines: titleMaxLines,
            ),
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
