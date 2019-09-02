import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TypeLabel extends StatelessWidget {
  final String type;
  final Color color;
  final String typeAsset;

  const TypeLabel(
    this.type, {
    this.color,
    this.typeAsset,
  });

  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          vertical: ScreenUtil.getInstance().setHeight(12),
          horizontal: ScreenUtil.getInstance().setWidth(34),
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: color,
              blurRadius: 6.0, // has the effect of softening the shadow
              spreadRadius: 1.0, // has the effect of extending the shadow
            )
          ],
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              typeAsset,
              width: 24,
            ),
            Expanded(
              child: AutoSizeText(
                type,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil.getInstance().setSp(32),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
