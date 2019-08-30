import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'screens/profile_screen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          var width = 0.0;
          var height = 0.0;
          if (_isPortrait(orientation)) {
            width = 768;
            height = 1024;
          } else {
            height = 768;
            width = 1024;
          }

          ScreenUtil.instance = ScreenUtil(
            width: width,
            height: height,
            allowFontScaling: true,
          )..init(context);

          return ProfileScreen();
        },
      ),
    );
  }

  bool _isPortrait(Orientation orientation) =>
      orientation == Orientation.portrait;
}
