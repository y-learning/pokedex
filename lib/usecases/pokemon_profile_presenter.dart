import 'package:pokedex/usecases/pokemon_profile_response_model.dart';
import 'package:pokedex/viewmodels/base_stat_view_model.dart';
import 'package:pokedex/viewmodels/chain_view_model.dart';
import 'package:pokedex/viewmodels/pokemon_profile_view_model.dart';

import 'pokemon_types.dart';

class PokemonProfilePresenter {
  PokemonProfileViewModel _viewModel;

  PokemonProfileViewModel get viewModel => _viewModel;

  void present(PokemonProfileResponseModel responseModel) {
    var malePercentage;
    var femalePercentage;
    if (!responseModel.isGenderless) {
      if (responseModel.malePercentage != null)
        malePercentage = formatPercentage(responseModel.malePercentage);

      if (responseModel.femalePercentage != null)
        femalePercentage = formatPercentage(responseModel.femalePercentage);
    }
    _viewModel = PokemonProfileViewModel(
      pokemonName: formatText(responseModel.pokemonName),
      id: responseModel.nationalPokedexNum,
      nationalPokedexNum: formatId(responseModel.nationalPokedexNum),
      types: _typesToTypeViewModels(responseModel.types),
      hasMegaEvolution: responseModel.hasMegaEvolution,
      species: formatText(responseModel.species),
      height: _formatMetricHeight(responseModel.height),
      weight: _formatMetricWeight(responseModel.weight),
      abilities: _formatAbilities(responseModel.abilities),
      isGenderless: responseModel.isGenderless,
      malePercentage: malePercentage,
      femalePercentage: femalePercentage,
      chainViewModel: toChainViewModel(responseModel.chain),
      stats: _statsToBaseStatsViewModels(responseModel.stats),
      totalStats: {'TOTAL': _calculateStatsTotal(responseModel.stats)},
      weakTo: _toTypeViewModels(responseModel.weakTo),
      immuneTo: _toTypeViewModels(responseModel.immuneTo),
      resistantTo: _toTypeViewModels(responseModel.resistantTo),
      damagedNormallyBy: _toTypeViewModels(responseModel.damagedNormallyBy),
    );
  }

  String formatPercentage(double percentage) {
    var n = (percentage * 100);
    return '${n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1)}%';
  }

  String formatId(int id) => '#${id.toString().padLeft(3, '0')}';

  List<TypeViewModel> _typesToTypeViewModels(List<PokemonType> types) => types
      .map((type) => TypeViewModel(
            type: type,
            title: _pokemonTypeToString(type),
          ))
      .toList();

  String _formatMetricHeight(double height) => '$height m';

  String _formatMetricWeight(double weight) => '$weight kg';

  List<Ability> _formatAbilities(List<Ability> abilities) {
    for (var i = 0; i < abilities.length; i++)
      abilities[i].title = formatText(abilities[i].title);

    return abilities;
  }

  formatText(String text) {
    var formattedText = '';

    for (var word in text.split(' '))
      formattedText +=
          '${word[0].toUpperCase()}${word.substring(1).toLowerCase()} ';

    return formattedText.trim();
  }

  ChainViewModel toChainViewModel(Chain chain) => ChainViewModel(
        isBaby: chain.isBaby,
        id: chain.species.id,
        formattedId: formatId(chain.species.id),
        name: formatText(chain.species.name),
        evolutionDetails: _toEvolutionDetailsViewModels(chain.evolutionDetails),
        evolvesTo: groupBy(chain),
        types: _typesToTypeViewModels(chain.species.types),
      );

  List<EvolutionDetailViewModel> _toEvolutionDetailsViewModels(
      List<EvolutionDetail> evolutionDetails) {
    return evolutionDetails
        .map((evolutionDetail) => EvolutionDetailViewModel(
              desc: _formatTrigger(evolutionDetail),
              minLevel: evolutionDetail.minLevel,
              trigger: evolutionDetail.trigger,
              minHappiness: evolutionDetail.minHappiness,
              timeOfDay: evolutionDetail.timeOfDay,
              location: evolutionDetail.location == null
                  ? null
                  : LocationViewModel(
                      id: _formatResourceId(evolutionDetail.location.id),
                      name: evolutionDetail.location.name,
                    ),
              item: evolutionDetail.item == null
                  ? null
                  : ItemViewModel(
                      id: _formatResourceId(evolutionDetail.item.id),
                      name: evolutionDetail.item.name,
                    ),
            ))
        .toList();
  }

  String _formatResourceId(String id) => id.replaceAll('-', '_');

