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
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;
  late final Animation<Offset> _slideHorizontalAnimation;
  late final Animation<Offset> _slideVerticalAnimation;

  late final Animation<double> _frameScaleAnimation;

  void _runAnimation(int animationTrigger) {
    if (animationTrigger == 1) _controller.forward();
    if (animationTrigger == 0) _controller.reverse();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: const Duration(milliseconds: 2500), vsync: this);

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(.0, .1, curve: Curves.ease),
      ),
    );
    _scaleAnimation = Tween<double>(begin: 5, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(.0, .2, curve: Curves.ease),
      ),
    );
    _slideHorizontalAnimation = Tween<Offset>(begin: Offset.zero, end: Offset(widget.isLeft ? -.28 : .28, .0)).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(.3, .55, curve: Curves.easeIn),
      ),
    );
    _slideVerticalAnimation = Tween<Offset>(begin: Offset.zero, end: Offset(.0, widget.isLeft ? .9 : -.9)).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(.65, 1, curve: Curves.easeIn),
      ),
    );
    _frameScaleAnimation = Tween<double>(begin: 1, end: 1.15).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(.65, 1, curve: Curves.ease),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CoreCubit, CoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => BlocSelector<CoreCubit, CoreState, int>(
        selector: (state) => state.animationTrigger,
        builder: (_, animationTrigger) {
          _runAnimation(animationTrigger);
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
                      if (widget.isLeft)
                        Stack(
                          children: [
                            ScaleTransition(
                              scale: _frameScaleAnimation,
                              child: SizedBox(
                                height: SizeScale.widthX9l * 1.3,
                                width: SizeScale.widthX9l,
                                child: ColoredBox(color: Colors.grey.shade500.withValues(alpha: .5)),
                              ),
                            ),
                            SizedBox(
                              height: SizeScale.widthX9l * 1.3,
                              width: SizeScale.widthX9l,
                              child: const ColoredBox(color: Colors.grey),
                            ),
                          ],
                        ),
                      SizedBox(height: SizeScale.widthX9l * 1.3, width: SizeScale.widthX9l),
                      if (!widget.isLeft)
                        Stack(
                          children: [
                            ScaleTransition(
                              scale: _frameScaleAnimation,
                              child: SizedBox(
                                height: SizeScale.widthX9l * 1.3,
                                width: SizeScale.widthX9l,
                                child: ColoredBox(color: Colors.grey.shade500.withValues(alpha: .5)),
                              ),
                            ),
                            SizedBox(
                              height: SizeScale.widthX9l * 1.3,
                              width: SizeScale.widthX9l,
                              child: const ColoredBox(color: Colors.grey),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
