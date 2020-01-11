import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokedex/viewmodels/pokemon_profile_viewmodel.dart';
import 'package:pokedex/widgets/type_label.dart';
import '../utils.dart';
import 'effectiveness_value.dart';

class TypeEffectivenessGrid extends StatelessWidget {
  final List<TypeViewModel> types;
  final List<String> effectivenessValues;
  final Color separatorColor;
  final TypeLabel _noneLabel = _noneTypeLabel();

  TypeEffectivenessGrid({
    this.types,
    this.effectivenessValues,
    this.separatorColor,
  });

  static TypeLabel _noneTypeLabel() {
    return TypeLabel(
      'NONE',
      color: Colors.black,
      titleSize: 24,
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtil.getInstance().setHeight(6),
        horizontal: ScreenUtil.getInstance().setWidth(34),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8),
      margin: EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: separatorColor,
            width: ScreenUtil.getInstance().setWidth(3),
          ),
        ),
      ),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: _childAspectRatio(context),
          crossAxisSpacing: ScreenUtil.getInstance().setWidth(26),
          mainAxisSpacing: ScreenUtil.getInstance().setHeight(12),
          crossAxisCount: _crossAxisTypeLabelsCount(context),
        ),
        itemCount: types.isEmpty ? 1 : types.length,
        itemBuilder: (context, index) {
          return types.isEmpty
              ? _noneLabel
              : _buildTypeLabel(types[index], effectivenessValues[index]);
        },
      ),
    );
  }

  double _childAspectRatio(BuildContext context) => Utils.isPortrait(context)
      ? Utils.width(context) / (Utils.height(context) / 10)
      : Utils.width(context) / (Utils.height(context) / 3);

  int _crossAxisTypeLabelsCount(BuildContext context) =>
      Utils.isPortrait(context) ? 2 : 3;

  TypeLabel _buildTypeLabel(TypeViewModel typeViewModel, String effectiveness) {
    var typeLabelAsset = Utils.getLabelAssetsFor(typeViewModel.type);

    return TypeLabel(
      typeViewModel.title,
      color: typeLabelAsset.color,
      typeIcon: typeLabelAsset.icon,
      padding: EdgeInsets.fromLTRB(
        ScreenUtil.getInstance().setWidth(24),
        ScreenUtil.getInstance().setHeight(2),
        ScreenUtil.getInstance().setWidth(6),
        ScreenUtil.getInstance().setWidth(2),
      ),
      typeIconSize: 32,
      titleSize: 24,
      widget: EffectivenessValue(value: effectiveness),
      shadowBlurRadius: 3.0,
      shadowSpreadRadius: 0.5,
    );
  }
}
