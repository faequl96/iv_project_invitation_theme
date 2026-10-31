import 'package:flutter/material.dart';

class ThreeDimensionSafeAreaPainter() extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black.withValues(alpha: .002);
    canvas.drawPoints(.points, [.zero, .new(size.width, size.height)], paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
