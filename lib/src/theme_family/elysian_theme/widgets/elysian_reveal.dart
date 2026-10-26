import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_invitation_theme/src/core/cubit/invitation_theme_core_cubit.dart';

class const ElysianReveal({
  super.key,
  required final Widget child,
  final Duration delay = Duration.zero,
  final Duration duration = const Duration(milliseconds: 700),
  final Offset slideOffset = const Offset(0, 0.12),
  final double initialScale = 0.95,
  final Curve curve = Curves.easeOutCubic,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<InvitationThemeCoreCubit, InvitationThemeCoreState, int>(
      selector: (state) => state.animationTrigger,
      builder: (context, trigger) => _ElysianRevealAnimator(
        trigger: trigger,
        delay: delay,
        duration: duration,
        slideOffset: slideOffset,
        initialScale: initialScale,
        curve: curve,
        child: child,
      ),
    );
  }
}

class const _ElysianRevealAnimator({
  required final int trigger,
  required final Duration delay,
  required final Duration duration,
  required final Offset slideOffset,
  required final double initialScale,
  required final Curve curve,
  required final Widget child,
}) extends StatefulWidget {
  @override
  State<_ElysianRevealAnimator> createState() => _ElysianRevealAnimatorState();
}

class _ElysianRevealAnimatorState()
    extends State<_ElysianRevealAnimator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    final curved = CurvedAnimation(parent: _controller, curve: widget.curve);
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(curved);
    _slideAnimation = Tween<Offset>(begin: widget.slideOffset, end: Offset.zero).animate(curved);
    _scaleAnimation = Tween<double>(begin: widget.initialScale, end: 1.0).animate(curved);

    if (widget.trigger == 1) {
      _startAnimation();
    }
  }

  @override
  void didUpdateWidget(covariant _ElysianRevealAnimator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.trigger != oldWidget.trigger) {
      if (widget.trigger == 1) {
        _startAnimation();
      } else {
        _controller.reset();
      }
    }
  }

  void _startAnimation() {
    if (widget.delay == Duration.zero) {
      _controller.forward(from: 0);
    } else {
      Future<void>.delayed(widget.delay, () {
        if (mounted && widget.trigger == 1) {
          _controller.forward(from: 0);
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) => Opacity(
        opacity: _fadeAnimation.value,
        child: FractionalTranslation(
          translation: _slideAnimation.value,
          child: Transform.scale(scale: _scaleAnimation.value, child: child),
        ),
      ),
      child: widget.child,
    );
  }
}
