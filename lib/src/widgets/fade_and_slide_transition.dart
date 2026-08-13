import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';

class const FadeAndSlideTransition({
  super.key,
  final Duration animationSpeed = const Duration(milliseconds: 500),
  final Duration delayBeforeStart = .zero,
  final double fadeBegin = 0,
  final double fadeEnd = 1,
  final SlideFrom slideFrom = .bottom,
  final double slideFromOffset = .5,
  final bool isNoNeedTrigger = false,
  required final Widget child,
}) extends StatefulWidget {
  @override
  State<FadeAndSlideTransition> createState() => _FadeAndSlideTransitionState();
}

class _FadeAndSlideTransitionState()
    extends State<FadeAndSlideTransition>
    with TickerProviderStateMixin {
  late final StreamSubscription _sub;

  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;

  int _animationRequestId = 0;
  void _runAnimation(int animationTrigger) async {
    final currentId = ++_animationRequestId;
    await Future<void>.delayed(widget.delayBeforeStart);
    if (currentId != _animationRequestId) return;
    if (mounted) {
      if (animationTrigger == 1) _controller.forward();
      if (animationTrigger == 0) _controller.reverse();
    }
  }

  void _initAnimation() {
    _controller = AnimationController(vsync: this, duration: widget.animationSpeed);

    final beginOffset = switch (widget.slideFrom) {
      .top => Offset(0, -widget.slideFromOffset),
      .left => Offset(-widget.slideFromOffset, 0),
      .right => Offset(widget.slideFromOffset, 0),
      .bottom => Offset(0, widget.slideFromOffset),
    };

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

    if (widget.isNoNeedTrigger) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _runAnimation(1));
    } else {
      _sub = context.read<InvitationThemeCoreCubit>().stream.listen((state) {
        _runAnimation(state.animationTrigger);
      });
    }
  }

  @override
  void dispose() {
    if (!widget.isNoNeedTrigger) _sub.cancel();
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
