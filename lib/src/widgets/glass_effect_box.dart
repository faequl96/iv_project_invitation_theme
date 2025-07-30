import 'package:flutter/material.dart';

class GlassEffectBox extends StatefulWidget {
  const GlassEffectBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 6,
    this.enableSlider = true,
    this.animationSpeed = const Duration(milliseconds: 500),
    this.animationInterval = const Duration(milliseconds: 1500),
    this.sliderWidth = 60,
  });

  final double width;
  final double height;
  final double borderRadius;
  final bool enableSlider;
  final Duration animationSpeed;
  final Duration animationInterval;
  final double sliderWidth;

  @override
  State<GlassEffectBox> createState() => _GlassEffectBoxState();
}

class _GlassEffectBoxState extends State<GlassEffectBox> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  void _startAnimationLoop() async {
    while (mounted) {
      await _controller.forward(from: 0);
      await Future.delayed(widget.animationInterval);
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: widget.animationSpeed, vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _startAnimationLoop();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, _) {
        final slide = _controller.value * (widget.width + widget.sliderWidth) - (widget.sliderWidth - 2);

        return ClipRRect(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              SizedBox(width: widget.width, height: widget.height),
              if (widget.enableSlider)
                Positioned(
                  left: slide,
                  child: Transform.rotate(
                    angle: .1,
                    child: SizedBox(
                      width: widget.sliderWidth,
                      height: widget.height * 10,
                      child: ColoredBox(color: Colors.grey.shade200.withValues(alpha: .5)),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
