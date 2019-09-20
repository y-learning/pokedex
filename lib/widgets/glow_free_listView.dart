import 'package:flutter/material.dart';

class GlowFreeListView extends StatelessWidget {
  final List<Widget> children;

  GlowFreeListView({this.children});

  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: NoScrollBehavior(),
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 8,
        ),
        children: children,
      ),
    );
  }
}

class NoScrollBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
