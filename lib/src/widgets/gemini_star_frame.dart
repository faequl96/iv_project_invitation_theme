import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class const ShowStars({
  final bool topLeft = true,
  final bool topRight = true,
  final bool bottomLeft = true,
  final bool bottomRight = true,
}) extends Equatable {
  @override
  List<Object?> get props => [topLeft, topRight, bottomLeft, bottomRight];
}

class const StarOffsets({
  final double left = 0,
  final double right = 0,
  final double top = 0,
  final double bottom = 0,
}) extends Equatable {
  @override
  List<Object?> get props => [left, right, top, bottom];
}

class const GeminiStarFrame({
  super.key,
  final Color color = Colors.grey,
  final double lineWidth = .5,
  final double starRadius = 22,
  final ShowStars showStars = const ShowStars(),
  final StarOffsets starOffsets = const StarOffsets(),
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: CustomPaint(
        foregroundPainter: _GeminiStarFramePainter(
          color: color,
          lineWidth: lineWidth,
          starRadius: starRadius,
          showStars: showStars,
          starOffsets: starOffsets,
        ),
      ),
    );
  }
}

class _GeminiStarFramePainter({
  required final Color color,
  required final double lineWidth,
  required final double starRadius,
  required final ShowStars showStars,
  required final StarOffsets starOffsets,
}) extends CustomPainter {
  this {
    _framePaint = Paint()
      ..color = color
      ..strokeWidth = lineWidth
      ..style = .stroke
      ..strokeCap = .square
      ..isAntiAlias = true;

    _starPaint = Paint()
      ..color = color
      ..style = .fill
      ..isAntiAlias = true;
  }

  late final Paint _framePaint;
  late final Paint _starPaint;

  @override
  void paint(Canvas canvas, Size size) {
    const double zero = .0;

    final r = starRadius;
    final innerR = r * .65;
    final hw = lineWidth / 2;

    final tl = Offset(starOffsets.left, starOffsets.top);
    final tr = Offset(size.width - starOffsets.right, starOffsets.top);
    final bl = Offset(starOffsets.left, size.height - starOffsets.bottom);
    final br = Offset(size.width - starOffsets.right, size.height - starOffsets.bottom);

    final drawTop = showStars.topLeft || showStars.topRight;
    final drawBottom = showStars.bottomLeft || showStars.bottomRight;
    final drawLeft = showStars.topLeft || showStars.bottomLeft;
    final drawRight = showStars.topRight || showStars.bottomRight;

    if (drawTop) canvas.drawLine(Offset(zero, tl.dy), Offset(size.width, tr.dy), _framePaint);
    if (drawBottom) canvas.drawLine(Offset(zero, bl.dy), Offset(size.width, br.dy), _framePaint);
    if (drawLeft) canvas.drawLine(Offset(tl.dx, zero), Offset(bl.dx, size.height), _framePaint);
    if (drawRight) canvas.drawLine(Offset(tr.dx, zero), Offset(br.dx, size.height), _framePaint);

    if (showStars.topLeft) _drawBluntStar(canvas, tl, innerR, hw, _starPaint);
    if (showStars.topRight) _drawBluntStar(canvas, tr, innerR, hw, _starPaint);
    if (showStars.bottomLeft) _drawBluntStar(canvas, bl, innerR, hw, _starPaint);
    if (showStars.bottomRight) _drawBluntStar(canvas, br, innerR, hw, _starPaint);
  }

  void _drawBluntStar(Canvas canvas, Offset center, double radius, double hw, Paint paint) {
    final cx = center.dx;
    final cy = center.dy;

    final path = Path()
      ..moveTo(cx + hw, cy - radius)
      ..quadraticBezierTo(cx + hw, cy - hw, cx + radius, cy - hw)
      ..lineTo(cx + radius, cy + hw)
      ..quadraticBezierTo(cx + hw, cy + hw, cx + hw, cy + radius)
      ..lineTo(cx - hw, cy + radius)
      ..quadraticBezierTo(cx - hw, cy + hw, cx - radius, cy + hw)
      ..lineTo(cx - radius, cy - hw)
      ..quadraticBezierTo(cx - hw, cy - hw, cx - hw, cy - radius)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _GeminiStarFramePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.lineWidth != lineWidth ||
        oldDelegate.starRadius != starRadius ||
        oldDelegate.showStars != showStars ||
        oldDelegate.starOffsets != starOffsets;
  }
}
