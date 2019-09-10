import 'package:pokedex/usecases/pokemon_profile_response_model.dart';
import 'package:pokedex/viewmodels/chain_view_model.dart';
import 'package:pokedex/viewmodels/pokemon_profile_view_model.dart';

import 'pokemon_types.dart';

class PokemonProfilePresenter {
  PokemonProfileViewModel _viewModel;

  PokemonProfileViewModel get viewModel => _viewModel;

  void present(PokemonProfileResponseModel responseModel) {
    List<String> types = [];
    for (var type in responseModel.types) types.add(_pokemonTypeToString(type));

    Map<String, String> stats = {};
    stats['HP'] = '${responseModel.hp}';
    stats['ATK'] = '${responseModel.atk}';
    stats['DEF'] = '${responseModel.def}';
    stats['SATK'] = '${responseModel.sAtk}';
    stats['SDEF'] = '${responseModel.sDef}';
    stats['SPD'] = '${responseModel.spd}';
    _viewModel = PokemonProfileViewModel(
      pokemonName: formatText(responseModel.pokemonName),
      nationalPokedexNum: formatId(responseModel.nationalPokedexNum),
      types: responseModel.types
          .map((type) => TypeViewModel(
                type: type,
                title: _pokemonTypeToString(type),
              ))
          .toList(),
      hasMegaEvolution: responseModel.hasMegaEvolution,
      species: formatText(responseModel.species),
      height: _formatMetricHeight(responseModel.height),
      weight: _formatMetricWeight(responseModel.weight),
      abilities: _formatAbilities(responseModel.abilities),
      isGenderless: responseModel.isGenderless,
      malePercentage: _formatPercentage(responseModel.malePercentage),
      femalePercentage: _formatPercentage(responseModel.femalePercentage),
      chainViewModel: toChainViewModel(responseModel.chain),
      stats: stats,
      hp: '${responseModel.hp}',
      atk: '${responseModel.atk}',
      def: '${responseModel.def}',
      sAtk: '${responseModel.sAtk}',
      sDef: '${responseModel.sDef}',
      spd: '${responseModel.spd}',
      weakTo: _toTypeEffectivenessViewModels(responseModel.weakTo),
      immuneTo: _toTypeEffectivenessViewModels(responseModel.immuneTo),
      resistantTo: _toTypeEffectivenessViewModels(responseModel.resistantTo),
      damagedNormallyBy:
          _toTypeEffectivenessViewModels(responseModel.damagedNormallyBy),
    );
  }

  List<String> _formatAbilities(List<String> abilities) {
    for (var i = 0; i < abilities.length; i++)
      abilities[i] = formatText(abilities[i]);

    return abilities;
  }

  String formatId(int id) => '#${id.toString().padLeft(3, '0')}';

  formatText(String text) {
    var formattedText = '';

    for (var word in text.split(' '))
      formattedText +=
          '${word[0].toUpperCase()}${word.substring(1).toLowerCase()} ';

    return formattedText.trim();
  }

  String _pokemonTypeToString(PokemonType type) =>
      type.toString().split('.')[1];

  String _formatMetricHeight(double height) => '$height m';

  String _formatMetricWeight(double weight) => '$weight kg';

  String _formatPercentage(double malePercentage) =>
      '${(malePercentage * 100).round()}%';

  ChainViewModel toChainViewModel(Chain chain) => ChainViewModel(
        isBaby: chain.isBaby,
        id: chain.species.id,
        formattedId: formatId(chain.species.id),
        name: formatText(chain.species.name),
        evolutionDetails: chain.evolutionDetails,
        evolvesTo: chain.evolvesTo
            .map((Chain chain) => toChainViewModel(chain))
            .toList(),
      );

  List<TypeViewModel> _toTypeEffectivenessViewModels(
      Map<PokemonType, double> types) {
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
}
