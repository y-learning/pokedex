import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokedex/viewmodels/pokemon_stat_slider_viewmodel.dart';

class BaseStatSlider extends StatelessWidget {
  final double stat;
  final Color activeColor;
  final Color inactiveColor;

  const BaseStatSlider({
    @required this.stat,
    this.activeColor,
    this.inactiveColor,
  });

  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: ScreenUtil.getInstance().setHeight(9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: inactiveColor,
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            width: PokemonStatSliderViewModel.calculateActiveSliderWidth(
              stat,
              constraints.maxWidth,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: activeColor,
            ),
          );
        },
      ),
    );
  }
}
