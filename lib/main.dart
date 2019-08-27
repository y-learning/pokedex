import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'screens/profile_screen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokedex',
      home: ProfileScreen(),
    );
  }
}
