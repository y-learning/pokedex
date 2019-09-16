import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokedex/widgets/type_label.dart';
import '../constants.dart';
import '../usecases/pokemon_types.dart';
import 'effectiveness_value.dart';

class TypeEffectivenessGrid extends StatelessWidget {
  final List<PokemonType> types;
  final List<String> effectivenessValues;
  final Color separatorColor;

  TypeEffectivenessGrid({
    this.types,
    this.effectivenessValues,
    this.separatorColor,
  });

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
          childAspectRatio: childAspectRatio(context),
          crossAxisSpacing: ScreenUtil.getInstance().setWidth(26),
          mainAxisSpacing: ScreenUtil.getInstance().setHeight(12),
          crossAxisCount: crossAxisCount(context),
        ),
        itemCount: types.isNotEmpty ? types.length : 1,
        itemBuilder: (context, index) {
          return types.isNotEmpty
              ? _buildTypeLabel(index, types, effectivenessValues)
              : TypeLabel(
                  'NONE',
                  color: Colors.black,
                  typeIcon: '',
                  padding: EdgeInsets.symmetric(
                    vertical: ScreenUtil.getInstance().setHeight(10),
                    horizontal: ScreenUtil.getInstance().setWidth(34),
                  ),
                  typeIconSize: 0,
                  titleSize: 24,
                );
        },
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
    List<PokemonType> list,
    List<String> effectivenessValues,
  ) {
    String title;
    String typeIconAsset;
    Color typeColor;

    switch (list[index]) {
      case PokemonType.GHOST:
        title = '${_extractType(PokemonType.GHOST)}';
        typeIconAsset = 'images/types/ghost.svg';
        typeColor = kGhostTypeColor1;
        break;
      case PokemonType.GROUND:
        title = '${_extractType(PokemonType.GROUND)}';
        typeIconAsset = 'images/types/ground.svg';
        typeColor = kGroundTypeColor1;
        break;
      case PokemonType.PSYCHIC:
        title = '${_extractType(PokemonType.PSYCHIC)}';
        typeIconAsset = 'images/types/psychic.svg';
        typeColor = kPsychicTypeColor1;
        break;
      case PokemonType.DARK:
        title = '${_extractType(PokemonType.DARK)}';
        typeIconAsset = 'images/types/dark.svg';
        typeColor = kDarkTypeColor1;
        break;
      case PokemonType.BUG:
        title = '${_extractType(PokemonType.BUG)}';
        typeIconAsset = 'images/types/bug.svg';
        typeColor = kBugTypeColor1;
        break;
      case PokemonType.DRAGON:
        title = '${_extractType(PokemonType.DRAGON)}';
        typeIconAsset = 'images/types/dragon.svg';
        typeColor = kDragonTypeColor1;
        break;
      case PokemonType.FAIRY:
        title = '${_extractType(PokemonType.FAIRY)}';
        typeIconAsset = 'images/types/fairy.svg';
        typeColor = kFairyTypeColor1;
        break;
      case PokemonType.FIRE:
        title = '${_extractType(PokemonType.FIRE)}';
        typeIconAsset = 'images/types/fire.svg';
        typeColor = kFireTypeColor1;
        break;
      case PokemonType.NORMAL:
        title = '${_extractType(PokemonType.NORMAL)}';
        typeIconAsset = 'images/types/normal.svg';
        typeColor = kNormalTypeColor1;
        break;
      case PokemonType.STEEL:
        title = '${_extractType(PokemonType.STEEL)}';
        typeIconAsset = 'images/types/steel.svg';
        typeColor = kSteelTypeColor1;
        break;
      case PokemonType.ELECTRIC:
        title = '${_extractType(PokemonType.ELECTRIC)}';
        typeIconAsset = 'images/types/electric.svg';
        typeColor = kElectricTypeColor1;
        break;
      case PokemonType.FIGHT:
        title = '${_extractType(PokemonType.FIGHT)}';
        typeIconAsset = 'images/types/fight.svg';
        typeColor = kFightTypeColor1;
        break;
      case PokemonType.FLYING:
        title = '${_extractType(PokemonType.FLYING)}';
        typeIconAsset = 'images/types/flying.svg';
        typeColor = kFlyingTypeColor1;
        break;
      case PokemonType.GRASS:
        title = '${_extractType(PokemonType.GRASS)}';
        typeIconAsset = 'images/types/grass.svg';
        typeColor = kGrassTypeColor1;
        break;
      case PokemonType.ICE:
        title = '${_extractType(PokemonType.ICE)}';
        typeIconAsset = 'images/types/ice.svg';
        typeColor = kIceTypeColor1;
        break;
      case PokemonType.ROCK:
        title = '${_extractType(PokemonType.ROCK)}';
        typeIconAsset = 'images/types/rock.svg';
        typeColor = kRockTypeColor1;
        break;
      case PokemonType.WATER:
        title = '${_extractType(PokemonType.WATER)}';
        typeIconAsset = 'images/types/water.svg';
        typeColor = kWaterTypeColor1;
        break;
      case PokemonType.POISON:
        title = '${_extractType(PokemonType.POISON)}';
        typeIconAsset = 'images/types/water.svg';
        typeColor = kPoisonTypeColor1;
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

  String _extractType(PokemonType pokemonTypes) =>
      pokemonTypes.toString().split('.')[1];
}
