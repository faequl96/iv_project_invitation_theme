import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';

class AnimatedInviter extends StatefulWidget {
  const AnimatedInviter.left({super.key, required this.children}) : isLeft = true;
  const AnimatedInviter.right({super.key, required this.children}) : isLeft = false;

  final bool isLeft;
  final List<Widget> children;

  @override
  State<AnimatedInviter> createState() => _AnimatedInviterState();
}

class _AnimatedInviterState extends State<AnimatedInviter> with SingleTickerProviderStateMixin {
  late final StreamSubscription _sub;

  late final AnimationController _controller;
  late final Animation<double> _lineFadeAnimation;
  late final Animation<Offset> _textSlideHorizontalAnimation;

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
    _controller = AnimationController(duration: const Duration(milliseconds: 2500), vsync: this);

    _lineFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(.7, .86, curve: Curves.easeIn),
      ),
    );
    _textSlideHorizontalAnimation = Tween<Offset>(begin: Offset(widget.isLeft ? 1 : -1, 0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(.9, 1, curve: Curves.easeIn),
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
      position: AlwaysStoppedAnimation<Offset>(Offset(0, widget.isLeft ? -.75 : .75)),
      child: FadeTransition(
        opacity: _lineFadeAnimation,
        child: SizedBox(
          height: (W.x8l * 2) - (W.x3s * 1.4),
          child: Row(
            children: [
              if (!widget.isLeft) ...[
                SizedBox(width: W.x11l - 6),
                SizedBox(
                  height: (W.x8l * 2) - (W.x3s * 1.4),
                  width: .5,
                  child: ColoredBox(color: Colors.grey.shade200),
                ),
              ],
              Expanded(
                child: ClipRect(
                  child: SlideTransition(
                    position: _textSlideHorizontalAnimation,
                    child: SizedBox(
                      width: .maxFinite,
                      child: Padding(
                        padding: .only(left: widget.isLeft ? W.x5s : W.x8s, right: widget.isLeft ? W.x8s : W.x5s),
                        child: Column(
                          mainAxisAlignment: .center,
                          crossAxisAlignment: widget.isLeft ? .start : .end,
                          children: widget.children,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (widget.isLeft) ...[
                SizedBox(
                  height: (W.x8l * 2) - (W.x3s * 1.4),
                  width: .5,
                  child: ColoredBox(color: Colors.grey.shade200),
                ),
                SizedBox(width: W.x11l - 6),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
