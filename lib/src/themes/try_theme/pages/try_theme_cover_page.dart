import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/core/utils/font_scale.dart';
import 'package:iv_project_invitation_theme/src/core/utils/screen_util.dart';
import 'package:iv_project_invitation_theme/src/core/utils/shape_scale.dart';
import 'package:iv_project_invitation_theme/src/widgets/countdown_timers.dart';
import 'package:iv_project_invitation_theme/src/widgets/double_arrow_slider.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class TryThemeCoverPage extends StatelessWidget {
  const TryThemeCoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TryThemeCubit, TryThemeState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => Stack(
        children: [
          Image.asset(
            'assets/dummys/try_theme_cover_image.png',
            package: 'iv_project_invitation_theme',
            height: ScreenUtil.size.height / 1.2,
            width: ScreenUtil.size.width,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: ScreenUtil.size.height / 1.2,
              width: ScreenUtil.size.width,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.grey.shade700],
                    stops: const [.2, .8],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, .3),
            child: SizedBox(
              width: ScreenUtil.size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocSelector<TryThemeCubit, TryThemeState, int>(
                      selector: (state) => state.countdownsTimerAnimationTrigger,
                      builder: (_, countdownsTimerAnimationTrigger) {
                        return AnimatedOpacity(
                          opacity: countdownsTimerAnimationTrigger.toDouble(),
                          duration: const Duration(milliseconds: 200),
                          child: Text(
                            'Pernikahan Dari',
                            style: TextStyle(
                              fontSize: FontScale.lg,
                              fontWeight: FontWeight.w900,
                              color: ColorConverter.darken(Colors.grey.shade300, 7),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    const _BrideName(),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, .65),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocSelector<TryThemeCubit, TryThemeState, int>(
                  selector: (state) => state.countdownsTimerAnimationTrigger,
                  builder: (_, countdownsTimerAnimationTrigger) {
                    return AnimatedOpacity(
                      opacity: countdownsTimerAnimationTrigger.toDouble(),
                      duration: const Duration(milliseconds: 1200),
                      curve: Curves.easeInCubic,
                      child: Text(
                        'Menuju dalam waktu',
                        style: TextStyle(fontSize: FontScale.sm, color: Colors.grey.shade300),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                CountdownTimers(time: DateTime(2025, 9, 15, 9, 30)),
              ],
            ),
          ),
          BlocSelector<TryThemeCubit, TryThemeState, int>(
            selector: (state) => state.countdownsTimerAnimationTrigger,
            builder: (_, countdownsTimerAnimationTrigger) {
              return Align(
                alignment: const Alignment(0, .92),
                child: AnimatedOpacity(
                  opacity: countdownsTimerAnimationTrigger.toDouble(),
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.easeInCubic,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DoubleArrowSlider(arrowSize: ShapeScale.widthLg, sliderPathLength: ShapeScale.heightX2l),
                      Text(
                        'Geser ke atas',
                        style: TextStyle(fontSize: FontScale.xs, color: Colors.grey.shade300),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _BrideName extends StatefulWidget {
  const _BrideName();

  @override
  State<_BrideName> createState() => _BrideNameState();
}

class _BrideNameState extends State<_BrideName> with TickerProviderStateMixin {
  late final AnimationController _brideController;
  late final AnimationController _andController;
  late final AnimationController _groomController;
  late final Animation<Offset> _brideAnimation;
  late final Animation<double> _andAnimation;
  late final Animation<Offset> _groomAnimation;

  void _runAnimation(int countdownsTimerAnimationTrigger) async {
    if (countdownsTimerAnimationTrigger == 1) _brideController.forward();
    if (countdownsTimerAnimationTrigger == 0) _brideController.reverse();
    await Future.delayed(const Duration(milliseconds: 400));
    if (countdownsTimerAnimationTrigger == 1) _andController.forward();
    if (countdownsTimerAnimationTrigger == 0) _andController.reverse();
    if (countdownsTimerAnimationTrigger == 1) _groomController.forward();
    if (countdownsTimerAnimationTrigger == 0) _groomController.reverse();
  }

  void _initAnimation() {
    _brideController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _andController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _groomController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

    _brideAnimation = Tween<Offset>(
      begin: const Offset(-.6, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _brideController, curve: Curves.easeOut));
    _andAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _andController, curve: Curves.easeOut));
    _groomAnimation = Tween<Offset>(
      begin: const Offset(.8, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _groomController, curve: Curves.easeOut));
  }

  @override
  void initState() {
    super.initState();

    _initAnimation();
  }

  @override
  void dispose() {
    _brideController.dispose();
    _andController.dispose();
    _groomController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TryThemeCubit, TryThemeState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => BlocSelector<TryThemeCubit, TryThemeState, int>(
        selector: (state) => state.countdownsTimerAnimationTrigger,
        builder: (_, countdownsTimerAnimationTrigger) {
          _runAnimation(countdownsTimerAnimationTrigger);
          return Stack(
            children: [
              Align(
                alignment: const Alignment(-1, 0),
                child: SlideTransition(
                  position: _brideAnimation,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Milea',
                          style: TextStyle(fontSize: FontScale.x11l, color: Colors.grey.shade300.withValues(alpha: .8)),
                        ),
                        TextSpan(
                          text: ' & ',
                          style: TextStyle(fontSize: FontScale.x11l, color: Colors.transparent),
                        ),
                        TextSpan(
                          text: 'Dilan',
                          style: TextStyle(fontSize: FontScale.x11l, color: Colors.transparent),
                        ),
                      ],
                    ),
                    style: GoogleFonts.parisienne(fontSize: FontScale.x10l, fontWeight: FontWeight.w900, height: 1.1),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(-1, 0),
                child: FadeTransition(
                  opacity: _andAnimation,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Milea',
                          style: TextStyle(fontSize: FontScale.x11l, color: Colors.transparent),
                        ),
                        TextSpan(
                          text: ' & ',
                          style: TextStyle(fontSize: FontScale.x11l, color: Colors.grey.shade300.withValues(alpha: .8)),
                        ),
                        TextSpan(
                          text: 'Dilan',
                          style: TextStyle(fontSize: FontScale.x11l, color: Colors.transparent),
                        ),
                      ],
                    ),
                    style: GoogleFonts.parisienne(fontSize: FontScale.x10l, fontWeight: FontWeight.w900, height: 1.1),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(-1, 0),
                child: SlideTransition(
                  position: _groomAnimation,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Milea',
                          style: TextStyle(fontSize: FontScale.x11l, color: Colors.transparent),
                        ),
                        TextSpan(
                          text: ' & ',
                          style: TextStyle(fontSize: FontScale.x11l, color: Colors.transparent),
                        ),
                        TextSpan(
                          text: 'Dilan',
                          style: TextStyle(fontSize: FontScale.x11l, color: Colors.grey.shade300.withValues(alpha: .8)),
                        ),
                      ],
                    ),
                    style: GoogleFonts.parisienne(fontSize: FontScale.x10l, fontWeight: FontWeight.w900, height: 1.1),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
