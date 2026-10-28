import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class const ElysianStardustBackground({
  super.key,
  final int particleCount = 60,
  final Color primaryGlowColor = const Color(0xFFD4AF37),
  final Color secondaryGlowColor = const Color(0xFFFFD700),
}) extends StatefulWidget {
  @override
  State<ElysianStardustBackground> createState() => _ElysianStardustBackgroundState();
}

class _ElysianStardustBackgroundState()
    extends State<ElysianStardustBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final _random = Random();
  final _progressNotifier = ValueNotifier<double>(.0);
  double _lastControllerValue = .0;

  ui.Image? _atlasImage;
  late _ParticleBuffers _buffers;

  @override
  void initState() {
    super.initState();
    _buffers = _ParticleBuffers(widget.particleCount, _random);
    _bakeSpriteAtlas();

    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 10))
      ..addListener(_onTick)
      ..repeat();
  }

  Future<void> _bakeSpriteAtlas() async {
    const double cellSize = 64;
    const double center = cellSize / 2;
    const double baseRadius = 8;

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    final glowPaint = Paint()
      ..color = Colors.white.withValues(alpha: .75)
      ..maskFilter = const MaskFilter.blur(.normal, baseRadius * 1.6);

    final corePaint = Paint()..color = Colors.white.withValues(alpha: .95);

    canvas.drawCircle(const Offset(center, center), baseRadius * 2, glowPaint);
    canvas.drawCircle(const Offset(center, center), baseRadius * .85, corePaint);

    canvas.drawCircle(const Offset(cellSize + center, center), baseRadius * 2, glowPaint);
    canvas.drawCircle(const Offset(cellSize + center, center), baseRadius, corePaint);

    final picture = recorder.endRecording();
    final image = await picture.toImage((cellSize * 2).toInt(), cellSize.toInt());

    if (!mounted) {
      image.dispose();
      return;
    }
    setState(() => _atlasImage = image);
  }

  void _onTick() {
    final value = _controller.value;
    final delta = value >= _lastControllerValue
        ? value - _lastControllerValue
        : (1 - _lastControllerValue) + value;
    _progressNotifier.value += delta;
    _lastControllerValue = value;
  }

  @override
  void didUpdateWidget(covariant ElysianStardustBackground oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.particleCount != widget.particleCount) {
      _buffers = _ParticleBuffers(widget.particleCount, _random);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _progressNotifier.dispose();
    _atlasImage?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final atlas = _atlasImage;
    if (atlas == null) return const SizedBox.expand();

    return RepaintBoundary(
      child: CustomPaint(
        size: .infinite,
        painter: _StardustAtlasPainter(
          atlas: atlas,
          buffers: _buffers,
          progressListenable: _progressNotifier,
          primaryColor: widget.primaryGlowColor,
          secondaryColor: widget.secondaryGlowColor,
        ),
      ),
    );
  }
}

class _ParticleBuffers(final int count, Random random) {
  this
    : x = Float32List(count),
      y = Float32List(count),
      scale = Float32List(count),
      alpha = Float32List(count),
      speedY = Float32List(count),
      driftX = Float32List(count),
      driftPhase = Float32List(count),
      twinklePhase = Float32List(count),
      flags = Uint8List(count),
      transforms = Float32List(count * 4),
      rects = Float32List(count * 4),
      colors = Int32List(count) {
    for (var i = 0; i < count; i++) {
      x[i] = random.nextDouble();
      y[i] = random.nextDouble();

      final radius = random.nextDouble() * 2.5 + 1;
      scale[i] = radius / 8;

      alpha[i] = random.nextDouble() * .7 + .2;
      speedY[i] = random.nextDouble() * .10 + .03;
      driftX[i] = (random.nextDouble() - .5) * .04;
      driftPhase[i] = random.nextDouble() * 2 * pi;
      twinklePhase[i] = random.nextDouble() * 2 * pi;

      final colorRoll = random.nextDouble();
      final int colorType;
      if (colorRoll < .40) {
        colorType = 2;
      } else if (colorRoll < .70) {
        colorType = 0;
      } else {
        colorType = 1;
      }

      final hasBrightCore = colorType == 2 || random.nextInt(7) >= 5;
      flags[i] = colorType | (hasBrightCore ? 4 : 0);

      final rectIdx = i * 4;
      final double left = hasBrightCore ? 64 : .0;
      rects[rectIdx] = left;
      rects[rectIdx + 1] = .0;
      rects[rectIdx + 2] = left + 64;
      rects[rectIdx + 3] = 64;
    }
  }

