import 'package:flutter/material.dart';

class GlassEffectBox extends StatefulWidget {
  const GlassEffectBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 6,
    this.animationSpeed = const Duration(milliseconds: 400),
    this.animationInterval = const Duration(milliseconds: 1500),
    this.delayBeforeStart = const Duration(seconds: 1),
    this.animationEnd = 1,
    this.sliderWidth = 60,
    this.sliderTilt = .2,
    required this.color,
  });

  final double width;
  final double height;
  final double borderRadius;
  final Duration animationSpeed;
  final Duration animationInterval;
  final Duration delayBeforeStart;
  final double animationEnd;
  final double sliderWidth;
  final double sliderTilt;
  final Color color;

  @override
  State<GlassEffectBox> createState() => _GlassEffectBoxState();
}

class _GlassEffectBoxState extends State<GlassEffectBox> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  bool _isInitial = true;

  void _startAnimationLoop() async {
    while (mounted) {
      await _controller.forward(from: 0);
      await Future.delayed(widget.animationInterval);
    }
  }

  void _initAnimation() {
    _controller = AnimationController(duration: widget.animationSpeed, vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void initState() {
    super.initState();

    _initAnimation();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(widget.delayBeforeStart);
      if (mounted) setState(() => _isInitial = false);
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
    if (_isInitial) return const SizedBox.shrink();
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, _) {
        final slide = (_controller.value * widget.animationEnd) * (widget.width + widget.sliderWidth) - widget.sliderWidth;

        return ClipRRect(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              SizedBox(width: widget.width, height: widget.height),
              Positioned(
                left: slide,
                child: Transform.rotate(
                  angle: widget.sliderTilt,
                  child: SizedBox(
                    width: widget.sliderWidth,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: widget.height * 10,
                            child: ColoredBox(color: widget.color),
                          ),
                        ),
                        SizedBox(width: widget.sliderWidth * .03),
                        Expanded(
                          flex: 5,
                          child: SizedBox(
                            height: widget.height * 10,
                            child: ColoredBox(color: widget.color),
                          ),
                        ),
                      ],
                    ),
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
