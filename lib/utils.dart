import 'package:flutter/material.dart';
import 'package:pokedex/usecases/pokemon_types.dart';

import 'constants.dart';

class Utils {
  static TypeLabelAssets getLabelAssetsFor(PokemonType type) {
    String icon;
    Color color;

    switch (type) {
      case PokemonType.GHOST:
        icon = 'images/types/ghost.svg';
        color = kGhostTypeColor1;
        break;
      case PokemonType.GROUND:
        icon = 'images/types/ground.svg';
        color = kGroundTypeColor1;
        break;
      case PokemonType.PSYCHIC:
        icon = 'images/types/psychic.svg';
        color = kPsychicTypeColor1;
        break;
      case PokemonType.DARK:
        icon = 'images/types/dark.svg';
        color = kDarkTypeColor1;
        break;
      case PokemonType.BUG:
        icon = 'images/types/bug.svg';
        color = kBugTypeColor1;
        break;
      case PokemonType.DRAGON:
        icon = 'images/types/dragon.svg';
        color = kDragonTypeColor1;
        break;
      case PokemonType.FAIRY:
        icon = 'images/types/fairy.svg';
        color = kFairyTypeColor1;
        break;
      case PokemonType.FIRE:
        icon = 'images/types/fire.svg';
        color = kFireTypeColor1;
        break;
      case PokemonType.NORMAL:
        icon = 'images/types/normal.svg';
        color = kNormalTypeColor1;
        break;
      case PokemonType.STEEL:
        icon = 'images/types/steel.svg';
        color = kSteelTypeColor1;
        break;
      case PokemonType.ELECTRIC:
        icon = 'images/types/electric.svg';
        color = kElectricTypeColor1;
        break;
      case PokemonType.FIGHT:
        icon = 'images/types/fight.svg';
        color = kFightTypeColor1;
        break;
      case PokemonType.FLYING:
        icon = 'images/types/flying.svg';
        color = kFlyingTypeColor1;
        break;
      case PokemonType.GRASS:
        icon = 'images/types/grass.svg';
        color = kGrassTypeColor1;
        break;
      case PokemonType.ICE:
        icon = 'images/types/ice.svg';
        color = kIceTypeColor1;
        break;
      case PokemonType.ROCK:
        icon = 'images/types/rock.svg';
        color = kRockTypeColor1;
        break;
      case PokemonType.WATER:
        icon = 'images/types/water.svg';
        color = kWaterTypeColor1;
        break;
      case PokemonType.POISON:
        icon = 'images/types/water.svg';
        color = kPoisonTypeColor1;
        break;
    }

    return TypeLabelAssets(color: color, icon: icon);
  }

  static bool isPortrait(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.portrait;

  static width(BuildContext context) => MediaQuery.of(context).size.width;

  static height(BuildContext context) => MediaQuery.of(context).size.height;
}

class TypeLabelAssets {
  final String icon;
  final Color color;

  TypeLabelAssets({this.icon, this.color});
}