  final Float32List x;
  final Float32List y;
  final Float32List scale;
  final Float32List alpha;
  final Float32List speedY;
  final Float32List driftX;
  final Float32List driftPhase;
  final Float32List twinklePhase;
  final Uint8List flags;

  final Float32List transforms;
  final Float32List rects;
  final Int32List colors;
}

class _StardustAtlasPainter({
  required final ui.Image atlas,
  required final _ParticleBuffers buffers,
  required final ValueListenable<double> progressListenable,
  required final Color primaryColor,
  required final Color secondaryColor,
}) extends CustomPainter {
  this : super(repaint: progressListenable);
  final _atlasPaint = Paint()..filterQuality = .low;

  static const double _twoPi = 2 * pi;
  static const double _fourPi = 4 * pi;
  static const double _invEdgeY = 1 / .12;
  static const double _invEdgeX = 1 / .06;
  static const double _spriteHalfSize = 32;
  static const int _whiteRgb = 0xFFFFFF;

  static int _toRgbInt(Color c) {
    final r = (c.r * 255).round() & 0xFF;
    final g = (c.g * 255).round() & 0xFF;
    final b = (c.b * 255).round() & 0xFF;
    return (r << 16) | (g << 8) | b;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final progress = progressListenable.value;
    final width = size.width;
    final height = size.height;
    final count = buffers.count;

    final primaryRgb = _toRgbInt(primaryColor);
    final secondaryRgb = _toRgbInt(secondaryColor);

    final xArr = buffers.x;
    final yArr = buffers.y;
    final scaleArr = buffers.scale;
    final alphaArr = buffers.alpha;
    final speedYArr = buffers.speedY;
    final driftXArr = buffers.driftX;
    final driftPhaseArr = buffers.driftPhase;
    final twinklePhaseArr = buffers.twinklePhase;
    final flagsArr = buffers.flags;
    final transforms = buffers.transforms;
    final colors = buffers.colors;

    for (var i = 0; i < count; i++) {
      final currentY = (yArr[i] - progress * speedYArr[i]) % 1;
      final currentX = (xArr[i] + sin(progress * _twoPi + driftPhaseArr[i]) * driftXArr[i]) % 1;

      final double edgeFade;
      if (currentY < .12) {
        final t = currentY * _invEdgeY;
        edgeFade = t * t * (3 - 2 * t);
      } else if (currentY > .88) {
        final t = (1 - currentY) * _invEdgeY;
        edgeFade = t * t * (3 - 2 * t);
      } else {
        edgeFade = 1;
      }

      final double xFade;
      if (currentX < .06) {
        final t = currentX * _invEdgeX;
        xFade = t * t * (3 - 2 * t);
      } else if (currentX > .94) {
        final t = (1 - currentX) * _invEdgeX;
        xFade = t * t * (3 - 2 * t);
      } else {
        xFade = 1;
      }

      final currentAlpha =
          (alphaArr[i] *
                  (.6 + .4 * sin(progress * _fourPi + twinklePhaseArr[i])) *
                  edgeFade *
                  xFade)
              .clamp(.0, 1);

      final tIdx = i * 4;
      if (currentAlpha <= .001) {
        transforms[tIdx] = .0;
        transforms[tIdx + 1] = .0;
        transforms[tIdx + 2] = .0;
        transforms[tIdx + 3] = .0;
        colors[i] = 0x00000000;
        continue;
      }

      final s = scaleArr[i];
      final px = currentX * width;
      final py = currentY * height;

      transforms[tIdx] = s;
      transforms[tIdx + 1] = .0;
      transforms[tIdx + 2] = px - (_spriteHalfSize * s);
      transforms[tIdx + 3] = py - (_spriteHalfSize * s);

      final alphaByte = (currentAlpha * 255).toInt() & 0xFF;
      final colorType = flagsArr[i] & 3;
      final rgb = switch (colorType) {
        2 => _whiteRgb,
        1 => secondaryRgb,
        _ => primaryRgb,
      };
      colors[i] = (alphaByte << 24) | rgb;
    }

    canvas.drawRawAtlas(atlas, transforms, buffers.rects, colors, .modulate, null, _atlasPaint);
  }

  @override
  bool shouldRepaint(covariant _StardustAtlasPainter oldDelegate) =>
      oldDelegate.atlas != atlas ||
      oldDelegate.buffers != buffers ||
      oldDelegate.primaryColor != primaryColor ||
      oldDelegate.secondaryColor != secondaryColor;
}
