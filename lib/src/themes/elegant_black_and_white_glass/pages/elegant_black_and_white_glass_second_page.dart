import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/core/app_fonts.dart';
import 'package:iv_project_invitation_theme/src/widgets/animated_inviter.dart';
import 'package:iv_project_invitation_theme/src/widgets/animated_photo_sequence.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_invitation_theme/src/widgets/glass_effect_box.dart';
import 'package:iv_project_model/iv_project_model.dart';

class ElegantBlackAndWhiteGlassSecondPage extends StatelessWidget {
  const ElegantBlackAndWhiteGlassSecondPage({
    super.key,
    required this.previewType,
    this.brideImage,
    this.groomImage,
    required this.bride,
    required this.groom,
  });

  final ThemePreviewType previewType;
  final File? brideImage;
  final File? groomImage;
  final BridegroomResponse bride;
  final BridegroomResponse groom;

  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    return BlocSelector<InvitationThemeCoreCubit, InvitationThemeCoreState, Size>(
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
                      langCode == 'en' ? 'We Invited You' : 'Kami Yang Mengundang',
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
                      AnimatedPhotoSequence.left(previewType: previewType, imageUrl: groom.imageUrl, image: groomImage),
                      AnimatedPhotoSequence.right(previewType: previewType, imageUrl: bride.imageUrl, image: brideImage),
                      AnimatedInviter.left(
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                if ((bride.frontTitle ?? '').isNotEmpty)
                                  TextSpan(
                                    text: '${bride.frontTitle} ',
                                    style: AppFonts.inter(fontWeight: FontWeight.w500),
                                  ),
                                TextSpan(
                                  text: bride.fullName,
                                  style: AppFonts.inter(fontWeight: FontWeight.w700),
                                ),
                                if ((bride.backTitle ?? '').isNotEmpty)
                                  TextSpan(
                                    text: ', ${bride.backTitle}',
                                    style: AppFonts.inter(fontWeight: FontWeight.w500),
                                  ),
                              ],
                            ),
                            style: AppFonts.inter(fontSize: FontScale.x2l, color: Colors.grey.shade200, height: 1.2),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: .5,
                            width: SizeScale.widthX16l,
                            child: ColoredBox(color: Colors.grey.shade200),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            langCode == 'en' ? 'Daughter of' : 'Putri dari',
                            style: AppFonts.inter(
                              fontSize: FontScale.xs + .2,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade200,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: langCode == 'en' ? 'Mr. ' : 'Bp. '),
                                if ((bride.fatherFrontTitle ?? '').isNotEmpty)
                                  TextSpan(
                                    text: '${bride.fatherFrontTitle} ',
                                    style: AppFonts.inter(fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),
                                  ),
                                TextSpan(
                                  text: bride.fatherName,
                                  style: AppFonts.inter(fontWeight: FontWeight.w700, fontStyle: FontStyle.italic),
                                ),
                                if ((bride.fatherBackTitle ?? '').isNotEmpty)
                                  TextSpan(
                                    text: ', ${bride.fatherBackTitle}',
                                    style: AppFonts.inter(fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),
                                  ),
                              ],
                            ),
                            style: AppFonts.inter(
                              fontSize: FontScale.xs + .2,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey.shade200,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            langCode == 'en' ? 'and' : 'dan',
                            style: AppFonts.inter(
                              fontSize: FontScale.xs + .2,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade200,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: langCode == 'en' ? 'Mrs. ' : 'Ibu '),
                                if ((bride.motherFrontTitle ?? '').isNotEmpty)
                                  TextSpan(
                                    text: '${bride.motherFrontTitle} ',
                                    style: AppFonts.inter(fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),
                                  ),
                                TextSpan(
                                  text: bride.motherName,
                                  style: AppFonts.inter(fontWeight: FontWeight.w700, fontStyle: FontStyle.italic),
                                ),
                                if ((bride.motherBackTitle ?? '').isNotEmpty)
                                  TextSpan(
                                    text: ', ${bride.motherBackTitle}',
                                    style: AppFonts.inter(fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),
                                  ),
                              ],
                            ),
                            style: AppFonts.inter(
                              fontSize: FontScale.xs + .2,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey.shade200,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                      AnimatedInviter.right(
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                if ((groom.frontTitle ?? '').isNotEmpty)
                                  TextSpan(
                                    text: '${groom.frontTitle} ',
                                    style: AppFonts.inter(fontWeight: FontWeight.w500),
                                  ),
                                TextSpan(
                                  text: groom.fullName,
                                  style: AppFonts.inter(fontWeight: FontWeight.w700),
                                ),
                                if ((groom.backTitle ?? '').isNotEmpty)
                                  TextSpan(
                                    text: ', ${groom.backTitle}',
                                    style: AppFonts.inter(fontWeight: FontWeight.w500),
                                  ),
                              ],
                            ),
                            style: AppFonts.inter(fontSize: FontScale.x2l, color: Colors.grey.shade200, height: 1.2),
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
                            langCode == 'en' ? 'Son of' : 'Putra dari',
                            style: AppFonts.inter(
                              fontSize: FontScale.xs + .2,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade200,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: langCode == 'en' ? 'Mr. ' : 'Bp. '),
                                if ((groom.fatherFrontTitle ?? '').isNotEmpty)
                                  TextSpan(
                                    text: '${groom.fatherFrontTitle} ',
                                    style: AppFonts.inter(fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),
                                  ),
                                TextSpan(
                                  text: groom.fatherName,
                                  style: AppFonts.inter(fontWeight: FontWeight.w700, fontStyle: FontStyle.italic),
                                ),
                                if ((groom.fatherBackTitle ?? '').isNotEmpty)
                                  TextSpan(
                                    text: ', ${groom.fatherBackTitle}',
                                    style: AppFonts.inter(fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),
                                  ),
                              ],
                            ),
                            style: AppFonts.inter(
                              fontSize: FontScale.xs + .2,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey.shade200,
                              height: 1.2,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            langCode == 'en' ? 'and' : 'dan',
                            style: AppFonts.inter(
                              fontSize: FontScale.xs + .2,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade200,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: langCode == 'en' ? 'Mrs. ' : 'Ibu '),
                                if ((groom.motherFrontTitle ?? '').isNotEmpty)
                                  TextSpan(
                                    text: '${groom.motherFrontTitle} ',
                                    style: AppFonts.inter(fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),
                                  ),
                                TextSpan(
                                  text: groom.motherName,
                                  style: AppFonts.inter(fontWeight: FontWeight.w700, fontStyle: FontStyle.italic),
                                ),
                                if ((groom.motherBackTitle ?? '').isNotEmpty)
                                  TextSpan(
                                    text: ', ${groom.motherBackTitle}',
                                    style: AppFonts.inter(fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),
                                  ),
                              ],
                            ),
                            style: AppFonts.inter(
                              fontSize: FontScale.xs + .2,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey.shade200,
                              height: 1.2,
                            ),
                            textAlign: TextAlign.right,
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
