import 'dart:async';

import 'package:flutter/material.dart';

class const DoubleArrowSlider({
  super.key,
  final Axis axis = .vertical,
  required final Color firstArrowColor,
  required final Color secondArrowColor,
  final double arrowSize = 44,
  final double sliderPathLength = 60,
  final Duration animationSpeed = const Duration(milliseconds: 500),
  final Duration animationInterval = const Duration(milliseconds: 500),
  final double? staticValue,
}) extends StatefulWidget {
  @override
  State<DoubleArrowSlider> createState() => _DoubleArrowSliderState();
}

class _DoubleArrowSliderState()
    extends State<DoubleArrowSlider>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  void _startAnimationLoop() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    while (mounted) {
      await _controller.forward(from: 0);
      await Future<void>.delayed(widget.animationInterval);
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
    if (widget.staticValue != null) {
      _controller.value = widget.staticValue!;
    } else {
      _startAnimationLoop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (_, child) {
          final slide = _controller.value * (widget.sliderPathLength) - (widget.arrowSize - 2);

          return Stack(
            alignment: .center,
            children: [
              SizedBox(
                width: widget.axis == .vertical ? widget.arrowSize : widget.sliderPathLength,
                height: widget.axis == .vertical ? widget.sliderPathLength : widget.arrowSize,
              ),
              Positioned(
                bottom: widget.axis == .vertical ? slide : null,
                right: widget.axis == .vertical ? null : slide,
                height: widget.arrowSize,
                width: widget.arrowSize,
                child: child ?? const SizedBox.shrink(),
              ),
            ],
          );
        },
        child: Stack(
          clipBehavior: .none,
          children: [
            Positioned(
              top: widget.axis == .vertical ? -(widget.arrowSize / 8) : null,
              left: widget.axis == .vertical ? null : -(widget.arrowSize / 8),
              child: Icon(
                widget.axis == .vertical
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_left_rounded,
                size: widget.arrowSize,
                color: widget.firstArrowColor,
              ),
            ),
            Positioned(
              bottom: widget.axis == .vertical ? -(widget.arrowSize / 8) : null,
              right: widget.axis == .vertical ? null : -(widget.arrowSize / 8),
              child: Icon(
                widget.axis == .vertical
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_left_rounded,
                size: widget.arrowSize,
                color: widget.secondArrowColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
