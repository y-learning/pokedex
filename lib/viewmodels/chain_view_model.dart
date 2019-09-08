import 'package:pokedex/usecases/pokemon_profile_response_model.dart';

class ChainViewModel {
  final bool isBaby;
  final String id;
  final String name;
  final List<EvolutionDetail> evolutionDetails;
  final List<ChainViewModel> evolvesTo;

  ChainViewModel({
    this.isBaby,
    this.id,
    this.name,
    this.evolvesTo,
    this.evolutionDetails,
  });
}
