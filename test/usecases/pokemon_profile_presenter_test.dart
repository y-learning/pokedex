import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/pokemon_types.dart';

void main() {
  PokemonProfilePresenter presenter;
  Chain chain1;
  Chain chain2;
  Chain chain3;

  setUp(() {
    presenter = PokemonProfilePresenter();
    chain3 = Chain(
      isBaby: false,
      species: Species(id: 3, name: 'pokemon3'),
      evolutionDetails: [EvolutionDetail(minLevel: 30)],
      evolvesTo: [],
    );
    chain2 = Chain(
      isBaby: false,
      species: Species(id: 2, name: 'pokemon2'),
      evolutionDetails: [EvolutionDetail(minLevel: 10)],
      evolvesTo: [chain3],
    );
    chain1 = Chain(
      isBaby: true,
      species: Species(id: 1, name: 'pokemon1'),
      evolutionDetails: [],
      evolvesTo: [chain2],
    );
  });

  test("Validate id format", () {
    expect(presenter.formatId(90), equals('#090'));
    expect(presenter.formatId(112), equals('#112'));
    expect(presenter.formatId(1), equals('#001'));
  });

  test("Validate text format", () {
    expect(presenter.formatText('pokemon1'), equals('Pokemon1'));
    expect(presenter.formatText('POKEMON'), equals('Pokemon'));
    expect(presenter.formatText('ability one'), equals('Ability One'));
    expect(presenter.formatText('ability one one'), equals('Ability One One'));
  });

  group('Parse a Chain to a ChainViewModel', () {
    test("Chain of level 3", () {
      var chainViewModel1 = presenter.toChainViewModel(chain1);

      var chainViewModel2 = chainViewModel1.evolvesTo[0];
      var chainViewModel3 = chainViewModel2.evolvesTo[0];
      expect(chainViewModel1.isBaby, equals(chain1.isBaby));
      expect(chainViewModel1.name, equals('Pokemon1'));
      expect(chainViewModel1.id, equals('#001'));
      expect(chainViewModel1.evolutionDetails, chain1.evolutionDetails);
      expect(chainViewModel2.id, equals('#002'));
      expect(chainViewModel2.name, equals('Pokemon2'));
      expect(chainViewModel2.isBaby, equals(chain2.isBaby));
      expect(chainViewModel2.evolutionDetails, equals(chain2.evolutionDetails));
      expect(chainViewModel3.id, equals('#003'));
      expect(chainViewModel3.name, equals('Pokemon3'));
      expect(chainViewModel3.isBaby, equals(chain3.isBaby));
      expect(chainViewModel3.evolutionDetails, equals(chain3.evolutionDetails));
      expect(chainViewModel3.evolvesTo, equals([]));
    });

    test("Chain of level 2 with multi evolutions", () {
      var chain = Chain(
        isBaby: true,
        species: Species(id: 1, name: 'pokemon'),
        evolutionDetails: [],
        evolvesTo: [chain1, chain2, chain3],
      );

      var chainViewModel = presenter.toChainViewModel(chain);

      expect(chainViewModel.evolvesTo.length, equals(chain.evolvesTo.length));
      expect(chainViewModel.evolvesTo[0].id, equals('#001'));
      expect(chainViewModel.evolvesTo[1].id, equals('#002'));
      expect(chainViewModel.evolvesTo[2].id, equals('#003'));
    });
  });

  test("Validate ViewModel", () {
    PokemonProfileResponseModel responseModel = PokemonProfileResponseModel(
      pokemonName: 'pokemon',
      nationalPokedexNum: '094',
      types: [PokemonTypes.GHOST, PokemonTypes.POISON],
      hasMegaEvolution: true,
      species: 'shadow',
      height: 1.5,
      weight: 40.5,
      isMetricSystem: true,
      abilities: ['ability one', 'ability two'],
      isGenderless: false,
      malePercentage: 0.7,
      femalePercentage: 0.3,
      chain: chain1,
      hp: 60,
      atk: 65,
      def: 61,
      sAtk: 130,
      sDef: 75,
      spd: 110,
    );

    presenter.present(responseModel);

    PokemonProfileViewModel viewModel = presenter.viewModel;
    var chainViewModel1 = viewModel.chainViewModel;
    var chainViewModel2 = chainViewModel1.evolvesTo[0];
    var chainViewModel3 = chainViewModel2.evolvesTo[0];
    expect(viewModel.pokemonName, equals('Pokemon'));
    expect(viewModel.nationalPokedexNum, equals('#094'));
    expect(viewModel.types[0], equals('GHOST'));
    expect(viewModel.types[1], equals('POISON'));
    expect(viewModel.hasMegaEvolution, isTrue);
    expect(viewModel.species, equals('Shadow'));
    expect(viewModel.height, equals('1.5 m'));
    expect(viewModel.weight, equals('40.5 kg'));
    expect(viewModel.abilities[0], equals('Ability One'));
    expect(viewModel.abilities[1], equals('Ability Two'));
    expect(viewModel.isGenderless, equals(responseModel.isGenderless));
    expect(viewModel.malePercentage, equals('70%'));
    expect(viewModel.femalePercentage, equals('30%'));
    expect(chainViewModel1.id, equals('#00${chain1.species.id}'));
    expect(chainViewModel1.name, equals('Pokemon1'));
    expect(chainViewModel1.evolutionDetails, equals(chain1.evolutionDetails));
    expect(chainViewModel2.id, equals('#00${chain2.species.id}'));
    expect(chainViewModel2.name, equals('Pokemon2'));
    expect(chainViewModel2.evolutionDetails, equals(chain2.evolutionDetails));
    expect(chainViewModel3.id, equals('#00${chain3.species.id}'));
    expect(chainViewModel3.name, equals('Pokemon3'));
    expect(chainViewModel3.evolutionDetails, equals(chain3.evolutionDetails));
    expect(viewModel.hp, equals('60'));
    expect(viewModel.atk, equals('65'));
    expect(viewModel.def, equals('61'));
    expect(viewModel.sAtk, equals('130'));
    expect(viewModel.sDef, equals('75'));
    expect(viewModel.spd, equals('110'));
  });
}

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

  String _pokemonTypeToString(PokemonTypes type) =>
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
}

