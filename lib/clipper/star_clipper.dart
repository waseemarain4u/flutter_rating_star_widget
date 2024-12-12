import '../export.dart';

// Custom clipper to create a star shape
class StarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width / 2; // Outer radius of the star
    final innerRadius = outerRadius / 2.5; // Inner radius of the star
    const angle = pi / 5; // Angle between points in the star shape
    // Draw the star shape by alternating between outer and inner points
    for (int i = 0; i < 10; i++) {
      final isOuter = i.isEven;
      final radius = isOuter ? outerRadius : innerRadius;
      final x = center.dx + radius * cos(i * angle - pi / 2);
      final y = center.dy + radius * sin(i * angle - pi / 2);
      if (i == 0) {
        path.moveTo(x, y); // Move to the first point
      } else {
        path.lineTo(x, y); // Draw lines to subsequent points
      }
    }
    path.close(); // Close the path to complete the star
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
