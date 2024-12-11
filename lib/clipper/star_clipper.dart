// Custom clipper to draw a star shape
import 'dart:math';
import 'package:flutter/material.dart';

class StarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width / 2;
    final innerRadius = outerRadius / 2.5;
    const angle = pi / 5;

    for (int i = 0; i < 10; i++) {
      final isOuter = i.isEven; // Alternate between outer and inner points
      final radius = isOuter ? outerRadius : innerRadius;
      final x = center.dx + radius * cos(i * angle - pi / 2);
      final y = center.dy + radius * sin(i * angle - pi / 2);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
