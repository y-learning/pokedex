import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/usecases/pokemon_types.dart';
import 'package:pokedex/usecases/pokemon_profile_presenter.dart';
import 'package:pokedex/usecases/pokemon_profile_response_model.dart';
import 'package:pokedex/viewmodels/pokemon_profile_view_model.dart';

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
    var weakTo = {PokemonType.GROUND: 2.0, PokemonType.ELECTRIC: 4.0};
    var immuneTo = {PokemonType.NORMAL: 0.0};
    var resistantTo = {PokemonType.POISON: 0.25, PokemonType.GRASS: 0.5};
    var damagedNormallyBy = {PokemonType.FIRE: 1.0};
    PokemonProfileResponseModel responseModel = PokemonProfileResponseModel(
      pokemonName: 'pokemon',
      nationalPokedexNum: '094',
      types: [PokemonType.GHOST, PokemonType.POISON],
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
      weakTo: weakTo,
      immuneTo: immuneTo,
      resistantTo: resistantTo,
      damagedNormallyBy: damagedNormallyBy,
    );

    presenter.present(responseModel);

    PokemonProfileViewModel vm = presenter.viewModel;
    var chainViewModel1 = vm.chainViewModel;
    var chainViewModel2 = chainViewModel1.evolvesTo[0];
    var chainViewModel3 = chainViewModel2.evolvesTo[0];
    expect(vm.pokemonName, equals('Pokemon'));
    expect(vm.nationalPokedexNum, equals('#094'));
    expect(vm.types[0], equals('GHOST'));
    expect(vm.types[1], equals('POISON'));
    expect(vm.hasMegaEvolution, isTrue);
    expect(vm.species, equals('Shadow'));
    expect(vm.height, equals('1.5 m'));
    expect(vm.weight, equals('40.5 kg'));
    expect(vm.abilities[0], equals('Ability One'));
    expect(vm.abilities[1], equals('Ability Two'));
    expect(vm.isGenderless, equals(responseModel.isGenderless));
    expect(vm.malePercentage, equals('70%'));
    expect(vm.femalePercentage, equals('30%'));
    expect(chainViewModel1.id, equals('#00${chain1.species.id}'));
    expect(chainViewModel1.name, equals('Pokemon1'));
    expect(chainViewModel1.evolutionDetails, equals(chain1.evolutionDetails));
    expect(chainViewModel2.id, equals('#00${chain2.species.id}'));
    expect(chainViewModel2.name, equals('Pokemon2'));
    expect(chainViewModel2.evolutionDetails, equals(chain2.evolutionDetails));
    expect(chainViewModel3.id, equals('#00${chain3.species.id}'));
    expect(chainViewModel3.name, equals('Pokemon3'));
    expect(chainViewModel3.evolutionDetails, equals(chain3.evolutionDetails));
    expect(vm.hp, equals('60'));
    expect(vm.atk, equals('65'));
    expect(vm.def, equals('61'));
    expect(vm.sAtk, equals('130'));
    expect(vm.sDef, equals('75'));
    expect(vm.spd, equals('110'));
    expect(vm.weakTo.length, equals(weakTo.length));
    expect(vm.weakTo[0].type, equals(weakTo.keys.first));
    expect(vm.weakTo[0].title, equals('GROUND'));
    expect(vm.weakTo[0].effectiveness, equals('2x'));
    expect(vm.weakTo[1].type, equals(weakTo.keys.elementAt(1)));
    expect(vm.weakTo[1].title, equals('ELECTRIC'));
    expect(vm.weakTo[1].effectiveness, equals('4x'));
    expect(vm.immuneTo[0].type, equals(immuneTo.keys.first));
    expect(vm.immuneTo[0].title, equals('NORMAL'));
    expect(vm.immuneTo[0].effectiveness, equals('0x'));
    expect(vm.resistantTo[0].type, equals(resistantTo.keys.first));
    expect(vm.resistantTo[0].title, equals('POISON'));
    expect(vm.resistantTo[0].effectiveness, equals('1/4x'));
    expect(vm.resistantTo[1].type, equals(resistantTo.keys.elementAt(1)));
    expect(vm.resistantTo[1].title, equals('GRASS'));
    expect(vm.resistantTo[1].effectiveness, equals('1/2x'));
    expect(vm.damagedNormallyBy[0].type, equals(damagedNormallyBy.keys.first));
    expect(vm.damagedNormallyBy[0].title, equals('FIRE'));
    expect(vm.damagedNormallyBy[0].effectiveness, equals('1x'));
  });
}
