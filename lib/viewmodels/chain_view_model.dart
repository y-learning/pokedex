import '../usecases/pokemon_profile_response_model.dart';

class ChainViewModel {
  final bool isBaby;
  final int id;
  final String formattedId;
  final String name;
  final List<EvolutionDetailViewModel> evolutionDetails;
  final List<ChainViewModel> evolvesTo;

  ChainViewModel({
    this.isBaby,
    this.id,
    this.formattedId,
    this.name,
    this.evolvesTo,
    this.evolutionDetails,
  });
}

class EvolutionDetailViewModel {
  final String desc;
  final int minLevel;
  final Trigger trigger;

  EvolutionDetailViewModel({this.desc, this.minLevel, this.trigger});
}
