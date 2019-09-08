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

    _viewModel = PokemonProfileViewModel(
      pokemonName: formatText(responseModel.pokemonName),
      nationalPokedexNum: '#${responseModel.nationalPokedexNum}',
      types: types,
      hasMegaEvolution: responseModel.hasMegaEvolution,
      species: formatText(responseModel.species),
      height: _formatMetricHeight(responseModel.height),
      weight: _formatMetricWeight(responseModel.weight),
      abilities: _formatAbilities(responseModel.abilities),
      isGenderless: responseModel.isGenderless,
      malePercentage: _formatPercentage(responseModel.malePercentage),
      femalePercentage: _formatPercentage(responseModel.femalePercentage),
      chainViewModel: toChainViewModel(responseModel.chain),
      hp: '${responseModel.hp}',
      atk: '${responseModel.atk}',
      def: '${responseModel.def}',
      sAtk: '${responseModel.sAtk}',
      sDef: '${responseModel.sDef}',
      spd: '${responseModel.spd}',
      weakTo: _pokemonTypesToStrings(responseModel.weakTo),
      immuneTo: _pokemonTypesToStrings(responseModel.immuneTo),
      resistantTo: _pokemonTypesToStrings(responseModel.resistantTo),
      damagedNormallyBy:
          _pokemonTypesToStrings(responseModel.damagedNormallyBy),
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
        id: formatId(chain.species.id),
        name: formatText(chain.species.name),
        evolutionDetails: chain.evolutionDetails,
        evolvesTo: chain.evolvesTo
            .map((Chain chain) => toChainViewModel(chain))
            .toList(),
      );

  Map<PokemonType, String> _pokemonTypesToStrings(List<PokemonType> weakTo) {
    return Map.fromIterable(
      weakTo,
      key: (k) => k,
      value: (v) => _pokemonTypeToString(v),
    );
  }
}
