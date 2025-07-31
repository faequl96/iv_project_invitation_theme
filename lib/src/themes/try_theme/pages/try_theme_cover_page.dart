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
              height: ScreenUtil.size.height / 1.3,
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
            alignment: const Alignment(0, .35),
            child: SizedBox(
              width: ScreenUtil.size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pernikahan Dari',
                      style: TextStyle(
                        fontSize: FontScale.lg,
                        fontWeight: FontWeight.w900,
                        color: ColorConverter.darken(Colors.grey.shade300, 7),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const _BrideName(),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, .7),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Menuju dalam waktu',
                  style: TextStyle(fontSize: FontScale.sm, color: Colors.grey.shade300),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: ShapeScale.widthX2l,
                  child: CountdownTimers(time: DateTime(2025, 9, 15, 9, 30)),
                ),
              ],
            ),
          ),
          Align(
            alignment: const Alignment(0, .92),
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

class _BrideNameState extends State<_BrideName> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _brideAnimation;
  late Animation<double> _andAnimation;
  late Animation<Offset> _groomAnimation;

  void _initAnimation() {
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1600));

    _brideAnimation = Tween<Offset>(begin: const Offset(-4, 0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(.0, .6, curve: Curves.easeOut),
      ),
    );
    _andAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(.7, .9, curve: Curves.easeOut),
      ),
    );
    _groomAnimation = Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(.6, .9, curve: Curves.easeOut),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _initAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TryThemeCubit, TryThemeState, int>(
      selector: (state) => state.countdownsTimerAnimationTrigger,
      builder: (_, countdownsTimerAnimationTrigger) {
        if (countdownsTimerAnimationTrigger == 1) _controller.forward();
        if (countdownsTimerAnimationTrigger == 0) _controller.reverse();
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
                        style: TextStyle(color: Colors.grey.shade300.withValues(alpha: .8)),
                      ),
                      const TextSpan(
                        text: ' & ',
                        style: TextStyle(color: Colors.transparent),
                      ),
                      const TextSpan(
                        text: 'Dilan',
                        style: TextStyle(color: Colors.transparent),
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
                      const TextSpan(
                        text: 'Milea',
                        style: TextStyle(color: Colors.transparent),
                      ),
                      TextSpan(
                        text: ' & ',
                        style: TextStyle(color: Colors.grey.shade300.withValues(alpha: .8)),
                      ),
                      const TextSpan(
                        text: 'Dilan',
                        style: TextStyle(color: Colors.transparent),
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
                      const TextSpan(
                        text: 'Milea',
                        style: TextStyle(color: Colors.transparent),
                      ),
                      const TextSpan(
                        text: ' & ',
                        style: TextStyle(color: Colors.transparent),
                      ),
                      TextSpan(
                        text: 'Dilan',
                        style: TextStyle(color: Colors.grey.shade300.withValues(alpha: .8)),
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
    );
  }
}
