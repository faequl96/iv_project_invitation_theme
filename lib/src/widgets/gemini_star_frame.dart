import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ShowStars extends Equatable {
  const ShowStars({
    this.topLeft = true,
    this.topRight = true,
    this.bottomLeft = true,
    this.bottomRight = true,
  });

  final bool topLeft;
  final bool topRight;
  final bool bottomLeft;
  final bool bottomRight;

  @override
  List<Object?> get props => [topLeft, topRight, bottomLeft, bottomRight];
}

class StarOffsets extends Equatable {
  const StarOffsets({this.left = 0, this.right = 0, this.top = 0, this.bottom = 0});

  final double left;
  final double right;
  final double top;
  final double bottom;

  @override
  List<Object?> get props => [left, right, top, bottom];
}

class GeminiStarFrame extends StatelessWidget {
  const GeminiStarFrame({
    super.key,
    this.color = Colors.grey,
    this.lineWidth = .5,
    this.starRadius = 22,
    this.showStars = const ShowStars(),
    this.starOffsets = const StarOffsets(),
  });

  final Color color;
  final double lineWidth;
  final double starRadius;
  final ShowStars showStars;
  final StarOffsets starOffsets;

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

class _GeminiStarFramePainter extends CustomPainter {
  _GeminiStarFramePainter({
    required this.color,
    required this.lineWidth,
    required this.starRadius,
    required this.showStars,
    required this.starOffsets,
  }) {
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

  final Color color;
  final double lineWidth;
  final double starRadius;
  final ShowStars showStars;
  final StarOffsets starOffsets;
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
