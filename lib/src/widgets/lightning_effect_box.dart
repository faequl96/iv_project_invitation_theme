import 'package:flutter/material.dart';

class LightningEffectBox extends StatefulWidget {
  const LightningEffectBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 6,
    this.animationSpeed = const Duration(milliseconds: 500),
    this.animationInterval = const Duration(milliseconds: 2000),
    this.delayBeforeShowed = .zero,
    this.ligthningLength = .2,
    this.ligthningWidth = .5,
    this.ligthningColor = Colors.white,
    this.isFlash = false,
  });

  final double width;
  final double height;
  final double borderRadius;
  final Duration animationSpeed;
  final Duration animationInterval;
  final Duration delayBeforeShowed;
  final double ligthningLength;
  final double ligthningWidth;
  final Color ligthningColor;
  final bool isFlash;

  @override
  State<LightningEffectBox> createState() => _LightningEffectBoxState();
}

class _LightningEffectBoxState extends State<LightningEffectBox> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  bool _showed = false;

  void _startAnimationLoop() async {
    while (mounted) {
      await _controller.forward(from: 0);
      await Future<void>.delayed(widget.animationInterval);
    }
  }

  void _initAnimation() {
    _controller = AnimationController(duration: widget.animationSpeed, vsync: this);
    _animation = Tween<double>(begin: 0, end: widget.isFlash ? 1 : 1.3).animate(_controller);
  }

  @override
  void initState() {
    super.initState();

    _initAnimation();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future<void>.delayed(widget.delayBeforeShowed);
      setState(() => _showed = true);

      await Future<void>.delayed(.zero);
      _startAnimationLoop();
    });
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_showed) return const SizedBox.shrink();

    return Padding(
      padding: const .all(.5),
      child: CustomPaint(
        painter: widget.isFlash
            ? _LightningFlashPainter(
                animation: _animation,
                borderRadius: widget.borderRadius,
                ligthningLength: widget.ligthningLength,
                ligthningWidth: widget.ligthningWidth,
                ligthningColor: widget.ligthningColor,
              )
            : _LightningPainter(
                animation: _animation,
                borderRadius: widget.borderRadius,
                ligthningLength: widget.ligthningLength,
                ligthningWidth: widget.ligthningWidth,
                ligthningColor: widget.ligthningColor,
              ),
        child: SizedBox(width: widget.width - 1, height: widget.height - 1),
      ),
    );
  }
}

class _LightningPainter extends CustomPainter {
  _LightningPainter({
    required this.animation,
    required this.borderRadius,
    required this.ligthningLength,
    required this.ligthningWidth,
    required this.ligthningColor,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final double borderRadius;
  final double ligthningLength;
  final double ligthningWidth;
  final Color ligthningColor;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(rect, .circular(borderRadius));

    final path = Path()..addRRect(rrect);
    final pathMetrics = path.computeMetrics().toList();
    final metric = pathMetrics.first;

    final totalLength = metric.length;
    final headOffset = totalLength * animation.value; // posisi kepala
    final lightningLength = totalLength * ligthningLength;
    final tailOffset = (headOffset - lightningLength).clamp(.0, totalLength);

    final lightningPath = metric.extractPath(tailOffset, headOffset);

    final paint = Paint()
      ..color = ligthningColor
      ..style = .stroke
      ..strokeWidth = ligthningWidth;

    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.transparent
        ..style = .stroke
        ..strokeWidth = ligthningWidth,
    );

    canvas.drawPath(lightningPath, paint);
  }

  @override
  bool shouldRepaint(covariant _LightningPainter oldDelegate) => true;
}

class _LightningFlashPainter extends CustomPainter {
  _LightningFlashPainter({
    required this.animation,
    required this.borderRadius,
    required this.ligthningLength,
    required this.ligthningWidth,
    required this.ligthningColor,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final double borderRadius;
  final double ligthningLength;
  final double ligthningWidth;
  final Color ligthningColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (animation.value >= .78) return;

    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(rect, .circular(borderRadius));

    final path = Path()..addRRect(rrect);
    final pathMetrics = path.computeMetrics().toList();
    final metric = pathMetrics.first;

    final length = metric.length;
    final progress = animation.value;

    final lightningLength = length * ligthningLength;

    final extractPath = metric.extractPath(length * progress, length * progress + lightningLength);

    final paint = Paint()
      ..color = ligthningColor
      ..style = .stroke
      ..strokeWidth = ligthningWidth;

    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.transparent
        ..style = .stroke
        ..strokeWidth = ligthningWidth,
    );

    canvas.drawPath(extractPath, paint);
  }

  @override
  bool shouldRepaint(covariant _LightningFlashPainter oldDelegate) => true;
}
