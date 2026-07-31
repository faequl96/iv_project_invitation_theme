import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';

class AutoSizeTransition extends StatefulWidget {
  const AutoSizeTransition({
    super.key,
    this.animationSpeed = const Duration(milliseconds: 500),
    this.delayBeforeStart = .zero,
    this.slideFrom = .left,
    this.isNoNeedTrigger = false,
    required this.child,
  });

  final Duration animationSpeed;
  final Duration delayBeforeStart;
  final SlideFrom slideFrom;
  final bool isNoNeedTrigger;
  final Widget child;

  @override
  State<AutoSizeTransition> createState() => _AutoSizeTransitionState();
}

class _AutoSizeTransitionState extends State<AutoSizeTransition> with TickerProviderStateMixin {
  late final StreamSubscription _sub;

  late final AnimationController _controller;
  late final Animation<double> _animation;

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
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
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

  AlignmentGeometry get _alignment => switch (widget.slideFrom) {
    .top => .topCenter,
    .bottom => .bottomCenter,
    .left => .centerLeft,
    .right => .centerRight,
  };

  @override
  Widget build(BuildContext context) {
    final slideFrom = widget.slideFrom;
    return Align(
      alignment: .bottomCenter,
      child: SizeTransition(
        axis: slideFrom == .top || slideFrom == .bottom ? .vertical : .horizontal,
        sizeFactor: _animation,
        alignment: _alignment,
        child: widget.child,
      ),
    );
  }
}
