import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokedex/widgets/effectiveness_value.dart';
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
import '../pokemon_types.dart';

class ProfileScreen extends StatefulWidget {
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _mainPokemonAsset;
  bool _isMega;

  List<PokemonTypes> _weaknesses = [
    PokemonTypes.GROUND,
    PokemonTypes.GHOST,
    PokemonTypes.PSYCHIC,
    PokemonTypes.DARK,
  ];

  List<PokemonTypes> _immuneTypes = [
    PokemonTypes.NORMAL,
    PokemonTypes.FIGHT,
  ];

  List<PokemonTypes> _resistants = [
    PokemonTypes.POISON,
    PokemonTypes.BUG,
    PokemonTypes.GRASS,
    PokemonTypes.FAIRY,
  ];

  List<PokemonTypes> _normalDamageTypes = [
    PokemonTypes.FLYING,
    PokemonTypes.ROCK,
    PokemonTypes.STEEL,
    PokemonTypes.FIRE,
    PokemonTypes.WATER,
    PokemonTypes.ELECTRIC,
    PokemonTypes.ICE,
    PokemonTypes.DRAGON,
  ];

  _ProfileScreenState() {
    _setRegularEvolution();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        backgroundColor: kGhostTypeColor4,
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
                        colors: kGhostRgbGradient,
                      ),
                    ),
                    child: Row(
                      textBaseline: TextBaseline.alphabetic,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Gengar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil.getInstance().setSp(62),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '#094',
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
                        children: [
                          Expanded(
                            child: TypeLabel(
                              'GHOST',
                              color: kGhostTypeColor1,
                              typeIcon: 'images/types/ghost.svg',
                              padding: EdgeInsets.symmetric(
                                vertical:
                                    ScreenUtil.getInstance().setHeight(10),
                                horizontal:
                                    ScreenUtil.getInstance().setWidth(34),
                              ),
                              typeIconSize: 34,
                              titleSize: 32,
                            ),
                          ),
                          SizedBox(width: 40),
                          Expanded(
                            child: TypeLabel(
                              'POISON',
                              color: kPoisonTypeColor1,
                              typeIcon: 'images/types/poison.svg',
                              padding: EdgeInsets.symmetric(
                                vertical:
                                    ScreenUtil.getInstance().setHeight(10),
                                horizontal:
                                    ScreenUtil.getInstance().setWidth(34),
                              ),
                              typeIconSize: 34,
                              titleSize: 32,
                            ),
                          ),
                        ],
                      ),
                      Tooltip(
                        message: 'Mega Evolution',
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: kGhostTypeColor4,
                        ),
                        child: IconButton(
                          splashColor: kGhostTypeColor4,
                          icon: Image(
                            image: AssetImage('images/megastone_gengarite.png'),
                          ),
                          onPressed: _toggleMegaEvolution,
                        ),
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          DataBox(
                            widgets: [
                              DataBoxTitle(
                                'Shadow',
                                titleMaxLines: 2,
                                color: kGhostTypeColor1,
                              )
                            ],
                            subtitle: 'Species',
                          ),
                          VerticalSeparator(),
                          DataBox(
                            widgets: [
                              DataBoxTitle(
                                '4\' 11\"',
                                color: kGhostTypeColor1,
                              )
                            ],
                            subtitle: 'Height',
                          ),
                          VerticalSeparator(),
                          DataBox(
                            widgets: [
                              DataBoxTitle(
                                '8956.3 lbs',
                                color: kGhostTypeColor1,
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
                            widgets: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  DataBoxTitle(
                                    '50%',
                                    color: kMaleColor,
                                  ),
                                  Icon(
                                    FontAwesomeIcons.mars,
                                    color: kMaleColor,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  DataBoxTitle(
                                    '50%',
                                    color: kFemaleColor,
                                  ),
                                  Icon(
                                    FontAwesomeIcons.venus,
                                    color: kFemaleColor,
                                  ),
                                ],
                              ),
                            ],
                            subtitle: 'Gender',
                          ),
                          DataBox(
                            widgets: [
                              DataBoxTitle(
                                'Cursed Body',
                                color: kGhostTypeColor1,
                              ),
                            ],
                            subtitle: 'Abilities',
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      const SectionTitleText(
                        'Evolution',
                        textColor: kGhostTypeColor1,
                      ),
                      SizedBox(height: 6),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          EvolutionImage('images/gastly.gif'),
                          EvolutionConditionBox(
                            assetName: 'images/evolution_icons/l25.png',
                            hoverMessage: 'Level',
                            hoverColor: kGhostTypeColor4,
                          ),
                          EvolutionImage('images/haunter.gif'),
                          EvolutionConditionBox(
                            assetName: 'images/evolution_icons/trade.png',
                            hoverMessage: 'Trade',
                            hoverColor: kGhostTypeColor4,
                          ),
                          EvolutionImage('images/gengar.gif'),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          DataBox(
                            widgets: [
                              DataBoxTitle(
                                'Gastly',
                                color: kGhostTypeColor1,
                              ),
                            ],
                            subtitle: '#092',
                          ),
                          VerticalSeparator(),
                          DataBox(
                            widgets: [
                              DataBoxTitle(
                                'Haunter',
                                color: kGhostTypeColor1,
                              ),
                            ],
                            subtitle: '#093',
                          ),
                          VerticalSeparator(),
                          DataBox(
                            widgets: [
                              DataBoxTitle(
                                'Gengar',
                                color: kGhostTypeColor1,
                              ),
                            ],
                            subtitle: '#094',
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      const SectionTitleText(
                        'Base Stats',
                        textColor: kGhostTypeColor1,
                      ),
                      SizedBox(height: 6),
                      Column(
                        children: const [
                          StatRow(
                            statLabel: 'HP',
                            stat: 60,
                            textColor: kGhostTypeColor1,
                            separatorColor: kGhostTypeColor4,
                          ),
                          StatRow(
                            statLabel: 'ATK',
                            stat: 65,
                            textColor: kGhostTypeColor1,
                            separatorColor: kGhostTypeColor4,
                          ),
                          StatRow(
                            statLabel: 'DEF',
                            stat: 60,
                            textColor: kGhostTypeColor1,
                            separatorColor: kGhostTypeColor4,
                          ),
                          StatRow(
                            statLabel: 'SATK',
                            stat: 130,
                            textColor: kGhostTypeColor1,
                            separatorColor: kGhostTypeColor4,
                          ),
                          StatRow(
                            statLabel: 'SDEF',
                            stat: 75,
                            textColor: kGhostTypeColor1,
                            separatorColor: kGhostTypeColor4,
                          ),
                          StatRow(
                            statLabel: 'SPD',
                            stat: 110,
                            textColor: kGhostTypeColor1,
                            separatorColor: kGhostTypeColor4,
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      const SectionTitleText(
                        'Type effectiveness',
                        textColor: kGhostTypeColor1,
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          EffectivenessText(text: 'Weak to'),
                          Expanded(
                            child: TypeEffectivenessGrid(
                              types: _weaknesses,
                              effectivenessValue: '2x',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          EffectivenessText(text: 'Immune to'),
                          Expanded(
                            child: TypeEffectivenessGrid(
                              types: _immuneTypes,
                              effectivenessValue: '0x',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          EffectivenessText(text: 'Resistant to'),
                          Expanded(
                            child: TypeEffectivenessGrid(
                                types: _resistants, effectivenessValue: '1/2x'),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          EffectivenessText(text: 'Damaged normally by'),
                          Expanded(
                            child: TypeEffectivenessGrid(
                              types: _normalDamageTypes,
                              effectivenessValue: '1x',
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

  void _toggleMegaEvolution() =>
      setState(() => _isMega ? _setRegularEvolution() : _setMegaEvolution());

  void _setRegularEvolution() {
    _mainPokemonAsset = 'images/gengar.gif';
    _isMega = false;
  }

  void _setMegaEvolution() {
    _mainPokemonAsset = 'images/mega_gengar.gif';
    _isMega = true;
  }
}

class EffectivenessText extends StatelessWidget {
  final String text;

  EffectivenessText({this.text});

  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: ScreenUtil.getInstance().setWidth(112),
      child: Text(
        text,
        maxLines: 3,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: kGhostTypeColor1,
          fontSize: ScreenUtil.getInstance().setSp(24),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class TypeEffectivenessGrid extends StatelessWidget {
  final List<PokemonTypes> types;
  final String effectivenessValue;

  TypeEffectivenessGrid({this.types, this.effectivenessValue});

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8),
      margin: EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: kGhostTypeColor4,
            width: 2,
          ),
        ),
      ),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(8),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: childAspectRatio(context),
          crossAxisSpacing: ScreenUtil.getInstance().setWidth(26),
          mainAxisSpacing: ScreenUtil.getInstance().setHeight(26),
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) => _buildTypeLabel(
          index,
          types,
          effectivenessValue,
        ),
        itemCount: types.length,
      ),
    );
  }

  double childAspectRatio(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait)
      return MediaQuery.of(context).size.width /
          (MediaQuery.of(context).size.height / 8);
    else
      return MediaQuery.of(context).size.height /
          (MediaQuery.of(context).size.width / 16);
  }

  TypeLabel _buildTypeLabel(
    int index,
    List<PokemonTypes> list,
    String effectivenessValue,
  ) {
    String title;
    String typeIconAsset;
    Color typeColor;

    switch (list[index]) {
      case PokemonTypes.GHOST:
        title = '${_extractType(PokemonTypes.GHOST)}';
        typeIconAsset = 'images/types/ghost.svg';
        typeColor = kGhostTypeColor1;
        break;
      case PokemonTypes.GROUND:
        title = '${_extractType(PokemonTypes.GROUND)}';
        typeIconAsset = 'images/types/ground.svg';
        typeColor = kGroundTypeColor1;
        break;
      case PokemonTypes.PSYCHIC:
        title = '${_extractType(PokemonTypes.PSYCHIC)}';
        typeIconAsset = 'images/types/psychic.svg';
        typeColor = kPsychicTypeColor1;
        break;
      case PokemonTypes.DARK:
        title = '${_extractType(PokemonTypes.DARK)}';
        typeIconAsset = 'images/types/dark.svg';
        typeColor = kDarkTypeColor1;
        break;
      case PokemonTypes.BUG:
        title = '${_extractType(PokemonTypes.BUG)}';
        typeIconAsset = 'images/types/bug.svg';
        typeColor = kBugTypeColor1;
        break;
      case PokemonTypes.DRAGON:
        title = '${_extractType(PokemonTypes.DRAGON)}';
        typeIconAsset = 'images/types/dragon.svg';
        typeColor = kDragonTypeColor1;
        break;
      case PokemonTypes.FAIRY:
        title = '${_extractType(PokemonTypes.FAIRY)}';
        typeIconAsset = 'images/types/fairy.svg';
        typeColor = kFairyTypeColor1;
        break;
      case PokemonTypes.FIRE:
        title = '${_extractType(PokemonTypes.FIRE)}';
        typeIconAsset = 'images/types/fire.svg';
        typeColor = kFightTypeColor1;
        break;
      case PokemonTypes.NORMAL:
        title = '${_extractType(PokemonTypes.NORMAL)}';
        typeIconAsset = 'images/types/normal.svg';
        typeColor = kNormalTypeColor1;
        break;
      case PokemonTypes.STEEL:
        title = '${_extractType(PokemonTypes.STEEL)}';
        typeIconAsset = 'images/types/steel.svg';
        typeColor = kSteelTypeColor1;
        break;
      case PokemonTypes.ELECTRIC:
        title = '${_extractType(PokemonTypes.ELECTRIC)}';
        typeIconAsset = 'images/types/electric.svg';
        typeColor = kElectricTypeColor1;
        break;
      case PokemonTypes.FIGHT:
        title = '${_extractType(PokemonTypes.FIGHT)}';
        typeIconAsset = 'images/types/fight.svg';
        typeColor = kFightTypeColor1;
        break;
      case PokemonTypes.FLYING:
        title = '${_extractType(PokemonTypes.FLYING)}';
        typeIconAsset = 'images/types/flying.svg';
        typeColor = kFlyingTypeColor1;
        break;
      case PokemonTypes.GRASS:
        title = '${_extractType(PokemonTypes.GRASS)}';
        typeIconAsset = 'images/types/grass.svg';
        typeColor = kGrassTypeColor1;
        break;
      case PokemonTypes.ICE:
        title = '${_extractType(PokemonTypes.ICE)}';
        typeIconAsset = 'images/types/ice.svg';
        typeColor = kIceTypeColor1;
        break;
      case PokemonTypes.ROCK:
        title = '${_extractType(PokemonTypes.ROCK)}';
        typeIconAsset = 'images/types/rock.svg';
        typeColor = kRockTypeColor1;
        break;
      case PokemonTypes.WATER:
        title = '${_extractType(PokemonTypes.WATER)}';
        typeIconAsset = 'images/types/water.svg';
        typeColor = kWaterTypeColor1;
        break;
      case PokemonTypes.POISON:
        title = '${_extractType(PokemonTypes.POISON)}';
        typeIconAsset = 'images/types/water.svg';
        typeColor = kWaterTypeColor1;
        break;
    }

    return TypeLabel(
      title,
      color: typeColor,
      typeIcon: typeIconAsset,
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtil.getInstance().setHeight(2),
        horizontal: ScreenUtil.getInstance().setWidth(24),
      ),
      typeIconSize: 32,
      titleSize: 24,
      widget: EffectivenessValue(value: effectivenessValue),
    );
  }

  String _extractType(PokemonTypes pokemonTypes) =>
      pokemonTypes.toString().split('.')[1];
}
