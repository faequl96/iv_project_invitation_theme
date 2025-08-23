import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/core/utils/size_scale.dart';

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
    _controller = AnimationController(duration: const Duration(milliseconds: 2200), vsync: this);

    _lineFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(.7, .76, curve: Curves.easeIn),
      ),
    );
    _textSlideHorizontalAnimation = Tween<Offset>(begin: Offset(widget.isLeft ? 1 : -1, 0), end: Offset.zero).animate(
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
      position: AlwaysStoppedAnimation<Offset>(Offset(0, widget.isLeft ? -.75 : .75)),
      child: FadeTransition(
        opacity: _lineFadeAnimation,
        child: SizedBox(
          height: (SizeScale.widthX8l * 2) - (SizeScale.widthX3s * 1.4),
          child: Row(
            children: [
              if (!widget.isLeft) ...[
                SizedBox(width: SizeScale.widthX11l - 6),
                SizedBox(
                  height: (SizeScale.widthX8l * 2) - (SizeScale.widthX3s * 1.4),
                  width: .5,
                  child: ColoredBox(color: Colors.grey.shade700),
                ),
              ],
              Expanded(
                child: ClipRect(
                  child: SlideTransition(
                    position: _textSlideHorizontalAnimation,
                    child: SizedBox(
                      width: double.maxFinite,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: widget.isLeft ? SizeScale.widthX5s : SizeScale.widthX8s,
                          right: widget.isLeft ? SizeScale.widthX8s : SizeScale.widthX5s,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: widget.isLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                          children: widget.children,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (widget.isLeft) ...[
                SizedBox(
                  height: (SizeScale.widthX8l * 2) - (SizeScale.widthX3s * 1.4),
                  width: .5,
                  child: ColoredBox(color: Colors.grey.shade700),
                ),
                SizedBox(width: SizeScale.widthX11l - 6),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
