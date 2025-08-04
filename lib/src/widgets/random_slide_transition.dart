import 'dart:math';

import 'package:flutter/material.dart';

class RandomSlideTransition extends StatefulWidget {
  const RandomSlideTransition({super.key, this.maxSlideOffset = .5, required this.child});

  final double maxSlideOffset;
  final Widget child;

  @override
  State<RandomSlideTransition> createState() => _RandomSlideTransitionState();
}

class _RandomSlideTransitionState extends State<RandomSlideTransition> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  Offset _startOffset = Offset.zero;
  Offset _targetOffset = Offset.zero;

  final Random _random = Random();

  Offset _randomOffset() {
    return Offset((_random.nextDouble() * 2 - 1) * widget.maxSlideOffset, (_random.nextDouble() * 2 - 1) * widget.maxSlideOffset);
  }

  @override
  void initState() {
    super.initState();

    _startOffset = Offset.zero;
    _targetOffset = _randomOffset();

    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3))
      ..addListener(() {
        setState(() {
          if (_controller.status == AnimationStatus.completed) {
            _startOffset = _targetOffset;
            _targetOffset = _randomOffset();
            _controller.forward(from: 0);
          }
        });
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animatedOffset = Offset.lerp(_startOffset, _targetOffset, _controller.value)!;

    return Stack(
      children: [FractionalTranslation(translation: animatedOffset, child: widget.child)],
    );
  }
}
