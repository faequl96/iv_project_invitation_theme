import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';

enum SlideFrom { top, left, right, bottom }

class FadeAndSlideTransition extends StatefulWidget {
  const FadeAndSlideTransition({
    super.key,
    this.animationSpeed = const Duration(milliseconds: 500),
    this.delayBeforeStart = Duration.zero,
    this.fadeBegin = 0,
    this.fadeEnd = 1,
    this.slideFrom = SlideFrom.bottom,
    this.slideFromOffset = .5,
    this.isNoNeedTrigger = false,
    required this.child,
  });

  final Duration animationSpeed;
  final Duration delayBeforeStart;
  final double fadeBegin;
  final double fadeEnd;
  final SlideFrom slideFrom;
  final double slideFromOffset;
  final bool isNoNeedTrigger;
  final Widget child;

  @override
  State<FadeAndSlideTransition> createState() => _FadeAndSlideTransitionState();
}

class _FadeAndSlideTransitionState extends State<FadeAndSlideTransition> with TickerProviderStateMixin {
  late final StreamSubscription _sub;

  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;

  int _animationRequestId = 0;
  void _runAnimation(int animationTrigger) async {
    final currentId = ++_animationRequestId;
    await Future.delayed(widget.delayBeforeStart);
    if (currentId != _animationRequestId) return;
    if (mounted) {
      if (animationTrigger == 1) _controller.forward();
      if (animationTrigger == 0) _controller.reverse();
    }
  }

  void _initAnimation() {
    _controller = AnimationController(vsync: this, duration: widget.animationSpeed);

    late final Offset beginOffset;
    switch (widget.slideFrom) {
      case SlideFrom.top:
        beginOffset = Offset(0, -widget.slideFromOffset);
        break;
      case SlideFrom.left:
        beginOffset = Offset(-widget.slideFromOffset, 0);
        break;
      case SlideFrom.right:
        beginOffset = Offset(widget.slideFromOffset, 0);
        break;
      case SlideFrom.bottom:
        beginOffset = Offset(0, widget.slideFromOffset);
        break;
    }
    _slideAnimation = Tween<Offset>(
      begin: beginOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _fadeAnimation = Tween<double>(
      begin: widget.fadeBegin,
      end: widget.fadeEnd,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  @override
  void initState() {
    super.initState();

    _initAnimation();

    if (widget.isNoNeedTrigger) WidgetsBinding.instance.addPostFrameCallback((_) => _runAnimation(1));

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
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(position: _slideAnimation, child: widget.child),
    );
  }
}
