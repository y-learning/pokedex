import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokedex/viewmodels/chain_view_model.dart';
import 'package:pokedex/widgets/type_label.dart';

import '../profile_theme.dart';
import '../resources.dart';
import '../utils.dart';
import 'data_box.dart';
import 'evolution_image.dart';

class PokemonEvolutionWidget extends StatelessWidget {
  final ChainViewModel chainViewModel;
  final ProfileTheme profileTheme;

  const PokemonEvolutionWidget({this.chainViewModel, this.profileTheme});

  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        EvolutionImage(pokemonImage('${chainViewModel.id}')),
        SizedBox(height: ScreenUtil.getInstance().setHeight(8)),
        DataBox(
          subtitle: chainViewModel.formattedId,
          widgets: [
            DataBoxTitle(
              chainViewModel.name,
              color: profileTheme.dataBoxTitleColor,
            ),
          ],
        ),
        SizedBox(height: 8),
        for (var typeLabel in _buildTypeLabelWidgets()) typeLabel
      ],
    );
  }

  List<Widget> _buildTypeLabelWidgets() {
    var list = this.chainViewModel.types.map<Widget>((typeViewModel) {
      var typeLabelAssets = Utils.getLabelAssetsFor(typeViewModel.type);

      return TypeLabel(
        typeViewModel.title,
        width: ScreenUtil.getInstance().setWidth(140),
        color: typeLabelAssets.color,
        typeIcon: typeLabelAssets.icon,
        padding: EdgeInsets.symmetric(
          vertical: ScreenUtil.getInstance().setHeight(2),
          horizontal: ScreenUtil.getInstance().setWidth(16),
        ),
        typeIconSize: ScreenUtil.getInstance().setWidth(32),
        titleSize: ScreenUtil.getInstance().setSp(32),
        shadowSpreadRadius: 0,
        shadowBlurRadius: 0,
      );
    }).toList();

    if (this.chainViewModel.types.length == 2)
      list.insert(1, SizedBox(height: 4));

    return list;
  }
}
