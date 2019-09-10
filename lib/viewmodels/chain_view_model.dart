import 'package:pokedex/usecases/pokemon_profile_response_model.dart';

class ChainViewModel {
  final bool isBaby;
  final int id;
  final String formattedId;
  final String name;
  final List<EvolutionDetail> evolutionDetails;
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
