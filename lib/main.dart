import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      home: Scaffold(
        backgroundColor: Colors.red,
      ),
    );
  }
}
