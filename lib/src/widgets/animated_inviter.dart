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
  late final AnimationController _controller;
  late final Animation<double> _lineFadeAnimation;
  late final Animation<Offset> _textSlideHorizontalAnimation;

  void _runAnimation(int animationTrigger) {
    if (animationTrigger == 1) _controller.forward();
    if (animationTrigger == 0) _controller.reverse();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: const Duration(milliseconds: 3500), vsync: this);

    _lineFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(.75, .85, curve: Curves.easeIn),
      ),
    );
    _textSlideHorizontalAnimation = Tween<Offset>(begin: Offset(widget.isLeft ? 1 : -1, 0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(.85, 1, curve: Curves.easeIn),
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
    return SlideTransition(
      position: AlwaysStoppedAnimation<Offset>(Offset(0, widget.isLeft ? -.9 : .9)),
      child: BlocSelector<CoreCubit, CoreState, Size>(
        selector: (state) => state.size,
        builder: (_, _) => BlocSelector<CoreCubit, CoreState, int>(
          selector: (state) => state.animationTrigger,
          builder: (_, animationTrigger) {
            _runAnimation(animationTrigger);
            return FadeTransition(
              opacity: _lineFadeAnimation,
              child: SizedBox(
                height: SizeScale.widthX9l * 1.3,
                child: Row(
                  children: [
                    if (!widget.isLeft) ...[
                      SizedBox(width: SizeScale.widthX11l + 8),
                      SizedBox(
                        height: SizeScale.widthX9l * 1.3,
                        width: 1,
                        child: ColoredBox(color: Colors.grey.shade800),
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
                                left: widget.isLeft ? SizeScale.widthX4s : SizeScale.widthX8s,
                                right: widget.isLeft ? SizeScale.widthX8s : SizeScale.widthX4s,
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
                        height: SizeScale.widthX9l * 1.3,
                        width: 1,
                        child: ColoredBox(color: Colors.grey.shade800),
                      ),
                      SizedBox(width: SizeScale.widthX11l + 8),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
