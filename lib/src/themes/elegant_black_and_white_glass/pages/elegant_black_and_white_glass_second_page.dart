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

class ElegantBlackAndWhiteGlassSecondPage extends StatelessWidget {
  const ElegantBlackAndWhiteGlassSecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CoreCubit, CoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => Stack(
        children: [
          // Positioned(
          //   bottom: 0,
          //   child: SizedBox(
          //     height: ScreenUtil.size.height / 1.4,
          //     width: ScreenUtil.size.width,
          //     child: DecoratedBox(
          //       decoration: BoxDecoration(
          //         gradient: LinearGradient(
          //           begin: Alignment.topCenter,
          //           end: Alignment.bottomCenter,
          //           colors: [Colors.transparent, Colors.grey.shade900],
          //           stops: const [.2, .8],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Positioned(
            top: 0,
            child: FadeAndSlideTransition(
              slideFromOffset: .5,
              slideFrom: SlideFrom.top,
              delayBeforeStart: Duration.zero,
              animationSpeed: const Duration(milliseconds: 300),
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
            child: SizedBox(
              height: ScreenUtil.size.height,
              width: ScreenUtil.size.width,
              child: Padding(
                padding: EdgeInsets.only(
                  top: SizeScale.heightX6l,
                  left: SizeScale.widthX6s,
                  right: SizeScale.widthX6s,
                  bottom: 76,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: ScreenUtil.size.height,
              width: ScreenUtil.size.width,
              child: Padding(
                padding: EdgeInsets.only(
                  top: SizeScale.heightX6l,
                  left: SizeScale.widthX6s,
                  right: SizeScale.widthX6s,
                  bottom: 76,
                ),
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
                              'Rahma Nur Istiqomah, M.Biomed',
                              style: AppFonts.pacifico(fontSize: FontScale.x2l, height: 1.25),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: .5,
                              width: SizeScale.widthX16l,
                              child: ColoredBox(color: Colors.grey.shade600),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Putri dari',
                              style: AppFonts.inter(fontSize: FontScale.xs + .5, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 2),
                            Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(text: 'Bapak '),
                                  TextSpan(
                                    text: 'Bagyo Trisno Ngulandoro, S.T',
                                    style: AppFonts.inter(fontWeight: FontWeight.w700, fontStyle: FontStyle.italic),
                                  ),
                                ],
                              ),
                              style: AppFonts.inter(fontSize: FontScale.xs + .5, fontStyle: FontStyle.italic, height: 1.2),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'dan',
                              style: AppFonts.inter(fontSize: FontScale.xs + .5, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 2),
                            Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(text: 'Ibu '),
                                  TextSpan(
                                    text: 'Peni Lestari, S.E',
                                    style: AppFonts.inter(fontWeight: FontWeight.w700, fontStyle: FontStyle.italic),
                                  ),
                                ],
                              ),
                              style: AppFonts.inter(fontSize: FontScale.xs + .5, fontStyle: FontStyle.italic, height: 1.2),
                            ),
                          ],
                        ),
                        AnimatedInviter.right(
                          children: [
                            Text(
                              'Faiq Ulul Fahmi, S.Pd',
                              style: AppFonts.pacifico(fontSize: FontScale.x2l, height: 1.25),
                              textAlign: TextAlign.end,
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: .5,
                              width: SizeScale.widthX16l,
                              child: ColoredBox(color: Colors.grey.shade600),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Putra dari',
                              style: AppFonts.inter(fontSize: FontScale.xs + .5, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 2),
                            Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(text: 'Bapak '),
                                  TextSpan(
                                    text: 'Syamsuddin, S.Pd',
                                    style: AppFonts.inter(fontWeight: FontWeight.w700, fontStyle: FontStyle.italic),
                                  ),
                                ],
                              ),
                              style: AppFonts.inter(fontSize: FontScale.xs + .5, fontStyle: FontStyle.italic, height: 1.2),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'dan',
                              style: AppFonts.inter(fontSize: FontScale.xs + .5, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 2),
                            Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(text: 'Ibu '),
                                  TextSpan(
                                    text: 'Sa\'idah',
                                    style: AppFonts.inter(fontWeight: FontWeight.w700, fontStyle: FontStyle.italic),
                                  ),
                                ],
                              ),
                              style: AppFonts.inter(fontSize: FontScale.xs + .5, fontStyle: FontStyle.italic, height: 1.2),
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
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: ScreenUtil.size.height,
              width: ScreenUtil.size.width,
              child: Padding(
                padding: EdgeInsets.only(
                  top: SizeScale.heightX6l,
                  left: SizeScale.widthX6s,
                  right: SizeScale.widthX6s,
                  bottom: 76,
                ),
                child: BlocSelector<CoreCubit, CoreState, int>(
                  selector: (state) => state.animationTrigger,
                  builder: (_, animationTrigger) {
                    if (animationTrigger == 0) return const SizedBox.shrink();
                    return GlassEffectBox(
                      width: ScreenUtil.size.width - 32,
                      height: ScreenUtil.size.height - (76 + SizeScale.heightX6l),
                      borderRadius: 20,
                      sliderWidth: 90,
                      color: Colors.white.withValues(alpha: .5),
                      animationEnd: 1.14,
                      animationSpeed: const Duration(milliseconds: 600),
                      animationInterval: const Duration(seconds: 3),
                    );
                  },
                ),
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
  late final AnimationController _controller;
  late final Animation<double> _lineFadeAnimation;

  bool _isInitial = true;

  void _runAnimation(int animationTrigger) {
    if (animationTrigger == 1) _controller.forward();
    if (animationTrigger == 0) _controller.reverse();
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 800));
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
    if (_isInitial) return const SizedBox.shrink();

    return SlideTransition(
      position: AlwaysStoppedAnimation<Offset>(Offset(0, widget.isLeft ? -.75 : .75)),
      child: BlocSelector<CoreCubit, CoreState, Size>(
        selector: (state) => state.size,
        builder: (_, _) => BlocSelector<CoreCubit, CoreState, int>(
          selector: (state) => state.animationTrigger,
          builder: (_, animationTrigger) {
            _runAnimation(animationTrigger);
            return FadeTransition(
              opacity: _lineFadeAnimation,
              child: ScaleTransition(
                scale: const AlwaysStoppedAnimation<double>(1.12),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: .5, color: Colors.grey.shade600),
                      bottom: BorderSide(width: .5, color: Colors.grey.shade600),
                    ),
                  ),
                  child: SizedBox(
                    height: (SizeScale.widthX8l * 2) - (SizeScale.widthX3s * 1.4),
                    width: ScreenUtil.size.width - (SizeScale.widthX6s * 6),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
