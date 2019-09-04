import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokedex/widgets/effectiveness_text.dart';
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

  List<String> _weaknessesEffectivenessValues = [
    '2',
    '2',
    '2',
    '2',
  ];

  List<PokemonTypes> _immuneTypes = [
    PokemonTypes.NORMAL,
    PokemonTypes.FIGHT,
  ];

  List<String> _immuneEffectivenessValues = [
    '0',
    '0',
  ];

  List<PokemonTypes> _resistants = [
    PokemonTypes.POISON,
    PokemonTypes.BUG,
    PokemonTypes.GRASS,
    PokemonTypes.FAIRY,
  ];

  List<String> _resistantEffectivenessValues = [
    '1/4',
    '1/4',
    '1/2',
    '1/2',
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

  List<String> _normalEffectivenessValues = [
    '1',
    '1',
    '1',
    '1',
    '1',
    '1',
    '1',
    '1',
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
                              effectivenessValues:
                                  _weaknessesEffectivenessValues,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: ScreenUtil.getInstance().setHeight(16)),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          EffectivenessText(text: 'Immune to'),
                          Expanded(
                            child: TypeEffectivenessGrid(
                              types: _immuneTypes,
                              effectivenessValues: _immuneEffectivenessValues,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: ScreenUtil.getInstance().setHeight(16)),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          EffectivenessText(text: 'Resistant to'),
                          Expanded(
                            child: TypeEffectivenessGrid(
                              types: _resistants,
                              effectivenessValues:
                                  _resistantEffectivenessValues,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: ScreenUtil.getInstance().setHeight(16)),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          EffectivenessText(text: 'Damaged normally by'),
                          Expanded(
                            child: TypeEffectivenessGrid(
                              types: _normalDamageTypes,
                              effectivenessValues: _normalEffectivenessValues,
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
