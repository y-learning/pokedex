import 'pokemon_types.dart';

class PokemonProfileResponseModel {
  final String pokemonName;
  final String nationalPokedexNum;
  final List<PokemonType> types;
  final bool hasMegaEvolution;
  final String species;
  final double height;
  final bool isMetricSystem;
  final double weight;
  final List<String> abilities;
  final bool isGenderless;
  final double malePercentage;
  final double femalePercentage;
  final Chain chain;
  final int hp;
  final int atk;
  final int def;
  final int sAtk;
  final int sDef;
  final int spd;
  final List<PokemonType> weakTo;
  final List<PokemonType> immuneTo;
  final List<PokemonType> resistantTo;
  final List<PokemonType> damagedNormallyBy;

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
