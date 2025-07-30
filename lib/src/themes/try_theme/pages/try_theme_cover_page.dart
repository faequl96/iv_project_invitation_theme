import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/core/utils/font_scale.dart';
import 'package:iv_project_invitation_theme/src/core/utils/screen_util.dart';
import 'package:iv_project_invitation_theme/src/core/utils/shape_scale.dart';
import 'package:iv_project_invitation_theme/src/widgets/lightning_effect_box.dart';
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
            'assets/dummys/try_theme_image.jpg',
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
            alignment: const Alignment(0, .4),
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
            child: SizedBox(
              height: ShapeScale.widthX2l,
              child: _CountdownTimers(time: DateTime(2025, 9, 15, 9, 30)),
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
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));

    _brideAnimation = Tween<Offset>(begin: const Offset(-4, 0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(.0, .6, curve: Curves.easeOut),
      ),
    );
    _andAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(.6, .8, curve: Curves.easeOut),
      ),
    );
    _groomAnimation = Tween<Offset>(begin: const Offset(2, 0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(.5, .9, curve: Curves.easeOut),
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

class _CountdownTimers extends StatefulWidget {
  const _CountdownTimers({required this.time});

  final DateTime time;

  @override
  State<_CountdownTimers> createState() => _CountdownTimersState();
}

class _CountdownTimersState extends State<_CountdownTimers> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _daysAnimation;
  late Animation<Offset> _hoursAnimation;
  late Animation<Offset> _minutesAnimation;
  late Animation<Offset> _secondsAnimation;

  late Timer _timer;
  late Duration _remaining;

  final ValueNotifier<int> _days = ValueNotifier(0);
  final ValueNotifier<int> _hours = ValueNotifier(0);
  final ValueNotifier<int> _minutes = ValueNotifier(0);
  final ValueNotifier<int> _seconds = ValueNotifier(0);

  void _initAnimation() {
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400));

    _daysAnimation = Tween<Offset>(
      begin: const Offset(0, 4),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _hoursAnimation = Tween<Offset>(
      begin: const Offset(-6, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _minutesAnimation = Tween<Offset>(
      begin: const Offset(6, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _secondsAnimation = Tween<Offset>(
      begin: const Offset(0, 4),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  void _formatDuration(Duration d) {
    final days = d.inDays;
    final hours = d.inHours % 24;
    final minutes = d.inMinutes % 60;
    final seconds = d.inSeconds % 60;

    _days.value = days;
    _hours.value = hours;
    _minutes.value = minutes;
    _seconds.value = seconds;
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _remaining = widget.time.difference(DateTime.now());
      if (_remaining.isNegative) {
        _remaining = Duration.zero;
        _timer.cancel();
      }
      _formatDuration(_remaining);
    });
  }

  @override
  void initState() {
    super.initState();

    _startTimer();
    _initAnimation();
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TryThemeCubit, TryThemeState, int>(
      selector: (state) => state.countdownsTimerAnimationTrigger,
      builder: (_, countdownsTimerAnimationTrigger) {
        if (countdownsTimerAnimationTrigger == 1) _controller.forward();
        return Stack(
          children: [
            Align(
              alignment: const Alignment(-.6, 0),
              child: ValueListenableBuilder(
                valueListenable: _days,
                builder: (_, days, _) => SlideTransition(
                  position: _daysAnimation,
                  child: _CountdownTimer(number: days, unit: 'hari'),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(-.2, 0),
              child: ValueListenableBuilder(
                valueListenable: _hours,
                builder: (_, hours, _) => SlideTransition(
                  position: _hoursAnimation,
                  child: _CountdownTimer(number: hours, unit: 'jam'),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(.2, 0),
              child: ValueListenableBuilder(
                valueListenable: _minutes,
                builder: (_, minutes, _) => SlideTransition(
                  position: _minutesAnimation,
                  child: _CountdownTimer(number: minutes, unit: 'menit'),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(.6, 0),
              child: ValueListenableBuilder(
                valueListenable: _seconds,
                builder: (_, seconds, _) => SlideTransition(
                  position: _secondsAnimation,
                  child: _CountdownTimer(number: seconds, unit: 'detik'),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CountdownTimer extends StatelessWidget {
  const _CountdownTimer({required this.number, required this.unit});

  final int number;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: ShapeScale.widthX2l,
          height: ShapeScale.widthX2l,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade500, width: .5),
              color: Colors.grey.shade600.withValues(alpha: .2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$number',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade200, height: 1.1),
                ),
                Text(unit, style: TextStyle(color: Colors.grey.shade200, height: 1.1)),
              ],
            ),
          ),
        ),
        LightningEffectBox(width: ShapeScale.widthX2l, height: ShapeScale.widthX2l, borderRadius: 8),
      ],
    );
  }
}
