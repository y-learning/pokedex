import 'package:pokedex/usecases/pokemon_profile_response_model.dart';
import 'package:pokedex/viewmodels/chain_view_model.dart';

String pokemonImage(String id) => 'images/pokemons/$id.gif';

String itemImage(String itemId) => 'images/items/$itemId.png';

String getTriggerIconAsset(EvolutionDetailViewModel evolutionDetailVm) {
  switch (evolutionDetailVm.trigger) {
    case Trigger.LEVEL_UP:
      if (evolutionDetailVm.minHappiness != null) {
        switch (evolutionDetailVm.timeOfDay) {
          case TimeOfDay.DAY:
            return 'images/evolution_icons/happiness_daytime.png';
          case TimeOfDay.NIGHT:
            return 'images/evolution_icons/happiness_nighttime.png';
        }
        break;
      } else if (evolutionDetailVm.location != null) {
        return 'images/evolution_icons/lvl_${evolutionDetailVm.location.id}.png';
      }
      return 'images/evolution_icons/l${evolutionDetailVm.minLevel}.png';
    case Trigger.TRADE:
      return 'images/evolution_icons/trade.png';
    case Trigger.USE_ITEM:
      return itemImage(evolutionDetailVm.item.id);
    default:
      return 'No asset yet!!';
  }
}
