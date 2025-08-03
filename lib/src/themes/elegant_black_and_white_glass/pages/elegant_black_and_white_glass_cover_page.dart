import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iv_project_invitation_theme/src/core/cubit/core_cubit.dart';
import 'package:iv_project_invitation_theme/src/core/utils/font_scale.dart';
import 'package:iv_project_invitation_theme/src/core/utils/screen_util.dart';
import 'package:iv_project_invitation_theme/src/core/utils/size_scale.dart';
import 'package:iv_project_invitation_theme/src/widgets/countdown_timers.dart';
import 'package:iv_project_invitation_theme/src/widgets/double_arrow_slider.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class ElegantBlackAndWhiteGlassCoverPage extends StatelessWidget {
  const ElegantBlackAndWhiteGlassCoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CoreCubit, CoreState, Size>(
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
                    colors: [Colors.transparent, Colors.grey.shade900],
                    stops: const [.3, .8],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, .32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocSelector<CoreCubit, CoreState, int>(
                  selector: (state) => state.animationTrigger,
                  builder: (_, animationTrigger) {
                    return AnimatedOpacity(
                      opacity: animationTrigger.toDouble(),
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
                SizedBox(height: SizeScale.heightX9s),
                const _BrideName(),
              ],
            ),
          ),
          Align(
            alignment: const Alignment(0, .68),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocSelector<CoreCubit, CoreState, int>(
                  selector: (state) => state.animationTrigger,
                  builder: (_, animationTrigger) {
                    return AnimatedOpacity(
                      opacity: animationTrigger.toDouble(),
                      duration: const Duration(milliseconds: 1000),
                      curve: animationTrigger == 1 ? Curves.easeInCubic : Curves.easeOutCubic,
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
          BlocSelector<CoreCubit, CoreState, int>(
            selector: (state) => state.animationTrigger,
            builder: (_, animationTrigger) {
              return Align(
                alignment: const Alignment(0, .92),
                child: AnimatedOpacity(
                  opacity: animationTrigger.toDouble(),
                  duration: const Duration(milliseconds: 1600),
                  curve: animationTrigger == 1 ? Curves.easeInCubic : Curves.easeOutCubic,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (animationTrigger == 1)
                        DoubleArrowSlider(arrowSize: SizeScale.widthLg, sliderPathLength: SizeScale.heightX2l),
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
  late final Animation<Offset> _brideSlideAnimation;
  late final Animation<Offset> _groomSlideAnimation;
  late final Animation<double> _brideFadeAnimation;
  late final Animation<double> _andFadeAnimation;
  late final Animation<double> _groomFadeAnimation;

  void _runAnimation(int animationTrigger) async {
    if (animationTrigger == 1) {
      _brideController.forward();
      await Future.delayed(const Duration(milliseconds: 200));
      if (mounted) {
        _groomController.forward();
        await Future.delayed(const Duration(milliseconds: 200));
        _andController.forward();
        await Future.delayed(const Duration(milliseconds: 200));
        if (_brideController.value != 1) _brideController.forward();
      }
    } else {
      _groomController.reverse();
      await Future.delayed(const Duration(milliseconds: 200));
      if (mounted) {
        _andController.reverse();
        await Future.delayed(const Duration(milliseconds: 200));
        _brideController.reverse();
      }
    }
  }

  void _initAnimation() {
    _brideController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _andController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _groomController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

    _brideSlideAnimation = Tween<Offset>(
      begin: const Offset(-.8, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _brideController, curve: Curves.easeIn));
    _groomSlideAnimation = Tween<Offset>(
      begin: const Offset(.8, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _groomController, curve: Curves.easeIn));

    _brideFadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _brideController, curve: Curves.easeIn));
    _andFadeAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _andController, curve: Curves.easeIn));
    _groomFadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _groomController, curve: Curves.easeIn));
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
    return BlocSelector<CoreCubit, CoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => BlocSelector<CoreCubit, CoreState, int>(
        selector: (state) => state.animationTrigger,
        builder: (_, animationTrigger) {
          _runAnimation(animationTrigger);
          return Stack(
            children: [
              Align(
                alignment: const Alignment(0, 0),
                child: FadeTransition(
                  opacity: _brideFadeAnimation,
                  child: SlideTransition(
                    position: _brideSlideAnimation,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Milea',
                            style: TextStyle(fontSize: FontScale.x10l, color: Colors.grey.shade200.withValues(alpha: .8)),
                          ),
                          TextSpan(
                            text: ' & ',
                            style: TextStyle(fontSize: FontScale.x10l, color: Colors.transparent),
                          ),
                          TextSpan(
                            text: 'Dilan',
                            style: TextStyle(fontSize: FontScale.x10l, color: Colors.transparent),
                          ),
                        ],
                      ),
                      style: GoogleFonts.parisienne(fontSize: FontScale.x10l, fontWeight: FontWeight.w900, height: 1.1),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0, 0),
                child: FadeTransition(
                  opacity: _andFadeAnimation,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Milea',
                          style: TextStyle(fontSize: FontScale.x10l, color: Colors.transparent),
                        ),
                        TextSpan(
                          text: ' & ',
                          style: TextStyle(fontSize: FontScale.x10l, color: Colors.grey.shade200.withValues(alpha: .8)),
                        ),
                        TextSpan(
                          text: 'Dilan',
                          style: TextStyle(fontSize: FontScale.x10l, color: Colors.transparent),
                        ),
                      ],
                    ),
                    style: GoogleFonts.parisienne(fontSize: FontScale.x10l, fontWeight: FontWeight.w900, height: 1.1),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0, 0),
                child: FadeTransition(
                  opacity: _groomFadeAnimation,
                  child: SlideTransition(
                    position: _groomSlideAnimation,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Milea',
                            style: TextStyle(fontSize: FontScale.x10l, color: Colors.transparent),
                          ),
                          TextSpan(
                            text: ' & ',
                            style: TextStyle(fontSize: FontScale.x10l, color: Colors.transparent),
                          ),
                          TextSpan(
                            text: 'Dilan',
                            style: TextStyle(fontSize: FontScale.x10l, color: Colors.grey.shade200.withValues(alpha: .8)),
                          ),
                        ],
                      ),
                      style: GoogleFonts.parisienne(fontSize: FontScale.x10l, fontWeight: FontWeight.w900, height: 1.1),
                    ),
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
