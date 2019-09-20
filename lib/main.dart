import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokedex/usecases/pokemon_profile_presenter.dart';
import 'package:pokedex/usecases/pokemon_profile_response_model.dart';
import 'package:pokedex/usecases/pokemon_types.dart';
import 'package:pokedex/viewmodels/pokemon_profile_view_model.dart';

import 'screens/profile_screen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          _setScreenUtil(orientation, context);

          return ProfileScreen(_buildPokemonProfileViewModel());
        },
      ),
    );
  }

  PokemonProfileViewModel _buildPokemonProfileViewModel() {
    PokemonProfilePresenter presenter = PokemonProfilePresenter();

    presenter.present(_gengarResponseModel());

    return presenter.viewModel;
  }

  PokemonProfileResponseModel _eveeResponseModel() {
    var chain = Chain(
      isBaby: true,
      species: Species(id: 133, name: 'evee'),
      evolutionDetails: [],
      evolvesTo: [
        Chain(
          isBaby: false,
          species: Species(id: 134, name: 'vaporeon'),
          evolutionDetails: [],
          evolvesTo: [],
        ),
        Chain(
          isBaby: false,
          species: Species(id: 135, name: 'jolteon'),
          evolutionDetails: [],
          evolvesTo: [],
        ),
        Chain(
          isBaby: false,
          species: Species(id: 136, name: 'flareon'),
          evolutionDetails: [],
          evolvesTo: [],
        ),
      ],
    );
    var weakTo = {PokemonType.FIGHT: 2.0};
    var immuneTo = {PokemonType.GHOST: 0.0};
    var damagedNormallyBy = {
      PokemonType.NORMAL: 1.0,
      PokemonType.FLYING: 1.0,
      PokemonType.POISON: 1.0,
      PokemonType.GROUND: 1.0,
      PokemonType.BUG: 1.0,
      PokemonType.FAIRY: 1.0,
      PokemonType.PSYCHIC: 1.0,
      PokemonType.DARK: 1.0,
      PokemonType.GRASS: 1.0,
      PokemonType.ROCK: 1.0,
      PokemonType.STEEL: 1.0,
      PokemonType.FIRE: 1.0,
      PokemonType.WATER: 1.0,
      PokemonType.ELECTRIC: 1.0,
      PokemonType.ICE: 1.0,
      PokemonType.DRAGON: 1.0,
    };
    PokemonProfileResponseModel responseModel = PokemonProfileResponseModel(
      pokemonName: 'evee',
      nationalPokedexNum: 133,
      types: [PokemonType.NORMAL],
      hasMegaEvolution: false,
      species: 'evolution',
      height: 0.3,
      weight: 6.5,
      isMetricSystem: true,
      abilities: [
        Ability(title: 'run away', isHidden: false),
        Ability(title: 'adaptability', isHidden: false),
        Ability(title: 'anticipation', isHidden: true),
      ],
      isGenderless: false,
      malePercentage: 0.875,
      femalePercentage: 0.125,
      chain: chain,
      stats: [
        Stat(baseStat: BaseStat.HP, value: 55, min: 220, max: 314),
        Stat(baseStat: BaseStat.ATK, value: 55, min: 103, max: 229),
        Stat(baseStat: BaseStat.DEF, value: 50, min: 94, max: 218),
        Stat(baseStat: BaseStat.SATK, value: 45, min: 85, max: 207),
        Stat(baseStat: BaseStat.SDEF, value: 65, min: 121, max: 251),
        Stat(baseStat: BaseStat.SPD, value: 55, min: 103, max: 229),
      ],
      weakTo: weakTo,
      immuneTo: immuneTo,
      resistantTo: {},
      damagedNormallyBy: damagedNormallyBy,
    );

    return responseModel;
  }

  PokemonProfileResponseModel _gengarResponseModel() {
    var chain3 = Chain(
      isBaby: false,
      species: Species(id: 94, name: 'Gengar'),
      evolutionDetails: [EvolutionDetail(trigger: Trigger.TRADE)],
      evolvesTo: [],
    );
    var chain2 = Chain(
      isBaby: false,
      species: Species(id: 93, name: 'Haunter'),
      evolutionDetails: [
        EvolutionDetail(trigger: Trigger.LEVEL_UP, minLevel: 25)
      ],
      evolvesTo: [chain3],
    );
    var chain1 = Chain(
      isBaby: true,
      species: Species(id: 92, name: 'Gastly'),
      evolutionDetails: [],
      evolvesTo: [chain2],
    );
    var weakTo = {
      PokemonType.GROUND: 2.0,
      PokemonType.GHOST: 2.0,
      PokemonType.PSYCHIC: 2.0,
      PokemonType.DARK: 2.0,
    };
    var immuneTo = {PokemonType.NORMAL: 0.0, PokemonType.FIGHT: 0.0};
    var resistantTo = {
      PokemonType.POISON: 0.25,
      PokemonType.BUG: 0.25,
      PokemonType.GRASS: 0.5,
      PokemonType.FAIRY: 0.5,
    };
    var damagedNormallyBy = {
      PokemonType.FLYING: 1.0,
      PokemonType.ROCK: 1.0,
      PokemonType.STEEL: 1.0,
      PokemonType.FIRE: 1.0,
      PokemonType.WATER: 1.0,
      PokemonType.ELECTRIC: 1.0,
      PokemonType.ICE: 1.0,
      PokemonType.DRAGON: 1.0,
    };
    PokemonProfileResponseModel responseModel = PokemonProfileResponseModel(
      pokemonName: 'Gengar',
      nationalPokedexNum: 94,
      types: [PokemonType.GHOST, PokemonType.POISON],
      hasMegaEvolution: true,
      species: 'shadow',
      height: 1.5,
      weight: 40.5,
      isMetricSystem: true,
      abilities: [Ability(title: 'Cursed Body', isHidden: false)],
      isGenderless: false,
      malePercentage: 0.5,
      femalePercentage: 0.5,
      chain: chain1,
      stats: [
        Stat(baseStat: BaseStat.HP, value: 60, min: 230, max: 324),
        Stat(baseStat: BaseStat.ATK, value: 65, min: 121, max: 251),
        Stat(baseStat: BaseStat.DEF, value: 60, min: 112, max: 240),
        Stat(baseStat: BaseStat.SATK, value: 130, min: 238, max: 394),
        Stat(baseStat: BaseStat.SDEF, value: 75, min: 139, max: 273),
        Stat(baseStat: BaseStat.SPD, value: 110, min: 202, max: 350),
      ],
      weakTo: weakTo,
      immuneTo: immuneTo,
      resistantTo: resistantTo,
      damagedNormallyBy: damagedNormallyBy,
    );

    return responseModel;
  }

  void _setScreenUtil(Orientation orientation, BuildContext context) {
    var width = 768.0;
    var height = 1024.0;

    if (orientation == Orientation.landscape) {
      width = 1024.0;
      height = 768.0;
    }

    ScreenUtil.instance = ScreenUtil(
      width: width,
      height: height,
      allowFontScaling: true,
    )..init(context);
  }
}
