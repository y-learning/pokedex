import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/usecases/pokemon_types.dart';
import 'package:pokedex/usecases/pokemon_profile_presenter.dart';
import 'package:pokedex/usecases/pokemon_profile_response_model.dart';
import 'package:pokedex/viewmodels/base_stat_view_model.dart';
import 'package:pokedex/viewmodels/chain_view_model.dart';
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
      species: Species(
        id: 3,
        name: 'pokemon3',
        types: [PokemonType.GHOST, PokemonType.POISON],
      ),
      evolutionDetails: [_evolutionDetail3],
      evolvesTo: [],
    );
    _chain2 = Chain(
      isBaby: false,
      species: Species(
        id: 2,
        name: 'pokemon2',
        types: [PokemonType.GHOST, PokemonType.POISON],
      ),
      evolutionDetails: [_evolutionDetail2],
      evolvesTo: [_chain3],
    );
    _chain1 = Chain(
      isBaby: true,
      species: Species(
        id: 1,
        name: 'pokemon1',
        types: [PokemonType.GHOST, PokemonType.POISON],
      ),
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

  test("Validate gender percentage", () {
    expect(_presenter.formatPercentage(0.7), equals('70%'));
    expect(_presenter.formatPercentage(0.875), equals('87.5%'));
    expect(_presenter.formatPercentage(0.01), equals('1%'));
  });

  group('Parse a Chain to a ChainViewModel', () {
    test("Validate a Chain of level 3", () {
      var chainViewModel1 = _presenter.toChainViewModel(_chain1);

      ChainViewModel chainViewModel2 = chainViewModel1.evolvesTo.first.first;
      ChainViewModel chainViewModel3 = chainViewModel2.evolvesTo.first.first;
      var evolutionDetailVm2 = chainViewModel2.evolutionDetails[0];
      var evolutionDetailVm3 = chainViewModel3.evolutionDetails[0];
      expect(chainViewModel1.isBaby, equals(_chain1.isBaby));
      expect(chainViewModel1.name, equals('Pokemon1'));
      expect(chainViewModel1.formattedId, equals('#001'));
      expect(chainViewModel1.evolutionDetails, []);
      expect(chainViewModel1.evolutionDetails, []);
      expect(chainViewModel1.types[0].title, equals('GHOST'));
      expect(chainViewModel1.types[1].title, equals('POISON'));

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

    test("Validate a Chain of level 2 with multi evolutions", () {
      var chain = Chain(
        isBaby: true,
        species: Species(id: 1, name: 'pokemon', types: [PokemonType.GHOST]),
        evolutionDetails: [],
        evolvesTo: [_chain1, _chain2, _chain3],
      );

      var chainViewModel = _presenter.toChainViewModel(chain);
      var evolutions = chainViewModel.evolvesTo[0];

      expect(evolutions.length, equals(chain.evolvesTo.length));
      expect(evolutions[0].formattedId, equals('#001'));
      expect(evolutions[1].formattedId, equals('#002'));
      expect(evolutions[2].formattedId, equals('#003'));
    });

    group('Group by triggers', () {
      test("when a chain has no evolutions, return empty list", () {
        List<List<ChainViewModel>> groups = _presenter.groupBy(_chain3);

        expect(groups.isEmpty, equals(true));
      });

      test("when a chain has 1 evolution, return one group", () {
        List<List<ChainViewModel>> groups = _presenter.groupBy(_chain1);

        expect(groups.length, equals(1));
        expect(groups[0].length, equals(1));
      });

      test("when a chain has 2 evolutions, return one group", () {
        var chain = Chain(
          isBaby: true,
          species: Species(id: 1, name: 'pokemon'),
          evolutionDetails: [],
          evolvesTo: [_chain1, _chain2],
        );

        List<List<ChainViewModel>> groups = _presenter.groupBy(chain);

        expect(groups.length, equals(1));
      });

      test(
        "when a chain has 3 evolutions, return one group",
        () {
          var chain = Chain(
            isBaby: true,
            species: Species(id: 1, name: 'pokemon'),
            evolutionDetails: [],
            evolvesTo: [_chain1, _chain2, _chain3],
          );

          List<List<ChainViewModel>> groups = _presenter.groupBy(chain);

          expect(groups.length, equals(1));
        },
      );

      test(
        "when a chain has more than 3 evolutions, group them by trigger",
        () {
          var evolution1 = Chain(
            isBaby: false,
            species: Species(
              id: 2,
              name: 'evolution 1',
              types: [],
            ),
            evolutionDetails: [
              EvolutionDetail(
                trigger: Trigger.USE_ITEM,
                item: Item(id: 'item-1', name: ''),
              ),
            ],
            evolvesTo: [],
          );

          var evolution2 = Chain(
            isBaby: false,
            species: Species(
              id: 3,
              name: 'evolution 2',
              types: [],
            ),
            evolutionDetails: [
              EvolutionDetail(
                trigger: Trigger.USE_ITEM,
                item: Item(id: 'item-2', name: ''),
              ),
            ],
            evolvesTo: [],
          );
          var evolution3 = Chain(
            isBaby: false,
            species: Species(
              id: 4,
              name: 'evolution 3',
              types: [],
            ),
            evolutionDetails: [
              EvolutionDetail(
                trigger: Trigger.USE_ITEM,
                item: Item(id: 'item-3', name: ''),
              ),
            ],
            evolvesTo: [],
          );
          var evolution4 = Chain(
            isBaby: false,
            species: Species(
              id: 5,
              name: 'evolution 4',
              types: [],
            ),
            evolutionDetails: [
              EvolutionDetail(
                trigger: Trigger.LEVEL_UP,
              ),
            ],
            evolvesTo: [],
          );
          var chain = Chain(
            isBaby: true,
            species: Species(
              id: 1,
              name: 'pokemon',
              types: [],
            ),
            evolutionDetails: [],
            evolvesTo: [evolution1, evolution2, evolution3, evolution4],
          );

          List<List<ChainViewModel>> groups = _presenter.groupBy(chain);
          var group1 = groups[0];
          var group2 = groups[1];

          expect(groups.length, equals(2));
          expect(group1.length, equals(3));
          expect(group2.length, equals(1));
          expect(group1[0].id, equals(2));
          expect(group1[1].id, equals(3));
          expect(group1[2].id, equals(4));
          expect(group2[0].id, equals(5));
        },
      );

      test(
        "when a chain has more than 3 evolutions with the same trigger, "
        "group them by other evolution details",
        () {
          var chain = Chain(
            isBaby: true,
            species: Species(
              id: 1,
              name: 'pokemon',
              types: [],
            ),
            evolutionDetails: [],
            evolvesTo: [
              Chain(
                isBaby: false,
                species: Species(
                  id: 196,
                  name: 'espeon',
                  types: [],
                ),
                evolutionDetails: [
                  EvolutionDetail(
                    trigger: Trigger.LEVEL_UP,
                    minHappiness: 220,
                    timeOfDay: TimeOfDay.DAY,
                  ),
                ],
                evolvesTo: [],
              ),
              Chain(
                isBaby: false,
                species: Species(
                  id: 197,
                  name: 'umbreon',
                  types: [],
                ),
                evolutionDetails: [
                  EvolutionDetail(
                    trigger: Trigger.LEVEL_UP,
                    minHappiness: 220,
                    timeOfDay: TimeOfDay.NIGHT,
                  ),
                ],
                evolvesTo: [],
              ),
              Chain(
                isBaby: false,
                species: Species(
                  id: 470,
                  name: 'leafeon',
                  types: [],
                ),
                evolutionDetails: [
                  EvolutionDetail(
                    trigger: Trigger.LEVEL_UP,
                    location: Location(
                      id: 'mossy-rock',
                      name: 'Mossy Rock',
                    ),
                  ),
                ],
                evolvesTo: [],
              ),
              Chain(
                isBaby: false,
                species: Species(
                  id: 471,
                  name: 'glaceon',
                  types: [],
                ),
                evolutionDetails: [
                  EvolutionDetail(
                    trigger: Trigger.LEVEL_UP,
                    location: Location(
                      id: 'icy-rock',
                      name: 'Icy Rock',
                    ),
                  ),
                ],
                evolvesTo: [],
              ),
            ],
          );

          List<List<ChainViewModel>> groups = _presenter.groupBy(chain);
          var group1 = groups[0];
          var group2 = groups[1];

          expect(groups.length, equals(2));
          expect(group1[0].id, equals(196));
          expect(group1[1].id, equals(197));
          expect(group2[0].id, equals(470));
          expect(group2[1].id, equals(471));
        },
      );
    });

    group('Validate evolution details', () {
      test("Evolution by using an item", () {
        var chain = Chain(
          isBaby: true,
          species: Species(
            id: 1,
            name: 'pokemon',
            types: [],
          ),
          evolutionDetails: [],
          evolvesTo: [
            Chain(
              species: Species(
                id: 2,
                name: 'pokemon2',
                types: [],
              ),
              evolutionDetails: [
                EvolutionDetail(
                  trigger: Trigger.USE_ITEM,
                  item: Item(id: 'some-stone', name: 'Some Stone'),
                )
              ],
              evolvesTo: [],
            ),
          ],
        );

        var chainViewModel = _presenter.toChainViewModel(chain);

        expect(
          chainViewModel.evolvesTo[0][0].evolutionDetails[0].desc,
          equals('Some Stone'),
        );
        expect(
          chainViewModel.evolvesTo[0][0].evolutionDetails[0].item.id,
          equals('some_stone'),
        );

        expect(
          chainViewModel.evolvesTo[0][0].evolutionDetails[0].item.name,
          equals('Some Stone'),
        );
      });

      test("Evolution by friendship only", () {
        var chain = Chain(
          isBaby: true,
          species: Species(
            id: 1,
            name: 'pokemon',
            types: [],
          ),
          evolutionDetails: [],
          evolvesTo: [
            Chain(
              species: Species(
                id: 2,
                name: 'pokemon2',
                types: [],
              ),
              evolutionDetails: [
                EvolutionDetail(
                  minHappiness: 220,
                  trigger: Trigger.LEVEL_UP,
                )
              ],
              evolvesTo: [],
            ),
          ],
        );

        var chainViewModel = _presenter.toChainViewModel(chain);
        var evolutionDetail =
            chainViewModel.evolvesTo[0][0].evolutionDetails[0];

        expect(evolutionDetail.desc, equals('High Friendship'));
        expect(evolutionDetail.trigger, equals(Trigger.LEVEL_UP));
        expect(evolutionDetail.minHappiness, equals(220));
      });

      test("Evolution by friendship and time of day", () {
        var chain = Chain(
          isBaby: true,
          species: Species(
            id: 1,
            name: 'pokemon',
            types: [],
          ),
          evolutionDetails: [],
          evolvesTo: [
            Chain(
              species: Species(
                id: 2,
                name: 'pokemon2',
                types: [],
              ),
              evolutionDetails: [
                EvolutionDetail(
                  minHappiness: 220,
                  timeOfDay: TimeOfDay.DAY,
                  trigger: Trigger.LEVEL_UP,
                )
              ],
              evolvesTo: [],
            ),
          ],
        );

        var chainViewModel = _presenter.toChainViewModel(chain);
        var evolutionDetail =
            chainViewModel.evolvesTo[0][0].evolutionDetails[0];

        expect(evolutionDetail.desc, equals('High Friendship, Daytime'));
        expect(evolutionDetail.trigger, equals(Trigger.LEVEL_UP));
        expect(evolutionDetail.minHappiness, equals(220));
        expect(evolutionDetail.timeOfDay, equals(TimeOfDay.DAY));
      });

      test("Evolution by friendship and time of night", () {
        var chain = Chain(
          isBaby: true,
          species: Species(
            id: 1,
            name: 'pokemon',
            types: [],
          ),
          evolutionDetails: [],
          evolvesTo: [
            Chain(
              species: Species(
                id: 2,
                name: 'pokemon2',
                types: [],
              ),
              evolutionDetails: [
                EvolutionDetail(
                  minHappiness: 220,
                  timeOfDay: TimeOfDay.NIGHT,
                  trigger: Trigger.LEVEL_UP,
                )
              ],
              evolvesTo: [],
            ),
          ],
        );

        var chainViewModel = _presenter.toChainViewModel(chain);
        var evolutionDetail =
            chainViewModel.evolvesTo[0][0].evolutionDetails[0];

        expect(evolutionDetail.desc, equals('High Friendship, Nighttime'));
        expect(evolutionDetail.trigger, equals(Trigger.LEVEL_UP));
        expect(evolutionDetail.minHappiness, equals(220));
        expect(evolutionDetail.timeOfDay, equals(TimeOfDay.NIGHT));
      });

      test("Evolution by Level and location", () {
        var chain = Chain(
          isBaby: true,
          species: Species(
            id: 1,
            name: 'pokemon',
            types: [],
          ),
          evolutionDetails: [],
          evolvesTo: [
            Chain(
              species: Species(
                id: 2,
                name: 'pokemon2',
                types: [],
              ),
              evolutionDetails: [
                EvolutionDetail(
                  location: Location(id: 'icy-rock', name: 'Icy Rock'),
                  trigger: Trigger.LEVEL_UP,
                )
              ],
              evolvesTo: [],
            ),
          ],
        );

        var chainViewModel = _presenter.toChainViewModel(chain);
        var evolutionDetail =
            chainViewModel.evolvesTo[0][0].evolutionDetails[0];

        expect(evolutionDetail.desc, equals('Level up near Icy Rock'));
        expect(evolutionDetail.trigger, equals(Trigger.LEVEL_UP));
        expect(evolutionDetail.location.id, equals('icy_rock'));
        expect(evolutionDetail.location.name, equals('Icy Rock'));
      });
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
    var expectedBaseStats = [
      BaseStatViewModel(label: 'HP', value: 60, min: 'min.230', max: 'max.324'),
      BaseStatViewModel(
        label: 'ATK',
        value: 65,
        min: 'min.121',
        max: 'max.251',
      ),
      BaseStatViewModel(
        label: 'DEF',
        value: 61,
        min: 'min.112',
        max: 'max.240',
      ),
      BaseStatViewModel(
        label: 'SATK',
        value: 130,
        min: 'min.238',
        max: 'max.394',
      ),
      BaseStatViewModel(
        label: 'SDEF',
        value: 75,
        min: 'min.139',
        max: 'max.273',
      ),
      BaseStatViewModel(
        label: 'SPD',
        value: 110,
        min: 'min.202',
        max: 'max.350',
      ),
    ];
    PokemonProfileResponseModel responseModel = PokemonProfileResponseModel(
      pokemonName: 'pokemon',
      nationalPokedexNum: 94,
      types: [PokemonType.GHOST, PokemonType.POISON],
      hasMegaEvolution: true,
      species: 'shadow',
      height: 1.5,
      weight: 40.5,
      isMetricSystem: true,
      abilities: [
        Ability(title: 'ability one', isHidden: false),
        Ability(title: 'ability two', isHidden: true),
      ],
      isGenderless: false,
      malePercentage: 0.7,
      femalePercentage: 0.3,
      chain: _chain1,
      stats: [
        Stat(baseStat: BaseStat.HP, value: 60, min: 230, max: 324),
        Stat(baseStat: BaseStat.ATK, value: 65, min: 121, max: 251),
        Stat(baseStat: BaseStat.DEF, value: 61, min: 112, max: 240),
        Stat(baseStat: BaseStat.SATK, value: 130, min: 238, max: 394),
        Stat(baseStat: BaseStat.SDEF, value: 75, min: 139, max: 273),
        Stat(baseStat: BaseStat.SPD, value: 110, min: 202, max: 350),
      ],
      weakTo: weakTo,
      immuneTo: immuneTo,
      resistantTo: resistantTo,
      damagedNormallyBy: damagedNormallyBy,
    );

    _presenter.present(responseModel);

    PokemonProfileViewModel vm = _presenter.viewModel;
    var chainViewModel1 = vm.chainViewModel;
    var chainViewModel2 = chainViewModel1.evolvesTo[0][0];
    var chainViewModel3 = chainViewModel2.evolvesTo[0][0];
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
    expect(vm.abilities[0].title, equals('Ability One'));
    expect(vm.abilities[1].title, equals('Ability Two'));
    expect(vm.abilities[0].isHidden, equals(false));
    expect(vm.abilities[1].isHidden, equals(true));
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

    for (var i = 0; i < expectedBaseStats.length; i++) {
      expect(vm.stats[0].label, equals(expectedBaseStats[0].label));
      expect(vm.stats[0].value, equals(expectedBaseStats[0].value));
      expect(vm.stats[0].min, equals(expectedBaseStats[0].min));
      expect(vm.stats[0].max, equals(expectedBaseStats[0].max));
    }

    expect(vm.totalStats, equals({'TOTAL': 501}), skip: 'For now');

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

  group("Gender tests", () {
    test("When pokemon is genderless, gender percentage is null", () {
      PokemonProfileResponseModel responseModel = PokemonProfileResponseModel(
        pokemonName: 'pokemon',
        nationalPokedexNum: 94,
        types: [],
        hasMegaEvolution: true,
        species: 'shadow',
        height: 1.5,
        weight: 40.5,
        isMetricSystem: true,
        abilities: [],
        isGenderless: true,
        chain: _chain1,
        stats: [],
        weakTo: {},
        immuneTo: {},
        resistantTo: {},
        damagedNormallyBy: {},
      );

      _presenter.present(responseModel);

      expect(_presenter.viewModel.malePercentage, equals(null));
      expect(_presenter.viewModel.femalePercentage, equals(null));
      expect(_presenter.viewModel.isGenderless, equals(true));
    });

    test('When pokemon is only male, female should be null', () {
      PokemonProfileResponseModel responseModel = PokemonProfileResponseModel(
        pokemonName: 'pokemon',
        nationalPokedexNum: 94,
        types: [],
        hasMegaEvolution: true,
        species: 'shadow',
        height: 1.5,
        weight: 40.5,
        isMetricSystem: true,
        abilities: [],
        isGenderless: false,
        malePercentage: 1,
        chain: _chain1,
        stats: [],
        weakTo: {},
        immuneTo: {},
        resistantTo: {},
        damagedNormallyBy: {},
      );

      _presenter.present(responseModel);

      expect(_presenter.viewModel.malePercentage, equals('100%'));
      expect(_presenter.viewModel.femalePercentage, equals(null));
      expect(_presenter.viewModel.isGenderless, equals(false));
    });

    test('When pokemon is only female, male should be null', () {
      PokemonProfileResponseModel responseModel = PokemonProfileResponseModel(
        pokemonName: 'pokemon',
        nationalPokedexNum: 94,
        types: [],
        hasMegaEvolution: true,
        species: 'shadow',
        height: 1.5,
        weight: 40.5,
        isMetricSystem: true,
        abilities: [],
        isGenderless: false,
        femalePercentage: 1,
        chain: _chain1,
        stats: [],
        weakTo: {},
        immuneTo: {},
        resistantTo: {},
        damagedNormallyBy: {},
      );

      _presenter.present(responseModel);

      expect(_presenter.viewModel.femalePercentage, equals('100%'));
      expect(_presenter.viewModel.malePercentage, equals(null));
      expect(_presenter.viewModel.isGenderless, equals(false));
    });

    test('when both genders are available', () {
      PokemonProfileResponseModel responseModel = PokemonProfileResponseModel(
        pokemonName: 'pokemon',
        nationalPokedexNum: 94,
        types: [],
        hasMegaEvolution: true,
        species: 'shadow',
        height: 1.5,
        weight: 40.5,
        isMetricSystem: true,
        abilities: [],
        isGenderless: false,
        malePercentage: 0.6,
        femalePercentage: 0.4,
        chain: _chain1,
        stats: [],
        weakTo: {},
        immuneTo: {},
        resistantTo: {},
        damagedNormallyBy: {},
      );

      _presenter.present(responseModel);

      expect(_presenter.viewModel.malePercentage, equals('60%'));
      expect(_presenter.viewModel.femalePercentage, equals('40%'));
      expect(_presenter.viewModel.isGenderless, equals(false));
    });
  });
}
