import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/usecases/pokemon_types.dart';
import 'package:pokedex/usecases/pokemon_profile_presenter.dart';
import 'package:pokedex/usecases/pokemon_profile_response_model.dart';
import 'package:pokedex/viewmodels/pokemon_profile_view_model.dart';

void main() {
  PokemonProfilePresenter _presenter;
  Chain _chain1;
  Chain _chain2;
  Chain _chain3;
  EvolutionDetail _evolutionDetail3 = EvolutionDetail(trigger: Trigger.TRADE);
  EvolutionDetail _evolutionDetail2 = EvolutionDetail(
    minLevel: 10,
    trigger: Trigger.LEVEL_UP,
  );

  setUp(() {
    _presenter = PokemonProfilePresenter();
    _chain3 = Chain(
      isBaby: false,
      species: Species(id: 3, name: 'pokemon3'),
      evolutionDetails: [_evolutionDetail3],
      evolvesTo: [],
    );
    _chain2 = Chain(
      isBaby: false,
      species: Species(id: 2, name: 'pokemon2'),
      evolutionDetails: [_evolutionDetail2],
      evolvesTo: [_chain3],
    );
    _chain1 = Chain(
      isBaby: true,
      species: Species(id: 1, name: 'pokemon1'),
      evolutionDetails: [],
      evolvesTo: [_chain2],
    );
  });

  test("Validate id format", () {
    expect(_presenter.formatId(90), equals('#090'));
    expect(_presenter.formatId(112), equals('#112'));
    expect(_presenter.formatId(1), equals('#001'));
  });

  test("Validate text format", () {
    expect(_presenter.formatText('pokemon1'), equals('Pokemon1'));
    expect(_presenter.formatText('POKEMON'), equals('Pokemon'));
    expect(_presenter.formatText('ability one'), equals('Ability One'));
    expect(_presenter.formatText('ability one one'), equals('Ability One One'));
  });

  group('Parse a Chain to a ChainViewModel', () {
    test("Chain of level 3", () {
      var chainViewModel1 = _presenter.toChainViewModel(_chain1);

      var chainViewModel2 = chainViewModel1.evolvesTo[0];
      var chainViewModel3 = chainViewModel2.evolvesTo[0];
      var evolutionDetailVm2 = chainViewModel2.evolutionDetails[0];
      var evolutionDetailVm3 = chainViewModel3.evolutionDetails[0];
      expect(chainViewModel1.isBaby, equals(_chain1.isBaby));
      expect(chainViewModel1.name, equals('Pokemon1'));
      expect(chainViewModel1.formattedId, equals('#001'));
      expect(chainViewModel1.evolutionDetails, []);
      expect(chainViewModel2.formattedId, equals('#002'));
      expect(chainViewModel2.name, equals('Pokemon2'));
      expect(chainViewModel2.isBaby, equals(_chain2.isBaby));
      expect(evolutionDetailVm2.desc, equals('Level'));
      expect(evolutionDetailVm2.minLevel, equals(_evolutionDetail2.minLevel));
      expect(evolutionDetailVm2.trigger, equals(_evolutionDetail2.trigger));
      expect(chainViewModel3.formattedId, equals('#003'));
      expect(chainViewModel3.name, equals('Pokemon3'));
      expect(chainViewModel3.isBaby, equals(_chain3.isBaby));
      expect(evolutionDetailVm3.desc, equals('Trade'));
      expect(evolutionDetailVm3.minLevel, equals(_evolutionDetail3.minLevel));
      expect(evolutionDetailVm3.trigger, equals(_evolutionDetail3.trigger));
      expect(chainViewModel3.evolvesTo, equals([]));
    });

    test("Chain of level 2 with multi evolutions", () {
      var chain = Chain(
        isBaby: true,
        species: Species(id: 1, name: 'pokemon'),
        evolutionDetails: [],
        evolvesTo: [_chain1, _chain2, _chain3],
      );

      var chainViewModel = _presenter.toChainViewModel(chain);

      expect(chainViewModel.evolvesTo.length, equals(chain.evolvesTo.length));
      expect(chainViewModel.evolvesTo[0].formattedId, equals('#001'));
      expect(chainViewModel.evolvesTo[1].formattedId, equals('#002'));
      expect(chainViewModel.evolvesTo[2].formattedId, equals('#003'));
    });
  });

  test("Validate ViewModel", () {
    var weakTo = {PokemonType.GROUND: 2.0, PokemonType.ELECTRIC: 4.0};
    var formattedWeakTo = {'GROUND': '2x', 'ELECTRIC': '4x'};
    var immuneTo = {PokemonType.NORMAL: 0.0};
    var formattedImmuneTo = {'NORMAL': '0x'};
    var resistantTo = {PokemonType.POISON: 0.25, PokemonType.GRASS: 0.5};
    var formattedResistantTo = {'POISON': '1/4x', 'GRASS': '1/2x'};
    var damagedNormallyBy = {PokemonType.FIRE: 1.0};
    var formattedNormalDamage = {'FIRE': '1x'};
    var expectedStats = {
      'HP': '60',
      'ATK': '65',
      'DEF': '61',
      'SATK': '130',
      'SDEF': '75',
      'SPD': '110',
    };
    PokemonProfileResponseModel responseModel = PokemonProfileResponseModel(
      pokemonName: 'pokemon',
      nationalPokedexNum: 94,
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
      chain: _chain1,
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

    _presenter.present(responseModel);

    PokemonProfileViewModel vm = _presenter.viewModel;
    var chainViewModel1 = vm.chainViewModel;
    var chainViewModel2 = chainViewModel1.evolvesTo[0];
    var chainViewModel3 = chainViewModel2.evolvesTo[0];
    var evolutionDetailVm2 = chainViewModel2.evolutionDetails[0];
    var evolutionDetailVm3 = chainViewModel3.evolutionDetails[0];
    expect(vm.pokemonName, equals('Pokemon'));
    expect(vm.nationalPokedexNum, equals('#094'));
    expect(vm.id, equals(94));
    expect(vm.types[0].title, equals('GHOST'));
    expect(vm.types[1].title, equals('POISON'));
    expect(vm.hasMegaEvolution, isTrue);
    expect(vm.species, equals('Shadow'));
    expect(vm.height, equals('1.5 m'));
    expect(vm.weight, equals('40.5 kg'));
    expect(vm.abilities[0], equals('Ability One'));
    expect(vm.abilities[1], equals('Ability Two'));
    expect(vm.isGenderless, equals(responseModel.isGenderless));
    expect(vm.malePercentage, equals('70%'));
    expect(vm.femalePercentage, equals('30%'));
    expect(chainViewModel1.formattedId, equals('#00${_chain1.species.id}'));
    expect(chainViewModel1.id, equals(_chain1.species.id));
    expect(chainViewModel1.name, equals('Pokemon1'));
    expect(chainViewModel1.evolutionDetails, equals([]));
    expect(chainViewModel2.formattedId, equals('#00${_chain2.species.id}'));
    expect(chainViewModel2.id, equals(_chain2.species.id));
    expect(chainViewModel2.name, equals('Pokemon2'));
    expect(evolutionDetailVm2.desc, equals('Level'));
    expect(evolutionDetailVm2.minLevel, equals(_evolutionDetail2.minLevel));
    expect(evolutionDetailVm2.trigger, equals(_evolutionDetail2.trigger));
    expect(chainViewModel3.formattedId, equals('#00${_chain3.species.id}'));
    expect(chainViewModel3.id, equals(_chain3.species.id));
    expect(chainViewModel3.name, equals('Pokemon3'));
    expect(evolutionDetailVm3.desc, equals('Trade'));
    expect(evolutionDetailVm3.trigger, equals(_evolutionDetail3.trigger));
    expect(evolutionDetailVm3.minLevel, equals(_evolutionDetail3.minLevel));
    expect(vm.stats, equals(expectedStats));
    for (var i = 0; i < weakTo.length; i++) {
      expect(vm.weakTo[i].type, equals(weakTo.keys.elementAt(i)));
      expect(vm.weakTo[i].title, equals(formattedWeakTo.keys.elementAt(i)));
      expect(vm.weakTo[i].effectiveness, formattedWeakTo.values.elementAt(i));
    }

    for (var i = 0; i < immuneTo.length; i++) {
      expect(vm.immuneTo[i].type, equals(immuneTo.keys.elementAt(i)));
      expect(vm.immuneTo[i].title, equals(formattedImmuneTo.keys.elementAt(i)));
      expect(
        vm.immuneTo[i].effectiveness,
        formattedImmuneTo.values.elementAt(i),
      );
    }

    for (var i = 0; i < resistantTo.length; i++) {
      expect(vm.resistantTo[i].type, equals(resistantTo.keys.elementAt(i)));
      expect(
        vm.resistantTo[i].title,
        equals(formattedResistantTo.keys.elementAt(i)),
      );
      expect(
        vm.resistantTo[i].effectiveness,
        formattedResistantTo.values.elementAt(i),
      );
    }

    for (var i = 0; i < damagedNormallyBy.length; i++) {
      expect(
        vm.damagedNormallyBy[i].type,
        equals(damagedNormallyBy.keys.elementAt(i)),
      );
      expect(
        vm.damagedNormallyBy[i].title,
        equals(formattedNormalDamage.keys.elementAt(i)),
      );
      expect(
        vm.damagedNormallyBy[i].effectiveness,
        formattedNormalDamage.values.elementAt(i),
      );
    }
  });
}
