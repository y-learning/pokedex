import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokedex/widgets/type_label.dart';

import '../constants.dart';
import '../pokemon_types.dart';
import 'effectiveness_value.dart';

class TypeEffectivenessGrid extends StatelessWidget {
  final List<PokemonTypes> types;
  final List<String> effectivenessValues;

  TypeEffectivenessGrid({this.types, this.effectivenessValues});

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8),
      margin: EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: kGhostTypeColor4,
            width: ScreenUtil.getInstance().setWidth(3),
          ),
        ),
      ),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(8),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: childAspectRatio(context),
          crossAxisSpacing: ScreenUtil.getInstance().setWidth(26),
          mainAxisSpacing: ScreenUtil.getInstance().setHeight(12),
          crossAxisCount: crossAxisCount(context),
        ),
        itemBuilder: (context, index) => _buildTypeLabel(
          index,
          types,
          effectivenessValues,
        ),
        itemCount: types.length,
      ),
    );
  }

  int crossAxisCount(BuildContext context) =>
      (MediaQuery.of(context).orientation == Orientation.portrait) ? 2 : 3;

  double childAspectRatio(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait)
      return MediaQuery.of(context).size.width /
          (MediaQuery.of(context).size.height / 8);
    else
      return MediaQuery.of(context).size.width /
          (MediaQuery.of(context).size.height / 3);
  }

  TypeLabel _buildTypeLabel(
    int index,
    List<PokemonTypes> list,
    List<String> effectivenessValues,
  ) {
    String title;
    String typeIconAsset;
    Color typeColor;

    switch (list[index]) {
      case PokemonTypes.GHOST:
        title = '${_extractType(PokemonTypes.GHOST)}';
        typeIconAsset = 'images/types/ghost.svg';
        typeColor = kGhostTypeColor1;
        break;
      case PokemonTypes.GROUND:
        title = '${_extractType(PokemonTypes.GROUND)}';
        typeIconAsset = 'images/types/ground.svg';
        typeColor = kGroundTypeColor1;
        break;
      case PokemonTypes.PSYCHIC:
        title = '${_extractType(PokemonTypes.PSYCHIC)}';
        typeIconAsset = 'images/types/psychic.svg';
        typeColor = kPsychicTypeColor1;
        break;
      case PokemonTypes.DARK:
        title = '${_extractType(PokemonTypes.DARK)}';
        typeIconAsset = 'images/types/dark.svg';
        typeColor = kDarkTypeColor1;
        break;
      case PokemonTypes.BUG:
        title = '${_extractType(PokemonTypes.BUG)}';
        typeIconAsset = 'images/types/bug.svg';
        typeColor = kBugTypeColor1;
        break;
      case PokemonTypes.DRAGON:
        title = '${_extractType(PokemonTypes.DRAGON)}';
        typeIconAsset = 'images/types/dragon.svg';
        typeColor = kDragonTypeColor1;
        break;
      case PokemonTypes.FAIRY:
        title = '${_extractType(PokemonTypes.FAIRY)}';
        typeIconAsset = 'images/types/fairy.svg';
        typeColor = kFairyTypeColor1;
        break;
      case PokemonTypes.FIRE:
        title = '${_extractType(PokemonTypes.FIRE)}';
        typeIconAsset = 'images/types/fire.svg';
        typeColor = kFireTypeColor1;
        break;
      case PokemonTypes.NORMAL:
        title = '${_extractType(PokemonTypes.NORMAL)}';
        typeIconAsset = 'images/types/normal.svg';
        typeColor = kNormalTypeColor1;
        break;
      case PokemonTypes.STEEL:
        title = '${_extractType(PokemonTypes.STEEL)}';
        typeIconAsset = 'images/types/steel.svg';
        typeColor = kSteelTypeColor1;
        break;
      case PokemonTypes.ELECTRIC:
        title = '${_extractType(PokemonTypes.ELECTRIC)}';
        typeIconAsset = 'images/types/electric.svg';
        typeColor = kElectricTypeColor1;
        break;
      case PokemonTypes.FIGHT:
        title = '${_extractType(PokemonTypes.FIGHT)}';
        typeIconAsset = 'images/types/fight.svg';
        typeColor = kFightTypeColor1;
        break;
      case PokemonTypes.FLYING:
        title = '${_extractType(PokemonTypes.FLYING)}';
        typeIconAsset = 'images/types/flying.svg';
        typeColor = kFlyingTypeColor1;
        break;
      case PokemonTypes.GRASS:
        title = '${_extractType(PokemonTypes.GRASS)}';
        typeIconAsset = 'images/types/grass.svg';
        typeColor = kGrassTypeColor1;
        break;
      case PokemonTypes.ICE:
        title = '${_extractType(PokemonTypes.ICE)}';
        typeIconAsset = 'images/types/ice.svg';
        typeColor = kIceTypeColor1;
        break;
      case PokemonTypes.ROCK:
        title = '${_extractType(PokemonTypes.ROCK)}';
        typeIconAsset = 'images/types/rock.svg';
        typeColor = kRockTypeColor1;
        break;
      case PokemonTypes.WATER:
        title = '${_extractType(PokemonTypes.WATER)}';
        typeIconAsset = 'images/types/water.svg';
        typeColor = kWaterTypeColor1;
        break;
      case PokemonTypes.POISON:
        title = '${_extractType(PokemonTypes.POISON)}';
        typeIconAsset = 'images/types/water.svg';
        typeColor = kWaterTypeColor1;
        break;
    }

    return TypeLabel(
      title,
      color: typeColor,
      typeIcon: typeIconAsset,
      padding: EdgeInsets.fromLTRB(
        ScreenUtil.getInstance().setWidth(24),
        ScreenUtil.getInstance().setHeight(2),
        ScreenUtil.getInstance().setWidth(6),
        ScreenUtil.getInstance().setWidth(2),
      ),
      typeIconSize: 32,
      titleSize: 24,
      widget: EffectivenessValue(value: effectivenessValues[index]),
      shadowBlurRadius: 3.0,
      shadowSpreadRadius: 0.5,
    );
  }

  String _extractType(PokemonTypes pokemonTypes) =>
      pokemonTypes.toString().split('.')[1];
}
