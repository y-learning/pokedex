import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokedex/viewmodels/chain_view_model.dart';
import 'package:pokedex/viewmodels/pokemon_profile_view_model.dart';
import 'package:pokedex/widgets/effectiveness_text.dart';
import 'package:pokedex/widgets/gender_row.dart';
import 'package:pokedex/widgets/hidden_ability_text.dart';
import 'package:pokedex/widgets/pokemon_evolution_widget.dart';
import 'package:pokedex/widgets/type_effectiveness_grid.dart';
import 'package:pokedex/widgets/vertical_separator.dart';
import 'package:pokedex/widgets/arc_dlipper.dart';
import 'package:pokedex/widgets/base_stat_row.dart';
import 'package:pokedex/widgets/data_box.dart';
import 'package:pokedex/widgets/evolution_condition_box.dart';
import 'package:pokedex/widgets/glow_free_listView.dart';
import 'package:pokedex/widgets/section_title_text.dart';
import 'package:pokedex/widgets/type_label.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';
import '../profile_theme.dart';
import '../resources.dart';
import '../utils.dart';

class ProfileScreen extends StatefulWidget {
  final PokemonProfileViewModel profileViewModel;

  ProfileScreen(this.profileViewModel);

  _ProfileScreenState createState() => _ProfileScreenState(profileViewModel);
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileTheme _profileTheme;
  PokemonProfileViewModel _profileViewModel;
  String _mainPokemonAsset;
  bool _isMega;
  final Map<EffectivenessCategory, String> _effectivenessCategory = {
    EffectivenessCategory.WEAK_TO: 'Weak to',
    EffectivenessCategory.IMMUNE_TO: 'Immune to',
    EffectivenessCategory.RESISTANT_TO: 'Resistant to',
    EffectivenessCategory.DAMAGED_NORMALLY_BY: 'Damaged normally by',
  };

  int _evolutionsStages = 1;

  _ProfileScreenState(this._profileViewModel) {
    _setRegularEvolution();
    _profileTheme = ProfileTheme(_profileViewModel.types[0].type);
  }