  String _formatTrigger(EvolutionDetail evolutionDetail) {
    String desc;
    switch (evolutionDetail.trigger) {
      case Trigger.LEVEL_UP:
        if (evolutionDetail.minHappiness != null) {
          desc = 'High Friendship';
          switch (evolutionDetail.timeOfDay) {
            case TimeOfDay.DAY:
              desc = _concatenateWords(desc, 'Daytime');
              break;
            case TimeOfDay.NIGHT:
              desc = _concatenateWords(desc, 'Nighttime');
              break;
          }
          break;
        } else if (evolutionDetail.location != null) {
          desc = 'Level up near ${evolutionDetail.location.name}';
          break;
        }

        desc = 'Level';
        break;
      case Trigger.TRADE:
        desc = 'Trade';
        break;
      case Trigger.USE_ITEM:
        desc = evolutionDetail.item.name;
        break;
    }

    return desc;
  }

  String _concatenateWords(String word1, String word2) => '$word1, $word2';

  List<BaseStatViewModel> _statsToBaseStatsViewModels(List<Stat> stats) {
    return stats
        .map((stat) => BaseStatViewModel(
              label: stat.baseStat.toString().split('.')[1],
              value: stat.value,
              min: 'min.${stat.min}',
              max: 'max.${stat.max}',
            ))
        .toList();
  }

  int _calculateStatsTotal(List<Stat> stats) =>
      stats.fold<int>(0, (total, stat) => total + stat.value);

  List<TypeViewModel> _toTypeViewModels(Map<PokemonType, double> types) {
    List<TypeViewModel> list = [];

    types.forEach((k, v) => list.add(
          TypeViewModel(
            type: k,
            title: _pokemonTypeToString(k),
            effectiveness: _formatEffectivenessValue(v),
          ),
        ));

    return list;
  }

  String _pokemonTypeToString(PokemonType type) =>
      type.toString().split('.')[1];

  String _formatEffectivenessValue(double effectivenessValue) {
    var formatted = '';
    switch ((effectivenessValue * 100).round()) {
      case 0:
        formatted = '0x';
        break;
      case 25:
        formatted = '1/4x';
        break;
      case 50:
        formatted = '1/2x';
        break;
      case 100:
        formatted = '1x';
        break;
      case 200:
        formatted = '2x';
        break;
      case 400:
        formatted = '4x';
        break;
    }

    return formatted;
  }

  List<List<ChainViewModel>> groupBy(Chain chain) {
    var evolvesTo = chain.evolvesTo;
    List<List<ChainViewModel>> groups = [];

    if (evolvesTo.isEmpty) return groups;

    if (evolvesTo.length <= 3) {
      groups.add([for (var chain in evolvesTo) toChainViewModel(chain)]);

      return groups;
    }

    for (var i = 0; i < evolvesTo.length; i++) {
      var evolution = evolvesTo[i];

      if (!_contains(groups, evolution)) {
        List<ChainViewModel> list = [toChainViewModel(evolution)];
        for (var j = i + 1; j < evolvesTo.length; j++) {
          if (_areSameGroup(evolution, evolvesTo[j])) {
            list.add(toChainViewModel(evolvesTo[j]));
          }
        }
        if (list.isNotEmpty) groups.add(list);
      }
    }

    return groups;
  }

  bool _areSameGroup(Chain evolution1, Chain evolution2) {
    var evolutionDetail1 = evolution1.evolutionDetails[0];
    var evolutionDetail2 = evolution2.evolutionDetails[0];

    if (evolutionDetail1.trigger != evolutionDetail2.trigger) return false;

    if ((evolutionDetail1.location == null ||
            evolutionDetail2.location == null) &&
        (evolutionDetail1.location != null ||
            evolutionDetail2.location != null)) return false;

    if ((evolutionDetail1.item == null || evolutionDetail2.item == null) &&
        (evolutionDetail1.item != null || evolutionDetail2.item != null))
      return false;

    if ((evolutionDetail1.minHappiness == null ||
            evolutionDetail2.minHappiness == null) &&
        (evolutionDetail1.minHappiness != null ||
            evolutionDetail2.minHappiness != null)) return false;

    if ((evolutionDetail1.timeOfDay == null ||
            evolutionDetail2.timeOfDay == null) &&
        (evolutionDetail1.timeOfDay != null ||
            evolutionDetail2.timeOfDay != null)) return false;

    if ((evolutionDetail1.minLevel == null ||
            evolutionDetail2.minLevel == null) &&
        (evolutionDetail1.minLevel != null ||
            evolutionDetail2.minLevel != null)) return false;

    return true;
  }

  bool _contains(List<List<ChainViewModel>> groups, Chain evolution) {
    if (groups.isEmpty) return false;

    for (var group in groups)
      for (var e in group) if (e.id == evolution.species.id) return true;

    return false;
  }
}
