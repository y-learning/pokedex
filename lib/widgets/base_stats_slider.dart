import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseStatSlider extends StatelessWidget {
  final double value;
  final Function(double v) onChanged;

  const BaseStatSlider({this.value, this.onChanged});

  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: ScreenUtil.getInstance().setHeight(9),
        disabledActiveTrackColor: Color(0xFF6647B8),
        disabledInactiveTrackColor: Colors.grey,
        activeTrackColor: Color(0xFF6647B8),
        inactiveTrackColor: Colors.grey,
        thumbColor: Colors.white,
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0.0),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 0.0),
        overlayColor: Color(0x29EA1556),
      ),
      child: Slider(
        value: value,
        max: 200,
        min: 0.0,
        onChanged: null,
      ),
    );
  }
}
