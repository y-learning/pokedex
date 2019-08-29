import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/screens/vertical_separator.dart';
import 'package:pokedex/widgets/arc_dlipper.dart';
import 'package:pokedex/widgets/base_stat_text.dart';
import 'package:pokedex/widgets/base_stats_slider.dart';
import 'package:pokedex/widgets/data_box.dart';
import 'package:pokedex/widgets/evolution_condition_box.dart';
import 'package:pokedex/widgets/evolution_image.dart';
import 'package:pokedex/widgets/glow_free_listView.dart';
import 'package:pokedex/widgets/section_title_text.dart';
import 'package:pokedex/widgets/type_label.dart';

class ProfileScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Color(0xFF9374D4),
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
                  clipper: ArcClipper(),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: [0.1, 0.4, 0.6, 0.9],
                        colors: [
                          Color(0xFF684AB9),
                          Color(0xFF7757C3),
                          Color(0xFF8364CA),
                          Color(0xFF9374D4),
                        ],
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
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '#094',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
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
                  padding: EdgeInsets.only(top: 90, right: 28, left: 28),
                  child: GlowFreeListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TypeLabel(
                            'Ghost',
                            color: Color(0xFF6647B8),
                          ),
                          TypeLabel(
                            'Poison',
                            color: Color(0xFF9F60E1),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DataBox('Shadow', subtitle: 'Species'),
                          VerticalSeparator(),
                          DataBox('4\' 11\"', subtitle: 'Height'),
                          VerticalSeparator(),
                          DataBox('89.3 lbs', subtitle: 'Weight'),
                        ],
                      ),
                      SizedBox(height: 24),
                      SectionTitleText(
                        'Evolution',
                        textColor: Color(0xFF6647B8),
                      ),
                      SizedBox(height: 6),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          EvolutionImage('images/gastly.gif'),
                          EvolutionConditionBox(
                            'images/evolution_icons/l25.png',
                          ),
                          EvolutionImage('images/haunter.gif'),
                          EvolutionConditionBox(
                            'images/evolution_icons/trade.png',
                          ),
                          EvolutionImage('images/gengar.gif'),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DataBox('Gastly', subtitle: '#092'),
                          VerticalSeparator(),
                          DataBox('Haunter', subtitle: '#093'),
                          VerticalSeparator(),
                          DataBox('Gengar', subtitle: '#094'),
                        ],
                      ),
                      SizedBox(height: 24),
                      SectionTitleText(
                        'Base Stats',
                        textColor: Color(0xFF6647B8),
                      ),
                      SizedBox(height: 6),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              BaseStatText(stat: 'HP'),
                              BaseStatText(stat: 'ATK'),
                              BaseStatText(stat: 'DEF'),
                              BaseStatText(stat: 'SATK'),
                              BaseStatText(stat: 'SDEF'),
                              BaseStatText(stat: 'SPD'),
                            ],
                          ),
                          VerticalSeparator(height: 140),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    BaseStatText(stat: '60', width: 31),
                                    SizedBox(width: 16),
                                    Expanded(child: BaseStatSlider(value: 60)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    BaseStatText(stat: '65', width: 31),
                                    SizedBox(width: 16),
                                    Expanded(child: BaseStatSlider(value: 65)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    BaseStatText(stat: '60', width: 31),
                                    SizedBox(width: 16),
                                    Expanded(child: BaseStatSlider(value: 60)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    BaseStatText(stat: '130', width: 31),
                                    SizedBox(width: 16),
                                    Expanded(child: BaseStatSlider(value: 130)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    BaseStatText(stat: '75', width: 31),
                                    SizedBox(width: 16),
                                    Expanded(child: BaseStatSlider(value: 75)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    BaseStatText(stat: '110', width: 31),
                                    SizedBox(width: 16),
                                    Expanded(child: BaseStatSlider(value: 110)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * .07,
            ),
            child: Image(
              height: MediaQuery.of(context).size.height * .22,
              width: MediaQuery.of(context).size.height * .22,
              image: AssetImage('images/gengar.gif'),
            ),
          )
        ],
      ),
    );
  }
}
