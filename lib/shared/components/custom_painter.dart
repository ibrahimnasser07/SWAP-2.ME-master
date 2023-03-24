import 'dart:math' as math;

import 'package:flutter/material.dart';

class ImageCustomPainter extends CustomClipper<Path> {
  double move = 0;
  double slice = math.pi;

  ImageCustomPainter(this.move);

  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height * 0.8);
    double xCenter =
        size.width * 0.5 + (size.width * 0.6 + 1) * math.sin(move * slice);
    double yCenter = size.height * 0.8 + 69 * math.cos(move * slice);
    path.quadraticBezierTo(xCenter, yCenter, size.width, size.height * 0.8);

    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}