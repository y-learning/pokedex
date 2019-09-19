import 'pokemon_types.dart';

class PokemonProfileResponseModel {
  final String pokemonName;
  final int nationalPokedexNum;
  final List<PokemonType> types;
  final bool hasMegaEvolution;
  final String species;
  final double height;
  final bool isMetricSystem;
  final double weight;
  final List<Ability> abilities;
  final bool isGenderless;
  final double malePercentage;
  final double femalePercentage;
  final Chain chain;
  final List<Stat> stats;
  final Map<PokemonType, double> weakTo;
  final Map<PokemonType, double> immuneTo;
  final Map<PokemonType, double> resistantTo;
  final Map<PokemonType, double> damagedNormallyBy;

  PokemonProfileResponseModel({
    this.pokemonName,
    this.nationalPokedexNum,
    this.types,
    this.hasMegaEvolution,
    this.species,
    this.height,
    this.isMetricSystem,
    this.weight,
    this.abilities,
    this.isGenderless,
    this.malePercentage,
    this.femalePercentage,
    this.chain,
    this.stats,
    this.weakTo,
    this.immuneTo,
    this.resistantTo,
    this.damagedNormallyBy,
  });
}

class Chain {
  final bool isBaby;
  final Species species;
  final List<EvolutionDetail> evolutionDetails;
  final List<Chain> evolvesTo;

  Chain({this.isBaby, this.species, this.evolvesTo, this.evolutionDetails});
}

class Species {
  int id;
  String name;

  Species({this.id, this.name});
}

class EvolutionDetail {
  final int minLevel;
  final Trigger trigger;

  EvolutionDetail({this.minLevel, this.trigger});
}

enum Trigger {
  LEVEL_UP,
  TRADE,
//  USE_ITEM,
//  SHED,
}

class Stat {
  final BaseStat baseStat;
  final int value;
  final int min;
  final int max;

  Stat({this.baseStat, this.value, this.min, this.max});
}

enum BaseStat {
  HP,
  ATK,
  DEF,
  SATK,
  SDEF,
  SPD,
}

class Ability {
  String title;
  final bool isHidden;

  Ability({this.title, this.isHidden});
}
