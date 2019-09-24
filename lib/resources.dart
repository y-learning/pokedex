import 'package:pokedex/usecases/pokemon_profile_response_model.dart';
import 'package:pokedex/viewmodels/chain_view_model.dart';

String pokemonImage(String id) => 'images/pokemons/$id.gif';

String itemImage(String itemId) => 'images/items/$itemId.png';

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
