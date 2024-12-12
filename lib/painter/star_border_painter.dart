import '../export.dart';

// Custom painter to draw the border of the star
class StarBorderPainter extends CustomPainter {
  final Color borderColor; // Color for the star border

  StarBorderPainter({required this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0; // Border thickness

    // Draw the border using the star shape path
    final path = StarClipper().getClip(size);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
