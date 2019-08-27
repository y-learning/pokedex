import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
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
                child: Container(
                  padding: EdgeInsets.only(top: 90, right: 48, left: 48),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFF6647B8),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            width: 170,
                            height: 32,
                            child: Text(
                              'Ghost',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            alignment: Alignment.center,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFF9F60E1),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            width: 170,
                            height: 32,
                            child: Text(
                              'Poison',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            alignment: Alignment.center,
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Shadow',
                                style: TextStyle(
                                  color: Color(0xFF6647B8),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Species',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          VerticalSeparator(),
                          Column(
                            children: [
                              Text(
                                '4\' 11\"',
                                style: TextStyle(
                                  color: Color(0xFF6647B8),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Height',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          VerticalSeparator(),
                          Column(
                            children: [
                              Text(
                                '89.3 lbs',
                                style: TextStyle(
                                  color: Color(0xFF6647B8),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Weight',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      Text(
                        'Evolution',
                        style: TextStyle(
                          color: Color(0xFF6647B8),
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 6),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image(
                            height: 100,
                            width: 100,
                            image: AssetImage('images/gastly.gif'),
                          ),
                          Container(
                            width: 42,
                            child: Text(
                              'Level 25',
                              style: TextStyle(
                                color: Color(0xFF6647B8),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Image(
                            height: 100,
                            width: 100,
                            image: AssetImage('images/haunter.gif'),
                          ),
                          Container(
                            width: 42,
                            child: Text(
                              'Trade',
                              style: TextStyle(
                                color: Color(0xFF6647B8),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Image(
                            height: 100,
                            width: 100,
                            image: AssetImage('images/gengar.gif'),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Gastly',
                                  style: TextStyle(
                                    color: Color(0xFF6647B8),
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '#092',
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 42,
                            child: VerticalSeparator(),
                          ),
                          Container(
                            width: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Haunter',
                                  style: TextStyle(
                                    color: Color(0xFF6647B8),
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '#093',
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 42,
                            child: VerticalSeparator(),
                          ),
                          Container(
                            width: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Gengar',
                                  style: TextStyle(
                                    color: Color(0xFF6647B8),
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '#094',
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 24),
                      Text(
                        'Base Stats',
                        style: TextStyle(
                          color: Color(0xFF6647B8),
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 6),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            children: [
                              Text(
                                'HP',
                                style: TextStyle(
                                  color: Color(0xFF6647B8),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'ATK',
                                style: TextStyle(
                                  color: Color(0xFF6647B8),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'DEF',
                                style: TextStyle(
                                  color: Color(0xFF6647B8),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'SATK',
                                style: TextStyle(
                                  color: Color(0xFF6647B8),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'SDEF',
                                style: TextStyle(
                                  color: Color(0xFF6647B8),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'SPD',
                                style: TextStyle(
                                  color: Color(0xFF6647B8),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: VerticalSeparator(height: 140),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 31,
                                      child: Text(
                                        '60',
                                        style: TextStyle(
                                          color: Color(0xFF6647B8),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: BaseStatsSlider(
                                        value: 60,
                                        onChanged: (v) {},
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 31,
                                      child: Text(
                                        '65',
                                        style: TextStyle(
                                          color: Color(0xFF6647B8),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: BaseStatsSlider(
                                        value: 65,
                                        onChanged: (v) {},
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: 31,
                                      child: Text(
                                        '60',
                                        style: TextStyle(
                                          color: Color(0xFF6647B8),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: BaseStatsSlider(
                                        value: 60,
                                        onChanged: (v) {},
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: 31,
                                      child: Text(
                                        '130',
                                        style: TextStyle(
                                          color: Color(0xFF6647B8),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: BaseStatsSlider(
                                        value: 130,
                                        onChanged: (v) {},
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: 31,
                                      child: Text(
                                        '75',
                                        style: TextStyle(
                                          color: Color(0xFF6647B8),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: BaseStatsSlider(
                                        value: 75,
                                        onChanged: (v) {},
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 31,
                                      child: Text(
                                        '110',
                                        style: TextStyle(
                                          color: Color(0xFF6647B8),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: BaseStatsSlider(
                                        value: 110,
                                        onChanged: (v) {},
                                      ),
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

class VerticalSeparator extends StatelessWidget {
  final double height;

  VerticalSeparator({this.height = 60});

  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF9374D4),
      height: height,
      width: 2,
    );
  }
}

class ArcClipper extends CustomClipper<Path> {
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 20);

    path.quadraticBezierTo(
      size.width / 2,
      size.height + 20,
      size.width,
      size.height - 20,
    );

    path.lineTo(size.width, 0);

    return path;
  }

  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class BaseStatsSlider extends StatelessWidget {
  final double value;
  final Function(double v) onChanged;

  const BaseStatsSlider({this.value, this.onChanged});

  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 8.0,
        disabledActiveTrackColor: Color(0xFF6647B8),
        disabledInactiveTrackColor: Colors.grey,
        activeTrackColor: Color(0xFF6647B8),
        inactiveTrackColor: Colors.grey,
        thumbColor: Colors.white,
        thumbShape: RoundSliderThumbShape(
          enabledThumbRadius: 0.0,
        ),
        overlayShape: RoundSliderOverlayShape(
          overlayRadius: 0.0,
        ),
        overlayColor: Color(0x29EA1556),
      ),
      child: Slider(
        value: value,
        max: 200,
        min: 0.0,
        onChanged: onChanged,
      ),
    );
  }
}
