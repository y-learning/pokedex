import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokedex/viewmodels/chain_view_model.dart';
import 'package:pokedex/viewmodels/pokemon_profile_view_model.dart';
import 'package:pokedex/widgets/effectiveness_text.dart';
import 'package:pokedex/widgets/gender_row.dart';
import 'package:pokedex/widgets/hidden_ability_text.dart';
import 'package:pokedex/widgets/type_effectiveness_grid.dart';
import 'package:pokedex/widgets/vertical_separator.dart';
import 'package:pokedex/widgets/arc_dlipper.dart';
import 'package:pokedex/widgets/base_stat_row.dart';
import 'package:pokedex/widgets/data_box.dart';
import 'package:pokedex/widgets/evolution_condition_box.dart';
import 'package:pokedex/widgets/evolution_image.dart';
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

  _ProfileScreenState(this._profileViewModel) {
    _setRegularEvolution();
    _profileTheme = ProfileTheme(_profileViewModel.types[0].type);
  }

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
                    top: ScreenUtil.getInstance().setHeight(104),
                    right: ScreenUtil.getInstance().setWidth(32),
                    left: ScreenUtil.getInstance().setWidth(32),
                  ),
                  child: GlowFreeListView(
                    children: [
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
                                itemImage(_profileViewModel.id),
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
                          DataBox(
                            widgets: [
                              DataBoxTitle(
                                _profileViewModel.species,
                                color: _profileTheme.dataBoxTitleColor,
                                titleMaxLines: 2,
                              )
                            ],
                            subtitle: 'Species',
                          ),
                          Column(
                            children: [
                              VerticalSeparator(
                                color: _profileTheme.appBarBackgroundColor,
                              ),
                            ],
                          ),
                          DataBox(
                            widgets: [
                              DataBoxTitle(
                                _profileViewModel.height,
                                color: _profileTheme.dataBoxTitleColor,
                              )
                            ],
                            subtitle: 'Height',
                          ),
                          Column(
                            children: [
                              VerticalSeparator(
                                color: _profileTheme.appBarBackgroundColor,
                              ),
                            ],
                          ),
                          DataBox(
                            widgets: [
                              DataBoxTitle(
                                _profileViewModel.weight,
                                color: _profileTheme.dataBoxTitleColor,
                              )
                            ],
                            subtitle: 'Weight',
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      Row(
                        children: [
                          DataBox(
                            widgets: _buildGenderRatio(),
                            subtitle: 'Gender ratio',
                          ),
                          DataBox(
                            widgets: _buildAbilities(),
                            subtitle: 'Abilities',
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      SectionTitleText(
                        'Evolution',
                        textColor: _profileTheme.dataBoxTitleColor,
                      ),
                      SizedBox(height: 6),
                      for (var row in _linearEvolutionRows())
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: row,
                        ),
                      SizedBox(height: 24),
                      SectionTitleText(
                        'Base Stats',
                        textColor: _profileTheme.dataBoxTitleColor,
                      ),
                      SizedBox(height: 6),
                      Column(
                        children: _buildStatsChart(),
                      ),
                      SizedBox(height: 6),
                      SectionTitleText(
                        'Type effectiveness',
                        textColor: _profileTheme.dataBoxTitleColor,
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          EffectivenessText(
                            text: 'Weak to',
                            color: _profileTheme.dataBoxTitleColor,
                          ),
                          Expanded(
                            child: buildTypeEffectivenessGrid(
                              _profileViewModel.weakTo,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          EffectivenessText(
                            text: 'Immune to',
                            color: _profileTheme.dataBoxTitleColor,
                          ),
                          Expanded(
                            child: buildTypeEffectivenessGrid(
                              _profileViewModel.immuneTo,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          EffectivenessText(
                            text: 'Resistant to',
                            color: _profileTheme.dataBoxTitleColor,
                          ),
                          Expanded(
                            child: buildTypeEffectivenessGrid(
                              _profileViewModel.resistantTo,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          EffectivenessText(
                            text: 'Damaged normally by',
                            color: _profileTheme.dataBoxTitleColor,
                          ),
                          Expanded(
                            child: buildTypeEffectivenessGrid(
                              _profileViewModel.damagedNormallyBy,
                            ),
                          ),
                        ],
                      ),
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
      types: types.map((vm) => vm.type).toList(),
      effectivenessValues: types.map((vm) => vm.effectiveness).toList(),
      separatorColor: _profileTheme.appBarBackgroundColor,
    );
  }

  List<List<Widget>> _linearEvolutionRows() {
    List<List<Widget>> list = [];
    list.add(_linearEvolution(_profileViewModel.chainViewModel).firstRow);
    list.add(_linearEvolution(_profileViewModel.chainViewModel).secondRow);

    return list;
  }

  LinearEvolution _linearEvolution(ChainViewModel chainViewModel) {
    LinearEvolution linearEvolution = LinearEvolution();

    if (chainViewModel.evolutionDetails.isNotEmpty) {
      linearEvolution.secondRow.add(VerticalSeparator(
        color: _profileTheme.appBarBackgroundColor,
      ));
      var evolutionDetailVm = chainViewModel.evolutionDetails[0];
      var assetName = getTriggerIconAsset(evolutionDetailVm);
      linearEvolution.firstRow.add(
        EvolutionConditionBox(
          assetName: 'images/evolution_icons/$assetName',
          hoverMessage: evolutionDetailVm.desc,
          hoverColor: _profileTheme.appBarBackgroundColor,
        ),
      );
    }

    linearEvolution.firstRow.add(
      EvolutionImage(pokemonImage(chainViewModel.id.toString())),
    );
    linearEvolution.secondRow.add(
      DataBox(
        widgets: [
          DataBoxTitle(
            chainViewModel.name,
            color: _profileTheme.dataBoxTitleColor,
          )
        ],
        subtitle: chainViewModel.formattedId,
      ),
    );

    if (chainViewModel.evolvesTo.isNotEmpty) {
      linearEvolution.firstRow.addAll(
        _linearEvolution(chainViewModel.evolvesTo.first).firstRow,
      );
      linearEvolution.secondRow.addAll(
        _linearEvolution(chainViewModel.evolvesTo.first).secondRow,
      );
    }

    return linearEvolution;
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
          width: ScreenUtil.getInstance().setWidth(350),
          color: typeLabelAssets.color,
          typeIcon: typeLabelAssets.icon,
          padding: EdgeInsets.symmetric(
            vertical: ScreenUtil.getInstance().setHeight(10),
            horizontal: ScreenUtil.getInstance().setWidth(34),
          ),
          typeIconSize: 34,
          titleSize: 32,
        ),
      );
    }).toList();

    if (_profileViewModel.types.length == 2)
      list.insert(1, SizedBox(width: 40));

    return list;
  }
}

class LinearEvolution {
  List<Widget> firstRow = [];
  List<Widget> secondRow = [];
}
