import 'package:flutter/material.dart';

import 'constants.dart';
import 'usecases/pokemon_types.dart';

class ProfileTheme {
  Color _appBarBackgroundColor;
  List<Color> _topRgbGradient;
  Color _dataBoxTitleColor;

  ProfileTheme(PokemonType type) {
    switch (type) {
      case PokemonType.GHOST:
        _appBarBackgroundColor = kGhostTypeColor4;
        _topRgbGradient = kGhostRgbGradient;
        _dataBoxTitleColor = kGhostTypeColor1;
        break;
      case PokemonType.GROUND:
        _appBarBackgroundColor = kGroundTypeColor4;
        _topRgbGradient = kGroundRgbGradient;
        _dataBoxTitleColor = kGroundTypeColor1;
        break;
      case PokemonType.PSYCHIC:
        _appBarBackgroundColor = kPsychicTypeColor4;
        _topRgbGradient = kPsychicRgbGradient;
        _dataBoxTitleColor = kPsychicTypeColor1;
        break;
      case PokemonType.DARK:
        _appBarBackgroundColor = kDarkTypeColor4;
        _topRgbGradient = kDarkRgbGradient;
        _dataBoxTitleColor = kDarkTypeColor1;
        break;
      case PokemonType.BUG:
        _appBarBackgroundColor = kBugTypeColor4;
        _topRgbGradient = kDarkRgbGradient;
        _dataBoxTitleColor = kBugTypeColor1;
        break;
      case PokemonType.DRAGON:
        _appBarBackgroundColor = kDragonTypeColor4;
        _topRgbGradient = kDragonRgbGradient;
        _dataBoxTitleColor = kDragonTypeColor1;
        break;
      case PokemonType.FAIRY:
        _appBarBackgroundColor = kFairyTypeColor4;
        _topRgbGradient = kFairyRgbGradient;
        _dataBoxTitleColor = kFairyTypeColor1;
        break;
      case PokemonType.FIRE:
        _appBarBackgroundColor = kFireTypeColor4;
        _topRgbGradient = kFireRgbGradient;
        _dataBoxTitleColor = kFireTypeColor1;
        break;
      case PokemonType.NORMAL:
        _appBarBackgroundColor = kNormalTypeColor4;
        _topRgbGradient = kNormalRgbGradient;
        _dataBoxTitleColor = kNormalTypeColor1;
        break;
      case PokemonType.STEEL:
        _appBarBackgroundColor = kSteelTypeColor4;
        _topRgbGradient = kSteelRgbGradient;
        _dataBoxTitleColor = kSteelTypeColor1;
        break;
      case PokemonType.ELECTRIC:
        _appBarBackgroundColor = kElectricTypeColor4;
        _topRgbGradient = kElectricRgbGradient;
        _dataBoxTitleColor = kElectricTypeColor1;
        break;
      case PokemonType.FIGHT:
        _appBarBackgroundColor = kFightTypeColor4;
        _topRgbGradient = kFireRgbGradient;
        _dataBoxTitleColor = kFightTypeColor1;
        break;
      case PokemonType.FLYING:
        _appBarBackgroundColor = kFlyingTypeColor4;
        _topRgbGradient = kFlyingRgbGradient;
        _dataBoxTitleColor = kFlyingTypeColor1;
        break;
      case PokemonType.GRASS:
        _appBarBackgroundColor = kGrassTypeColor4;
        _topRgbGradient = kGrassRgbGradient;
        _dataBoxTitleColor = kGrassTypeColor1;
        break;
      case PokemonType.ICE:
        _appBarBackgroundColor = kIceTypeColor4;
        _topRgbGradient = kIceRgbGradient;
        _dataBoxTitleColor = kIceTypeColor1;
        break;
      case PokemonType.ROCK:
        _appBarBackgroundColor = kRockTypeColor4;
        _topRgbGradient = kRockRgbGradient;
        _dataBoxTitleColor = kRockTypeColor1;
        break;
      case PokemonType.WATER:
        _appBarBackgroundColor = kWaterTypeColor4;
        _topRgbGradient = kWaterRgbGradient;
        _dataBoxTitleColor = kWaterTypeColor1;
        break;
      case PokemonType.POISON:
        _appBarBackgroundColor = kPoisonTypeColor4;
        _topRgbGradient = kPoisonRgbGradient;
        _dataBoxTitleColor = kPoisonTypeColor1;
        break;
    }
  }

  Color get dataBoxTitleColor => _dataBoxTitleColor;

  List<Color> get topRgbGradient => _topRgbGradient;

  Color get appBarBackgroundColor => _appBarBackgroundColor;
}
