import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pokedex/widgets/vertical_separator.dart';
import 'package:pokedex/widgets/arc_dlipper.dart';
import 'package:pokedex/widgets/base_stat_text.dart';
import 'package:pokedex/widgets/base_stats_slider.dart';
import 'package:pokedex/widgets/data_box.dart';
import 'package:pokedex/widgets/evolution_condition_box.dart';
import 'package:pokedex/widgets/evolution_image.dart';
import 'package:pokedex/widgets/glow_free_listView.dart';
import 'package:pokedex/widgets/section_title_text.dart';
import 'package:pokedex/widgets/type_label.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                  clipper: const ArcClipper(),
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
                          const TypeLabel(
                            'Ghost',
                            color: Color(0xFF6647B8),
                          ),
                          const TypeLabel(
                            'Poison',
                            color: Color(0xFF9F60E1),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const DataBox('Shadow', subtitle: 'Species'),
                          const VerticalSeparator(),
                          const DataBox('4\' 11\"', subtitle: 'Height'),
                          const VerticalSeparator(),
                          const DataBox('89.3 lbs', subtitle: 'Weight'),
                        ],
                      ),
                      SizedBox(height: 24),
                      const SectionTitleText(
                        'Evolution',
                        textColor: Color(0xFF6647B8),
                      ),
                      SizedBox(height: 6),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const EvolutionImage('images/gastly.gif'),
                          const EvolutionConditionBox(
                            'images/evolution_icons/l25.png',
                          ),
                          const EvolutionImage('images/haunter.gif'),
                          const EvolutionConditionBox(
                            'images/evolution_icons/trade.png',
                          ),
                          const EvolutionImage('images/gengar.gif'),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DataBox('Gastly', subtitle: '#092'),
                          const VerticalSeparator(),
                          DataBox('Haunter', subtitle: '#093'),
                          const VerticalSeparator(),
                          DataBox('Gengar', subtitle: '#094'),
                        ],
                      ),
                      SizedBox(height: 24),
                      const SectionTitleText(
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
                              const BaseStatText(stat: 'HP'),
                              const BaseStatText(stat: 'ATK'),
                              const BaseStatText(stat: 'DEF'),
                              const BaseStatText(stat: 'SATK'),
                              const BaseStatText(stat: 'SDEF'),
                              const BaseStatText(stat: 'SPD'),
                            ],
                          ),
                          const VerticalSeparator(height: 140),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const BaseStatText(stat: '60', width: 31),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: const BaseStatSlider(value: 60),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const BaseStatText(stat: '65', width: 31),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: const BaseStatSlider(value: 65),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const BaseStatText(stat: '60', width: 31),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: const BaseStatSlider(value: 60),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const BaseStatText(stat: '130', width: 31),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: const BaseStatSlider(value: 130),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const BaseStatText(stat: '75', width: 31),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: const BaseStatSlider(value: 75),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const BaseStatText(stat: '110', width: 31),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: const BaseStatSlider(value: 110),
                                    ),
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
