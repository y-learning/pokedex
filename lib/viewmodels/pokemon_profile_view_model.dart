import 'package:pokedex/usecases/pokemon_types.dart';

import 'chain_view_model.dart';

class PokemonProfileViewModel {
  final String pokemonName;
  final String nationalPokedexNum;
  final List<String> types;
  final bool hasMegaEvolution;
  final String species;
  final String height;
  final String weight;
  final List<String> abilities;
  final bool isGenderless;
  final String malePercentage;
  final String femalePercentage;
  final ChainViewModel chainViewModel;
  final String hp;
  final String atk;
  final String def;
  final String sAtk;
  final String sDef;
  final String spd;
  final List<TypeEffectivenessViewModel> weakTo;
  final List<TypeEffectivenessViewModel> immuneTo;
  final List<TypeEffectivenessViewModel> resistantTo;
  final List<TypeEffectivenessViewModel> damagedNormallyBy;

  PokemonProfileViewModel({
    this.pokemonName,
    this.nationalPokedexNum,
    this.types,
    this.hasMegaEvolution,
    this.species,
    this.height,
    this.weight,
    this.abilities,
    this.isGenderless,
    this.malePercentage,
    this.femalePercentage,
    this.chainViewModel,
    this.hp,
    this.atk,
    this.def,
    this.sAtk,
    this.sDef,
    this.spd,
    this.weakTo,
    this.immuneTo,
    this.resistantTo,
    this.damagedNormallyBy,
  });
}

class TypeEffectivenessViewModel {
  final PokemonType type;
  final String title;
  final String effectiveness;

  TypeEffectivenessViewModel({
    this.type,
    this.title,
    this.effectiveness,
  });
}
