import 'dart:ui';

import 'package:flutter/cupertino.dart';

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

  bool shouldReclip(CustomClipper<Path> oldClipper) => true;

  const ArcClipper();
}
