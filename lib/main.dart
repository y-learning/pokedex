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
    PokemonProfilePresenter presenter = PokemonProfilePresenter();
    PokemonProfileResponseModel responseModel = PokemonProfileResponseModel(
      pokemonName: 'Gengar',
      nationalPokedexNum: 94,
      types: [PokemonType.GHOST, PokemonType.POISON],
      hasMegaEvolution: true,
      species: 'shadow',
      height: 1.5,
      weight: 40.5,
      isMetricSystem: true,
      abilities: ['Cursed Body'],
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

    presenter.present(responseModel);

    return presenter.viewModel;
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
