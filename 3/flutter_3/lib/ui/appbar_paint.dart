
import 'package:flutter/widgets.dart';

class AppBarPaint extends CustomPainter {
  final Color foreground;

  const AppBarPaint({
    required this.foreground,
    super.repaint,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final h = size.height;
    final w = size.width;
    final paint = Paint()
      ..color = foreground
      ..style = PaintingStyle.fill;
    final shape = Path()
      ..moveTo(0, h)
      ..lineTo(w, h)
      ..lineTo(w, 0)
      ..quadraticBezierTo(w / 2, h * 1.25, 0, 0)
      ..close();
    canvas.drawPath(shape, paint);
  }

  @override
  bool shouldRepaint(AppBarPaint oldDelegate) =>
      oldDelegate.foreground != foreground;
}
