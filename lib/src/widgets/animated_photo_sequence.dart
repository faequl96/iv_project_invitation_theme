import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/core/utils/size_scale.dart';

class AnimatedPhotoSequence extends StatefulWidget {
  const AnimatedPhotoSequence.left({super.key}) : isLeft = true;
  const AnimatedPhotoSequence.right({super.key}) : isLeft = false;

  final bool isLeft;

  @override
  State<AnimatedPhotoSequence> createState() => _AnimatedPhotoSequenceState();
}

class _AnimatedPhotoSequenceState extends State<AnimatedPhotoSequence> with SingleTickerProviderStateMixin {
  late final StreamSubscription _sub;

  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;
  late final Animation<Offset> _slideHorizontalAnimation;
  late final Animation<Offset> _slideVerticalAnimation;

  late final Animation<double> _frameScaleAnimation;

  int _animationRequestId = 0;
  void _runAnimation(int animationTrigger) async {
    final currentId = ++_animationRequestId;
    await Future.delayed(Duration.zero);
    if (currentId != _animationRequestId) return;
    if (mounted) {
      if (animationTrigger == 1) _controller.forward();
      if (animationTrigger == 0) _controller.reverse();
    }
  }

  void _initAnimation() {
    _controller = AnimationController(duration: const Duration(milliseconds: 1600), vsync: this);

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(.0, .1, curve: Curves.ease),
      ),
    );
    _scaleAnimation = Tween<double>(begin: 5, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(.0, .3, curve: Curves.ease),
      ),
    );
    _slideHorizontalAnimation = Tween<Offset>(begin: Offset.zero, end: Offset(widget.isLeft ? -.38 : .38, .0)).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(.36, .62, curve: Curves.easeIn),
      ),
    );
    _slideVerticalAnimation = Tween<Offset>(begin: Offset.zero, end: Offset(.0, widget.isLeft ? .75 : -.75)).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(.68, 1, curve: Curves.easeIn),
      ),
    );
    _frameScaleAnimation = Tween<double>(begin: 1, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(.68, 1, curve: Curves.ease),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _initAnimation();

    _sub = context.read<CoreCubit>().stream.listen((state) {
      _runAnimation(state.animationTrigger);
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideVerticalAnimation,
      child: SlideTransition(
        position: _slideHorizontalAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!widget.isLeft)
                  SizedBox(height: (SizeScale.widthX8l * 2) - (SizeScale.widthX3s * 1.4), width: SizeScale.widthX8l),
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    ScaleTransition(
                      scale: _frameScaleAnimation,
                      child: SizedBox(
                        height: (SizeScale.widthX8l * 2) - (SizeScale.widthX3s * 1.4),
                        width: SizeScale.widthX8l,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 2),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50.withValues(alpha: .3),
                              border: Border.all(width: .5, color: Colors.grey.shade200),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: (SizeScale.widthX8l * 2) - (SizeScale.widthX3s * 1.4),
                      width: SizeScale.widthX8l,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: DecoratedBox(decoration: BoxDecoration(color: Colors.grey)),
                      ),
                    ),
                  ],
                ),
                if (widget.isLeft)
                  SizedBox(height: (SizeScale.widthX8l * 2) - (SizeScale.widthX3s * 1.4), width: SizeScale.widthX8l),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
