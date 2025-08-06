import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/core/utils/size_scale.dart';

class AnimatedPhotoSequence extends StatefulWidget {
  const AnimatedPhotoSequence.left({super.key, this.delayBeforeStart = const Duration(milliseconds: 1200)}) : isLeft = true;
  const AnimatedPhotoSequence.right({super.key, this.delayBeforeStart = const Duration(milliseconds: 1200)}) : isLeft = false;

  final bool isLeft;
  final Duration delayBeforeStart;

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

  bool _isInitial = true;

  void _runAnimation(int animationTrigger) {
    if (animationTrigger == 1) _controller.forward();
    if (animationTrigger == 0) _controller.reverse();
  }

  void _initAnimation() {
    _controller = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(.0, .1, curve: Curves.ease),
      ),
    );
    _scaleAnimation = Tween<double>(begin: 5, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(.0, .25, curve: Curves.ease),
      ),
    );
    _slideHorizontalAnimation = Tween<Offset>(begin: Offset.zero, end: Offset(widget.isLeft ? -.38 : .38, .0)).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(.32, .58, curve: Curves.easeIn),
      ),
    );
    _slideVerticalAnimation = Tween<Offset>(begin: Offset.zero, end: Offset(.0, widget.isLeft ? .75 : -.75)).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(.68, 1, curve: Curves.easeIn),
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
    if (_isInitial) return const Opacity(opacity: 0, child: SizedBox.shrink());
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
                      if (!widget.isLeft)
                        SizedBox(height: (SizeScale.widthX8l * 2) - (SizeScale.widthX3s * 1.4), width: SizeScale.widthX8l),
                      Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          ScaleTransition(
                            scale: _frameScaleAnimation,
                            child: SizedBox(
                              height: (SizeScale.widthX8l * 2) - (SizeScale.widthX3s * 1.4),
                              width: SizeScale.widthX8l,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 24),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade50.withValues(alpha: .3),
                                    border: Border.all(width: .5, color: Colors.grey.shade500),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: (SizeScale.widthX8l * 2) - (SizeScale.widthX3s * 1.4),
                            width: SizeScale.widthX8l,
                            child: const ColoredBox(
                              color: Colors.transparent,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 24),
                                child: ColoredBox(color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (widget.isLeft)
                        SizedBox(height: (SizeScale.widthX8l * 2) - (SizeScale.widthX3s * 1.4), width: SizeScale.widthX8l),
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
