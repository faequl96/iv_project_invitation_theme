import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';

class AnimatedPhotoSequence extends StatefulWidget {
  const AnimatedPhotoSequence.left({
    super.key,
    required this.viewType,
    required this.frameColor,
    required this.borderColor,
    this.borderWidth = .5,
    required this.imageUrl,
    this.image,
    required this.noAnimate,
  }) : isLeft = true;
  const AnimatedPhotoSequence.right({
    super.key,
    required this.viewType,
    required this.frameColor,
    required this.borderColor,
    this.borderWidth = .5,
    required this.imageUrl,
    this.image,
    required this.noAnimate,
  }) : isLeft = false;

  final ViewType viewType;
  final bool isLeft;
  final Color frameColor;
  final Color borderColor;
  final double borderWidth;
  final String? imageUrl;
  final File? image;
  final bool noAnimate;

  @override
  State<AnimatedPhotoSequence> createState() => _AnimatedPhotoSequenceState();
}

class _AnimatedPhotoSequenceState extends State<AnimatedPhotoSequence> with SingleTickerProviderStateMixin {
  StreamSubscription? _sub;

  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;
  late final Animation<Offset> _slideHorizontalAnimation;
  late final Animation<Offset> _slideVerticalAnimation;

  late final Animation<double> _frameScaleAnimation;
  late final Animation<BorderRadius?> _clipRRectAnimation;

  int _animationRequestId = 0;
  void _runAnimation(int animationTrigger) async {
    final currentId = ++_animationRequestId;
    await Future<void>.delayed(const Duration(milliseconds: 300));
    if (currentId != _animationRequestId) return;
    if (mounted) {
      if (animationTrigger == 1) _controller.forward();
      if (animationTrigger == 0) _controller.reverse();
    }
  }

  void _initAnimation() {
    _controller = AnimationController(duration: const Duration(milliseconds: 1600), vsync: this);

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(.0, .1, curve: Curves.ease),
      ),
    );
    _scaleAnimation = Tween<double>(begin: 5, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(.0, .4, curve: Curves.ease),
      ),
    );
    _slideHorizontalAnimation = Tween<Offset>(begin: Offset.zero, end: Offset(widget.isLeft ? -.38 : .38, .0)).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(.44, .68, curve: Curves.easeIn),
      ),
    );
    _slideVerticalAnimation = Tween<Offset>(begin: Offset.zero, end: Offset(.0, widget.isLeft ? .685 : -.685)).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(.74, 1, curve: Curves.easeIn),
      ),
    );
    _frameScaleAnimation = Tween<double>(begin: .95, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(.74, 1, curve: Curves.ease),
      ),
    );
    _clipRRectAnimation =
        BorderRadiusTween(
          begin: widget.isLeft
              ? const .only(topLeft: .circular(3), bottomLeft: .circular(3))
              : const .only(topRight: .circular(3), bottomRight: .circular(3)),
          end: .circular(3),
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(.8, 1, curve: Curves.ease),
          ),
        );
  }

  @override
  void initState() {
    super.initState();

    _initAnimation();

    if (widget.noAnimate) {
      _controller.value = 1;
    } else {
      _sub = context.read<InvitationThemeCoreCubit>().stream.listen((state) {
        _runAnimation(state.animationTrigger);
      });
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideVerticalAnimation,
      child: SlideTransition(
        position: _slideHorizontalAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Row(
              mainAxisSize: .min,
              children: [
                if (!widget.isLeft) SizedBox(height: (W.x8l * 2) - (W.x6s), width: W.x8l),
                Stack(
                  alignment: .center,
                  children: [
                    ScaleTransition(
                      scale: _frameScaleAnimation,
                      child: SizedBox(
                        height: (W.x8l * 2) - (W.x6s),
                        width: W.x8l,
                        child: Padding(
                          padding: const .symmetric(vertical: 24, horizontal: 2),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: widget.frameColor,
                              border: .all(width: widget.borderWidth, color: widget.borderColor),
                              borderRadius: .circular(4),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: (W.x8l * 2) - (W.x6s),
                      width: W.x8l,
                      child: Padding(
                        padding: const .symmetric(vertical: 24),
                        child: AnimatedBuilder(
                          animation: _clipRRectAnimation,
                          builder: (_, _) {
                            Widget? child;
                            if (widget.viewType == ViewType.preview) {
                              if (widget.image != null) child = Image.file(widget.image!, fit: .cover);
                            } else if (widget.viewType == ViewType.example) {
                              if (widget.imageUrl != null) {
                                child = Image.asset(widget.imageUrl!, fit: .cover, package: 'iv_project_invitation_theme');
                              }
                            } else {
                              if (widget.imageUrl != null) {
                                child = Image.network(widget.imageUrl!, fit: .cover);
                              }
                            }
                            return ClipRRect(borderRadius: _clipRRectAnimation.value ?? .zero, child: child);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                if (widget.isLeft) SizedBox(height: (W.x8l * 2) - (W.x6s), width: W.x8l),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