  List<Widget> tree = [];
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        backgroundColor: _profileTheme.appBarBackgroundColor,
        title: Text(
          'Pokédex',
          style: TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
        leading: IconButton(
          icon: Platform.isAndroid
              ? Icon(Icons.arrow_back)
              : Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context, false),
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 16),
            icon: Icon(
              Icons.star_border,
              color: Colors.white,
              size: 29,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ClipPath(
                  clipper: const ArcClipper(),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: [0.1, 0.4, 0.6, 0.9],
                        colors: _profileTheme.topRgbGradient,
                      ),
                    ),
                    child: Row(
                      textBaseline: TextBaseline.alphabetic,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _profileViewModel.pokemonName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil.getInstance().setSp(62),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _profileViewModel.nationalPokedexNum,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil.getInstance().setSp(29),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: ScreenUtil.getInstance().setHeight(60),
                    right: ScreenUtil.getInstance().setWidth(32),
                    left: ScreenUtil.getInstance().setWidth(32),
                  ),
                  child: GlowFreeListView(
                    children: [
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: _buildTypeLabel(),
                      ),
                      Visibility(
                        visible: _profileViewModel.hasMegaEvolution,
                        child: Tooltip(
                          message: 'Mega Evolution',
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: kGhostTypeColor4,
                          ),
                          child: IconButton(
                            splashColor: kGhostTypeColor4,
                            icon: Image(
                              image: AssetImage(
                                itemImage('${_profileViewModel.id}_megastone'),
                              ),
                            ),
                            onPressed: _toggleMegaEvolution,
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: DataBox(
                              widgets: [
                                DataBoxTitle(
                                  _profileViewModel.species,
                                  color: _profileTheme.dataBoxTitleColor,
                                  titleMaxLines: 2,
                                )
                              ],
                              subtitle: 'Species',
                            ),
                          ),
                          Column(
                            children: [
                              VerticalSeparator(
                                color: _profileTheme.appBarBackgroundColor,
                              ),
                            ],
                          ),
                          Expanded(
                            child: DataBox(
                              widgets: [
                                DataBoxTitle(
                                  _profileViewModel.height,
                                  color: _profileTheme.dataBoxTitleColor,
                                )
                              ],
                              subtitle: 'Height',
                            ),
                          ),
                          Column(
                            children: [
                              VerticalSeparator(
                                color: _profileTheme.appBarBackgroundColor,
                              ),
                            ],
                          ),
                          Expanded(
                            child: DataBox(
                              widgets: [
                                DataBoxTitle(
                                  _profileViewModel.weight,
                                  color: _profileTheme.dataBoxTitleColor,
                                )
                              ],
                              subtitle: 'Weight',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: DataBox(
                              widgets: _buildGenderRatio(),
                              subtitle: 'Gender ratio',
                            ),
                          ),
                          Expanded(
                            child: DataBox(
                              widgets: _buildAbilities(),
                              subtitle: 'Abilities',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      SectionTitleText(
                        'Evolution',
                        textColor: _profileTheme.dataBoxTitleColor,
                      ),
                      SizedBox(height: 6),
                      Row(
                        children: [
                          Expanded(
                            child: _buildEvolutionTree(
                              _profileViewModel.chainViewModel,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      SectionTitleText(
                        'Base Stats',
                        textColor: _profileTheme.dataBoxTitleColor,
                      ),
                      SizedBox(height: 6),
                      Column(children: _buildStatsChart()),
                      SizedBox(height: 6),
                      SectionTitleText(
                        'Type effectiveness',
                        textColor: _profileTheme.dataBoxTitleColor,
                      ),
                      SizedBox(height: 10),
                      for (var row in _buildEffectivenessCategories()) row,
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * .05,
            ),
            child: Image(
              height: MediaQuery.of(context).size.height * .24,
              width: MediaQuery.of(context).size.height * .24,
              image: AssetImage(_mainPokemonAsset),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildEvolutionTree(ChainViewModel chainViewModel) {
    _calcEvolutionStages(chainViewModel.evolvesTo);

    var column = Column(
      children: [
        for (var group in chainViewModel.evolvesTo)
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: PokemonEvolutionWidget(
                  chainViewModel: chainViewModel,
                  profileTheme: _profileTheme,
                ),
              ),
              _nextEvolutions(group),
            ],
          ),
      ],
    );

    _evolutionsStages = 1;

    return column;
  }

  void _calcEvolutionStages(List<List<ChainViewModel>> groups) {
    if (groups.isNotEmpty) {
      _evolutionsStages++;
      for (var group in groups)
        for (var chainVm in group) _calcEvolutionStages(chainVm.evolvesTo);
    }
  }

  Widget _nextEvolutions(List<ChainViewModel> group) {
    return group.isEmpty
        ? kNullWidget
        : Expanded(
            flex: _evolutionsStages,
            child: Column(
              children: group.map<Widget>((chainViewModel) {
                var evolutionDetail = chainViewModel.evolutionDetails[0];
                List<Widget> children = [
                  Expanded(
                    flex: _evolutionsStages,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        EvolutionConditionBox(
                          assetName: getTriggerIconAsset(evolutionDetail),
                          hoverMessage: evolutionDetail.desc,
                          hoverColor: _profileTheme.appBarBackgroundColor,
                        ),
                        PokemonEvolutionWidget(
                          chainViewModel: chainViewModel,
                          profileTheme: _profileTheme,
                        ),
                      ],
                    ),
                  )
                ];
                for (var group in chainViewModel.evolvesTo)
                  if (group.isNotEmpty) children.add(_nextEvolutions(group));

                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: ScreenUtil.getInstance().setHeight(18),
                  ),
                  child: Row(children: children),
                );
              }).toList(),
            ),
          );
  }

  List<Widget> _buildGenderRatio() {
    List<Widget> genders = [];

    if (_profileViewModel.isGenderless)
      genders.add(DataBoxTitle(
        'Genderless',
        color: _profileTheme.dataBoxTitleColor,
      ));
    else {
      if (_profileViewModel.malePercentage != null)
        genders.add(GenderRow(
          percentage: _profileViewModel.malePercentage,
          iconData: FontAwesomeIcons.mars,
          color: kMaleColor,
        ));

      if (_profileViewModel.femalePercentage != null)
        genders.add(GenderRow(
          percentage: _profileViewModel.femalePercentage,
          iconData: FontAwesomeIcons.venus,
          color: kFemaleColor,
        ));
    }

    return genders;
  }

  List<Widget> _buildAbilities() {
    return _profileViewModel.abilities
        .map((ability) => ability.isHidden
            ? Row(
                children: [
                  DataBoxTitle(
                    ability.title,
                    color: _profileTheme.dataBoxTitleColor,
                  ),
                  HiddenAbilityText(
                    color: _profileTheme.dataBoxTitleColor,
                  )
                ],
              )
            : DataBoxTitle(
                ability.title,
                color: _profileTheme.dataBoxTitleColor,
              ))
        .toList();
  }

  List<Widget> _buildStatsChart() {
    List<Widget> list = [];

    for (var baseStatViewModel in _profileViewModel.stats) {
      list.add(
        StatRow(
          statLabel: baseStatViewModel.label,
          statValue: baseStatViewModel.value,
          textColor: _profileTheme.dataBoxTitleColor,
          separatorColor: _profileTheme.appBarBackgroundColor,
          min: baseStatViewModel.min,
          max: baseStatViewModel.max,
        ),
      );
    }

    list.add(
      Row(
        children: [
          BaseStatLabel(
            stat: _profileViewModel.totalStats.keys.first,
            color: _profileTheme.dataBoxTitleColor,
          ),
          VerticalSeparator(
            height: 26,
            margin: 24,
            color: _profileTheme.appBarBackgroundColor,
          ),
          BaseStatValue(
            stat: _profileViewModel.totalStats.values.first,
            fontWeight: FontWeight.w900,
            color: _profileTheme.dataBoxTitleColor,
          ),
        ],
      ),
    );
    return list;
  }

  TypeEffectivenessGrid buildTypeEffectivenessGrid(List<TypeViewModel> types) {
    return TypeEffectivenessGrid(
      types: types,
      effectivenessValues: types.map((vm) => vm.effectiveness).toList(),
      separatorColor: _profileTheme.appBarBackgroundColor,
    );
  }

  void _toggleMegaEvolution() =>
      setState(() => _isMega ? _setRegularEvolution() : _setMegaEvolution());

  void _setRegularEvolution() {
    _mainPokemonAsset = pokemonImage(_profileViewModel.id.toString());
    _isMega = false;
  }

  void _setMegaEvolution() {
    _mainPokemonAsset = pokemonImage('${_profileViewModel.id}_mega');
    _isMega = true;
  }

  List<Widget> _buildTypeLabel() {
    var list = _profileViewModel.types.map<Widget>((typeViewModel) {
      var typeLabelAssets = Utils.getLabelAssetsFor(typeViewModel.type);
      return Flexible(
        child: TypeLabel(
          typeViewModel.title,
          width: ScreenUtil.getInstance().setWidth(320),
          color: typeLabelAssets.color,
          typeIcon: typeLabelAssets.icon,
          padding: EdgeInsets.symmetric(
            vertical: ScreenUtil.getInstance().setHeight(6),
            horizontal: ScreenUtil.getInstance().setWidth(34),
          ),
          typeIconSize: ScreenUtil.getInstance().setWidth(54),
          titleSize: ScreenUtil.getInstance().setSp(48),
        ),
      );
    }).toList();

    if (_profileViewModel.types.length == 2)
      list.insert(1, SizedBox(width: ScreenUtil.getInstance().setWidth(70)));

    return list;
  }

  List<Row> _buildEffectivenessCategories() {
    List<Row> list = [];

    _effectivenessCategory.forEach((typeEffectiveness, title) {
      list.add(
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            EffectivenessText(
              text: title,
              color: _profileTheme.dataBoxTitleColor,
            ),
            Expanded(
              child: buildTypeEffectivenessGrid(
                _getTypeEffectivenessViewModels(typeEffectiveness),
              ),
            ),
          ],
        ),
      );
    });

    return list;
  }

  List<TypeViewModel> _getTypeEffectivenessViewModels(
    EffectivenessCategory key,
  ) {
    List<TypeViewModel> list;
    switch (key) {
      case EffectivenessCategory.WEAK_TO:
        list = _profileViewModel.weakTo;
        break;
      case EffectivenessCategory.IMMUNE_TO:
        list = _profileViewModel.immuneTo;
        break;
      case EffectivenessCategory.RESISTANT_TO:
        list = _profileViewModel.resistantTo;
        break;
      case EffectivenessCategory.DAMAGED_NORMALLY_BY:
        list = _profileViewModel.damagedNormallyBy;
        break;
    }

    return list;
  }
}

enum EffectivenessCategory {
  WEAK_TO,
  IMMUNE_TO,
  RESISTANT_TO,
  DAMAGED_NORMALLY_BY,
}
