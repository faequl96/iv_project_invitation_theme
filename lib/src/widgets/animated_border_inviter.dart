import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';

class AnimatedBorderInviter extends StatefulWidget {
  const AnimatedBorderInviter.top({super.key, required this.color, this.borderWidth = .5}) : isTop = true;
  const AnimatedBorderInviter.bottom({super.key, required this.color, this.borderWidth = .5}) : isTop = false;

  final bool isTop;
  final Color color;
  final double borderWidth;

  @override
  State<AnimatedBorderInviter> createState() => _AnimatedBorderInviterState();
}

class _AnimatedBorderInviterState extends State<AnimatedBorderInviter> with SingleTickerProviderStateMixin {
  late final StreamSubscription _sub;

  late final AnimationController _controller;
  late final Animation<double> _lineFadeAnimation;

  int _animationRequestId = 0;
  void _runAnimation(int animationTrigger) async {
    final currentId = ++_animationRequestId;
    await Future<void>.delayed(.zero);
    if (currentId != _animationRequestId) return;
    if (mounted) {
      if (animationTrigger == 1) _controller.forward();
      if (animationTrigger == 0) _controller.reverse();
    }
  }

  void _initAnimation() {
    _controller = AnimationController(duration: const Duration(milliseconds: 2200), vsync: this);

    _lineFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(.82, 1, curve: Curves.easeIn),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _initAnimation();

    _sub = context.read<InvitationThemeCoreCubit>().stream.listen((state) {
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
      position: AlwaysStoppedAnimation<Offset>(Offset(0, widget.isTop ? -.75 : .75)),
      child: FadeTransition(
        opacity: _lineFadeAnimation,
        child: ScaleTransition(
          scale: const AlwaysStoppedAnimation<double>(1.12),
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: widget.borderWidth, color: widget.color),
                bottom: BorderSide(width: widget.borderWidth, color: widget.color),
              ),
            ),
            child: SizedBox(height: (W.x8l * 2) - (W.x3s * 1.4), width: Screen.width - (W.x6s * 6)),
          ),
        ),
      ),
    );
  }
}
