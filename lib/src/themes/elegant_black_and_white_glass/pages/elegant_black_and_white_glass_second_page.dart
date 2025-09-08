import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/core/app_fonts.dart';
import 'package:iv_project_invitation_theme/src/core/utils/font_scale.dart';
import 'package:iv_project_invitation_theme/src/core/utils/screen_util.dart';
import 'package:iv_project_invitation_theme/src/core/utils/size_scale.dart';
import 'package:iv_project_invitation_theme/src/widgets/animated_inviter.dart';
import 'package:iv_project_invitation_theme/src/widgets/animated_photo_sequence.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_invitation_theme/src/widgets/glass_effect_box.dart';
import 'package:iv_project_model/iv_project_model.dart';

class ElegantBlackAndWhiteGlassSecondPage extends StatelessWidget {
  const ElegantBlackAndWhiteGlassSecondPage({super.key, required this.bride, required this.groom});

  final BridegroomResponse bride;
  final BridegroomResponse groom;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CoreCubit, CoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => Stack(
        children: [
          Positioned(
            top: 0,
            child: FadeAndSlideTransition(
              slideFromOffset: .5,
              slideFrom: SlideFrom.top,
              child: SizedBox(
                height: SizeScale.heightX6l,
                width: ScreenUtil.size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.people, size: SizeScale.widthXs, color: Colors.grey.shade900),
                    const SizedBox(width: 10),
                    Text(
                      'Kami Yang Mengundang',
                      style: AppFonts.inter(color: Colors.grey.shade900, fontSize: FontScale.x3l, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            height: ScreenUtil.size.height,
            width: ScreenUtil.size.width,
            child: Padding(
              padding: EdgeInsets.only(top: SizeScale.heightX6l, left: SizeScale.widthX6s, right: SizeScale.widthX6s, bottom: 76),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      // color: Colors.white.withValues(alpha: .1),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black.withValues(alpha: .6), Colors.black.withValues(alpha: .6)],
                        stops: const [0, 1],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            height: ScreenUtil.size.height,
            width: ScreenUtil.size.width,
            child: Padding(
              padding: EdgeInsets.only(top: SizeScale.heightX6l, left: SizeScale.widthX6s, right: SizeScale.widthX6s, bottom: 76),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: .5, color: Colors.grey.shade500),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      const AnimatedPhotoSequence.left(),
                      const AnimatedPhotoSequence.right(),
                      AnimatedInviter.left(
                        children: [
                          Text(
                            bride.fullName,
                            style: AppFonts.pacifico(fontSize: FontScale.x2l, color: Colors.grey.shade100, height: 1.25),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: .5,
                            width: SizeScale.widthX16l,
                            child: ColoredBox(color: Colors.grey.shade200),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Putri dari',
                            style: AppFonts.inter(
                              fontSize: FontScale.xs + .5,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade200,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(text: 'Bapak '),
                                TextSpan(
                                  text: bride.fatherName,
                                  style: AppFonts.inter(fontWeight: FontWeight.w700, fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                            style: AppFonts.inter(
                              fontSize: FontScale.xs + .5,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey.shade200,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'dan',
                            style: AppFonts.inter(
                              fontSize: FontScale.xs + .5,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade200,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(text: 'Ibu '),
                                TextSpan(
                                  text: bride.motherName,
                                  style: AppFonts.inter(fontWeight: FontWeight.w700, fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                            style: AppFonts.inter(
                              fontSize: FontScale.xs + .5,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey.shade200,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                      AnimatedInviter.right(
                        children: [
                          Text(
                            groom.fullName,
                            style: AppFonts.pacifico(fontSize: FontScale.x2l, color: Colors.grey.shade100, height: 1.25),
                            textAlign: TextAlign.end,
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: .5,
                            width: SizeScale.widthX16l,
                            child: ColoredBox(color: Colors.grey.shade200),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Putra dari',
                            style: AppFonts.inter(
                              fontSize: FontScale.xs + .5,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade200,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(text: 'Bapak '),
                                TextSpan(
                                  text: groom.fatherName,
                                  style: AppFonts.inter(fontWeight: FontWeight.w700, fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                            style: AppFonts.inter(
                              fontSize: FontScale.xs + .5,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey.shade200,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'dan',
                            style: AppFonts.inter(
                              fontSize: FontScale.xs + .5,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade200,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(text: 'Ibu '),
                                TextSpan(
                                  text: groom.motherName,
                                  style: AppFonts.inter(fontWeight: FontWeight.w700, fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                            style: AppFonts.inter(
                              fontSize: FontScale.xs + .5,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey.shade200,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                      const _Border.left(),
                      const _Border.right(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            height: ScreenUtil.size.height,
            width: ScreenUtil.size.width,
            child: Padding(
              padding: EdgeInsets.only(top: SizeScale.heightX6l, left: SizeScale.widthX6s, right: SizeScale.widthX6s, bottom: 76),
              child: GlassEffectBox(
                width: ScreenUtil.size.width - 32,
                height: ScreenUtil.size.height - (76 + SizeScale.heightX6l),
                borderRadius: 20,
                sliderWidth: 90,
                color: Colors.white.withValues(alpha: .5),
                animationSpeed: const Duration(milliseconds: 600),
                delayBeforeStart: const Duration(milliseconds: 3500),
                animationInterval: const Duration(seconds: 4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Border extends StatefulWidget {
  const _Border.left() : isLeft = true;
  const _Border.right() : isLeft = false;

  final bool isLeft;

  @override
  State<_Border> createState() => _BorderState();
}

class _BorderState extends State<_Border> with SingleTickerProviderStateMixin {
  late final StreamSubscription _sub;

  late final AnimationController _controller;
  late final Animation<double> _lineFadeAnimation;

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
        child: ScaleTransition(
          scale: const AlwaysStoppedAnimation<double>(1.12),
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: .5, color: Colors.grey.shade200),
                bottom: BorderSide(width: .5, color: Colors.grey.shade200),
              ),
            ),
            child: SizedBox(
              height: (SizeScale.widthX8l * 2) - (SizeScale.widthX3s * 1.4),
              width: ScreenUtil.size.width - (SizeScale.widthX6s * 6),
            ),
          ),
        ),
      ),
    );
  }
}
