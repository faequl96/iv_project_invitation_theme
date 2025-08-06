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
    required this.child,
  });

  final Duration animationSpeed;
  final Duration delayBeforeStart;
  final double fadeBegin;
  final double fadeEnd;
  final SlideFrom slideFrom;
  final double slideFromOffset;
  final Widget child;

  @override
  State<FadeAndSlideTransition> createState() => _FadeAndSlideTransitionState();
}

class _FadeAndSlideTransitionState extends State<FadeAndSlideTransition> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;

  bool _isInitial = true;

  void _runAnimation(int animationTrigger) async {
    if (animationTrigger == 1) _controller.forward();
    if (animationTrigger == 0) _controller.reverse();
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

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  @override
  void initState() {
    super.initState();

    _initAnimation();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(widget.delayBeforeStart);
      if (mounted) setState(() => _isInitial = false);
    });
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isInitial) return Opacity(opacity: 0, child: widget.child);
    return BlocSelector<CoreCubit, CoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => BlocSelector<CoreCubit, CoreState, int>(
        selector: (state) => state.animationTrigger,
        builder: (_, animationTrigger) {
          _runAnimation(animationTrigger);
          return FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(position: _slideAnimation, child: widget.child),
          );
        },
      ),
    );
  }
}
