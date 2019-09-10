import 'package:pokedex/usecases/pokemon_types.dart';

import 'chain_view_model.dart';

class PokemonProfileViewModel {
  final String pokemonName;
  final int id;
  final String nationalPokedexNum;
  final List<TypeViewModel> types;
  final bool hasMegaEvolution;
  final String species;
  final String height;
  final String weight;
  final List<String> abilities;
  final bool isGenderless;
  final String malePercentage;
  final String femalePercentage;
  final ChainViewModel chainViewModel;
  final List<TypeViewModel> weakTo;
  final List<TypeViewModel> immuneTo;
  final List<TypeViewModel> resistantTo;
  final List<TypeViewModel> damagedNormallyBy;
  final Map<String, String> stats;

  PokemonProfileViewModel({
    this.pokemonName,
    this.nationalPokedexNum,
    this.id,
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
    this.weakTo,
    this.immuneTo,
    this.resistantTo,
    this.damagedNormallyBy,
    this.stats,
  });
}

class TypeViewModel {
  final PokemonType type;
  final String title;
  final String effectiveness;

  TypeViewModel({
    this.type,
    this.title,
    this.effectiveness,
  });
}
