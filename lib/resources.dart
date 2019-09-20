import 'package:pokedex/usecases/pokemon_profile_response_model.dart';
import 'package:pokedex/viewmodels/chain_view_model.dart';

String pokemonImage(String id) => 'images/pokemons/$id.gif';

String itemImage(int pokemonId) => 'images/items/${pokemonId}_megastone.png';

String getTriggerIconAsset(EvolutionDetailViewModel evolutionDetailVm) {
  switch (evolutionDetailVm.trigger) {
    case Trigger.LEVEL_UP:
      return 'l${evolutionDetailVm.minLevel}.png';
    case Trigger.TRADE:
      return 'trade.png';
    default:
      return '';
  }
}
