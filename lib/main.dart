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
          _setScreenUtil(orientation, context);

          return ProfileScreen();
        },
      ),
    );
  }

  void _setScreenUtil(Orientation orientation, BuildContext context) {
    var width = 768.0;
    var height = 1024.0;

    if (orientation == Orientation.landscape) {
      width = 1024.0;
      height = 768.0;
    }

    ScreenUtil.instance = ScreenUtil(
      width: width,
      height: height,
      allowFontScaling: true,
    )..init(context);
  }
}