class PokemonProfileViewModel {
  final String pokemonName;
  final String nationalPokedexNum;
  final List<String> types;
  final bool hasMegaEvolution;
  final String species;
  final String height;
  final String weight;
  final List<String> abilities;
  final bool isGenderless;
  final String malePercentage;
  final String femalePercentage;
  final ChainViewModel chainViewModel;
  final String hp;
  final String atk;
  final String def;
  final String sAtk;
  final String sDef;
  final String spd;

  PokemonProfileViewModel({
    this.pokemonName,
    this.nationalPokedexNum,
    this.types,
    this.hasMegaEvolution,
    this.species,
    this.height,
    this.weight,
    this.abilities,
    this.isGenderless,
    this.malePercentage,
    this.femalePercentage,
    this.chainViewModel,
    this.hp,
    this.atk,
    this.def,
    this.sAtk,
    this.sDef,
    this.spd,
  });
}

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

class PokemonProfileResponseModel {
  final String pokemonName;
  final String nationalPokedexNum;
  final List<PokemonTypes> types;
  final bool hasMegaEvolution;
  final String species;
  final double height;
  final bool isMetricSystem;
  final double weight;
  final List<String> abilities;
  final bool isGenderless;
  final double malePercentage;
  final double femalePercentage;
  final Chain chain;
  final int hp;
  final int atk;
  final int def;
  final int sAtk;
  final int sDef;
  final int spd;

  PokemonProfileResponseModel({
    this.pokemonName,
    this.nationalPokedexNum,
    this.types,
    this.hasMegaEvolution,
    this.species,
    this.height,
    this.isMetricSystem,
    this.weight,
    this.abilities,
    this.isGenderless,
    this.malePercentage,
    this.femalePercentage,
    this.chain,
    this.hp,
    this.atk,
    this.def,
    this.sAtk,
    this.sDef,
    this.spd,
  });
}

class Chain {
  final bool isBaby;
  final Species species;
  final List<EvolutionDetail> evolutionDetails;
  final List<Chain> evolvesTo;

  Chain({this.isBaby, this.species, this.evolvesTo, this.evolutionDetails});
}

class Species {
  int id;
  String name;

  Species({this.id, this.name});
}

class EvolutionDetail {
  final int minLevel;
  final Trigger trigger;

  EvolutionDetail({this.minLevel, this.trigger});
}

enum Trigger {
  LEVEL_UP,
  TRADE,
//  USE_ITEM,
//  SHED,
}
