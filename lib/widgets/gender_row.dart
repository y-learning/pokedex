import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'data_box.dart';

class GenderRow extends StatelessWidget {
  final String percentage;
  final IconData iconData;
  final Color color;

  GenderRow({this.percentage, this.iconData, this.color});

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DataBoxTitle(percentage, color: color),
        Icon(
          iconData,
          color: color,
          size: ScreenUtil.getInstance().setWidth(30),
        ),
      ],
    );
  }
}
