// Custom painter to draw the border for the star shape
import 'package:flutter/material.dart';
import 'package:flutter_rating_star_widget/clipper/star_clipper.dart';

class StarBorderPainter extends CustomPainter {
  final Color borderColor;

  StarBorderPainter({required this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final path = StarClipper().getClip(size);
    canvas.drawPath(path, paint); // Draw the star border
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
