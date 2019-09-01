import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokedex/widgets/vertical_separator.dart';
import 'package:pokedex/widgets/arc_dlipper.dart';
import 'package:pokedex/widgets/base_stat_row.dart';
import 'package:pokedex/widgets/data_box.dart';
import 'package:pokedex/widgets/evolution_condition_box.dart';
import 'package:pokedex/widgets/evolution_image.dart';
import 'package:pokedex/widgets/glow_free_listView.dart';
import 'package:pokedex/widgets/section_title_text.dart';
import 'package:pokedex/widgets/type_label.dart';

import '../constants.dart';

class ProfileScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        backgroundColor: kGhostLightColor,
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
                        colors: kGhostGradient,
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
                        children: const [
                          TypeLabel(
                            'Ghost',
                            color: kGhostTypeColor,
                          ),
                          SizedBox(width: 40),
                          TypeLabel(
                            'Poison',
                            color: kPoisonTypeColor,
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          DataBox(
                            'Shadow',
                            subtitle: 'Species',
                            titleMaxLines: 2,
                            color: kGhostTypeColor,
                          ),
                          VerticalSeparator(),
                          DataBox(
                            '4\' 11\"',
                            subtitle: 'Height',
                            color: kGhostTypeColor,
                          ),
                          VerticalSeparator(),
                          DataBox(
                            '8956.3 lbs',
                            subtitle: 'Weight',
                            color: kGhostTypeColor,
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      const SectionTitleText(
                        'Evolution',
                        textColor: kGhostTypeColor,
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
                            hoverColor: kGhostLightColor,
                          ),
                          EvolutionImage('images/haunter.gif'),
                          EvolutionConditionBox(
                            assetName: 'images/evolution_icons/trade.png',
                            hoverMessage: 'Trade',
                            hoverColor: kGhostLightColor,
                          ),
                          EvolutionImage('images/gengar.gif'),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          DataBox(
                            'Gastly',
                            subtitle: '#092',
                            color: kGhostTypeColor,
                          ),
                          VerticalSeparator(),
                          DataBox(
                            'Haunter',
                            subtitle: '#093',
                            color: kGhostTypeColor,
                          ),
                          VerticalSeparator(),
                          DataBox(
                            'Gengar',
                            subtitle: '#094',
                            color: kGhostTypeColor,
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      const SectionTitleText(
                        'Base Stats',
                        textColor: kGhostTypeColor,
                      ),
                      SizedBox(height: 6),
                      Column(
                        children: const [
                          StatRow(
                            statLabel: 'HP',
                            stat: 60,
                            textColor: kGhostTypeColor,
                            separatorColor: kGhostLightColor,
                          ),
                          StatRow(
                            statLabel: 'ATK',
                            stat: 65,
                            textColor: kGhostTypeColor,
                            separatorColor: kGhostLightColor,
                          ),
                          StatRow(
                            statLabel: 'DEF',
                            stat: 60,
                            textColor: kGhostTypeColor,
                            separatorColor: kGhostLightColor,
                          ),
                          StatRow(
                            statLabel: 'SATK',
                            stat: 130,
                            textColor: kGhostTypeColor,
                            separatorColor: kGhostLightColor,
                          ),
                          StatRow(
                            statLabel: 'SDEF',
                            stat: 75,
                            textColor: kGhostTypeColor,
                            separatorColor: kGhostLightColor,
                          ),
                          StatRow(
                            statLabel: 'SPD',
                            stat: 110,
                            textColor: kGhostTypeColor,
                            separatorColor: kGhostLightColor,
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
              top: MediaQuery.of(context).size.height * .05,
            ),
            child: Image(
              height: MediaQuery.of(context).size.height * .24,
              width: MediaQuery.of(context).size.height * .24,
              image: AssetImage('images/gengar.gif'),
            ),
          )
        ],
      ),
    );
  }
}
