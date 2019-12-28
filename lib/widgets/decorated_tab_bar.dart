import 'package:flutter/material.dart';

class DecoratedTabBar extends StatelessWidget implements PreferredSizeWidget {
  DecoratedTabBar({@required this.tabBar, @required this.decoration});

  final TabBar tabBar;
  final BoxDecoration decoration;

  Size get preferredSize => tabBar.preferredSize;

  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(decoration: decoration),
          bottom: 2.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: tabBar,
        ),
      ],
    );
  }
}
