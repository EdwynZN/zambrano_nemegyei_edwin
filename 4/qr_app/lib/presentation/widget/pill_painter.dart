import 'package:flutter/material.dart';

/// Pill paint to draw above the Sheet in a modal BottomSheet
class PillIconPaint extends CustomPainter {
  final Color foreground;

  const PillIconPaint({
    required this.foreground,
    super.repaint,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.height < 25.0 || size.width < 100.0) {
      return;
    }
    const double strokeWidth = 6.0;
    final double middle = size.width / 2.0;
    const double width = 72.0;
    const double halfWidth = width / 2.0;
    final Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..color = foreground
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final path = Path()
      ..moveTo(middle - halfWidth, 8.0)
      ..relativeLineTo(width, 0.0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(PillIconPaint oldDelegate) =>
      oldDelegate.foreground != foreground;
}
