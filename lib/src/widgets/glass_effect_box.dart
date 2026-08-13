import 'dart:async';

import 'package:flutter/material.dart';

class const GlassEffectBox({
  super.key,
  required final double width,
  required final double height,
  final double borderRadius = 6,
  final Duration animationSpeed = const Duration(milliseconds: 400),
  final Duration animationInterval = const Duration(milliseconds: 1500),
  final Duration delayBeforeStart = const Duration(seconds: 1),
  final double sliderWidth = 60,
  final double sliderTilt = .2,
  required final Color color,
  final double? staticValue,
}) extends StatefulWidget {
  @override
  State<GlassEffectBox> createState() => _GlassEffectBoxState();
}

class _GlassEffectBoxState() extends State<GlassEffectBox> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  void _startAnimationLoop() async {
    await Future<void>.delayed(widget.delayBeforeStart);
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
          final slide =
              (_controller.value * 1.3) * (widget.width + widget.sliderWidth) -
              widget.sliderWidth * 1.8;

          return ClipRRect(
            borderRadius: .circular(widget.borderRadius),
            child: Stack(
              alignment: .center,
              children: [
                SizedBox(width: widget.width, height: widget.height),
                Positioned(left: slide, child: child ?? const SizedBox.shrink()),
              ],
            ),
          );
        },
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
    );
  }
}
