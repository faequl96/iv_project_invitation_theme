import 'package:flutter/material.dart';

class DoubleArrowSlider extends StatefulWidget {
  const DoubleArrowSlider({
    super.key,
    this.arrowSize = 44,
    this.sliderPathLength = 60,
    this.animationSpeed = const Duration(milliseconds: 500),
    this.animationInterval = const Duration(milliseconds: 500),
  });

  final double arrowSize;
  final double sliderPathLength;
  final Duration animationSpeed;
  final Duration animationInterval;

  @override
  State<DoubleArrowSlider> createState() => _DoubleArrowSliderState();
}

class _DoubleArrowSliderState extends State<DoubleArrowSlider> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  void _startAnimationLoop() async {
    await Future.delayed(const Duration(seconds: 1));
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
        final slide = _controller.value * (widget.sliderPathLength) - (widget.arrowSize - 2);

        return Stack(
          alignment: AlignmentDirectional.center,
          children: [
            SizedBox(width: widget.arrowSize, height: widget.sliderPathLength),
            Positioned(
              bottom: slide,
              height: widget.arrowSize,
              width: widget.arrowSize,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -(widget.arrowSize / 8),
                    child: Icon(
                      Icons.keyboard_arrow_up_rounded,
                      size: widget.arrowSize,
                      color: Colors.grey.shade100.withValues(alpha: .8),
                    ),
                  ),
                  Positioned(
                    bottom: -(widget.arrowSize / 8),
                    child: Icon(
                      Icons.keyboard_arrow_up_rounded,
                      size: widget.arrowSize,
                      color: Colors.grey.shade300.withValues(alpha: .5),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
