import 'package:pokedex/viewmodels/pokemon_profile_view_model.dart';

import '../usecases/pokemon_profile_response_model.dart';

class ChainViewModel {
  final bool isBaby;
  final int id;
  final String formattedId;
  final String name;
  final List<EvolutionDetailViewModel> evolutionDetails;
  final List<List<ChainViewModel>> evolvesTo;
  final List<TypeViewModel> types;

  ChainViewModel({
    this.isBaby,
    this.id,
    this.formattedId,
    this.name,
    this.evolvesTo,
    this.evolutionDetails,
    this.types,
  });
}

class EvolutionDetailViewModel {
  final String desc;
  final int minLevel;
  final Trigger trigger;
  final ItemViewModel item;
  final int minHappiness;
  final TimeOfDay timeOfDay;
  final LocationViewModel location;

  EvolutionDetailViewModel({
    this.desc,
    this.minLevel,
    this.trigger,
    this.item,
    this.minHappiness,
    this.timeOfDay,
    this.location,
  });
}

class LocationViewModel {
  final String id;
  final String name;

  LocationViewModel({this.id, this.name});
}

class ItemViewModel {
  final String id;
  final String name;

  ItemViewModel({this.id, this.name});
}
