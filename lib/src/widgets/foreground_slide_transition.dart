import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';

class ForegroundSlideTransition extends StatefulWidget {
  const ForegroundSlideTransition({
    super.key,
    required this.animationSpeed,
    required this.delayedBeforeStart,
    required this.slideFrom,
    this.isNoNeedTrigger = false,
    required this.child,
  });

  final Duration animationSpeed;
  final Duration delayedBeforeStart;
  final GroundSlideFrom slideFrom;
  final bool isNoNeedTrigger;
  final Widget child;

  @override
  State<ForegroundSlideTransition> createState() => _ForegroundSlideTransitionState();
}

class _ForegroundSlideTransitionState extends State<ForegroundSlideTransition> with TickerProviderStateMixin {
  late final StreamSubscription _sub;

  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;

  int _animationRequestId = 0;
  void _runAnimation(int animationTrigger) async {
    final currentId = ++_animationRequestId;
    await Future<void>.delayed(widget.delayedBeforeStart);
    if (currentId != _animationRequestId) return;
    if (mounted) {
      if (animationTrigger == 1) _controller.forward();
      if (animationTrigger == 0) _controller.reverse();
    }
  }

  void _initAnimation() {
    final beginOffset = widget.slideFrom == .left ? const Offset(-1, 0) : const Offset(1, 0);
    final endOffset = widget.slideFrom == .left ? const Offset(.08, 0) : const Offset(-.08, 0);

    _slideAnimation = Tween<Offset>(begin: beginOffset, end: endOffset).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(.0, .46, curve: Curves.easeIn),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(.46, .46, curve: Threshold(.0)),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.animationSpeed);

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
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(opacity: _fadeAnimation, child: widget.child),
    );
  }
}
