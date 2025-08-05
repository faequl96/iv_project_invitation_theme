import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_invitation_theme/src/core/app_fonts.dart';
import 'package:iv_project_invitation_theme/src/core/cubit/core_cubit.dart';
import 'package:iv_project_invitation_theme/src/core/utils/font_scale.dart';
import 'package:iv_project_invitation_theme/src/core/utils/size_scale.dart';
import 'package:iv_project_invitation_theme/src/widgets/lightning_effect_box.dart';

class CountdownTimers extends StatefulWidget {
  const CountdownTimers({super.key, required this.time});

  final DateTime time;

  @override
  State<CountdownTimers> createState() => _CountdownTimersState();
}

class _CountdownTimersState extends State<CountdownTimers> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _daysSlideAnimation;
  late final Animation<Offset> _hoursSlideAnimation;
  late final Animation<Offset> _minutesSlideAnimation;
  late final Animation<Offset> _secondsSlideAnimation;
  late final Animation<double> _daysFadeAnimation;
  late final Animation<double> _hoursFadeAnimation;
  late final Animation<double> _minutesFadeAnimation;
  late final Animation<double> _secondsFadeAnimation;

  late final Timer _timer;
  late Duration _remaining;

  final ValueNotifier<int> _days = ValueNotifier(0);
  final ValueNotifier<int> _hours = ValueNotifier(0);
  final ValueNotifier<int> _minutes = ValueNotifier(0);
  final ValueNotifier<int> _seconds = ValueNotifier(0);

  void _initAnimation() {
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));

    _daysSlideAnimation = Tween<Offset>(
      begin: Offset(0, SizeScale.heightX13s),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _hoursSlideAnimation = Tween<Offset>(
      begin: Offset(-SizeScale.widthX13s, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _minutesSlideAnimation = Tween<Offset>(
      begin: Offset(SizeScale.widthX13s, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _secondsSlideAnimation = Tween<Offset>(
      begin: Offset(0, SizeScale.heightX13s),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _daysFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _hoursFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _minutesFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _secondsFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
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
    return BlocSelector<CoreCubit, CoreState, int>(
      selector: (state) => state.animationTrigger,
      builder: (_, animationTrigger) {
        if (animationTrigger == 1) _controller.forward();
        if (animationTrigger == 0) _controller.reverse();
        return Stack(
          children: [
            Align(
              alignment: const Alignment(-.66, 0),
              child: FadeTransition(
                opacity: _daysFadeAnimation,
                child: SlideTransition(
                  position: _daysSlideAnimation,
                  child: ValueListenableBuilder(
                    valueListenable: _days,
                    builder: (_, days, _) => _CountdownTimer(number: days, unit: 'Hari', animationTrigger: animationTrigger),
                  ),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(-.22, 0),
              child: FadeTransition(
                opacity: _hoursFadeAnimation,
                child: SlideTransition(
                  position: _hoursSlideAnimation,
                  child: ValueListenableBuilder(
                    valueListenable: _hours,
                    builder: (_, hours, _) => _CountdownTimer(number: hours, unit: 'Jam', animationTrigger: animationTrigger),
                  ),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(.22, 0),
              child: FadeTransition(
                opacity: _minutesFadeAnimation,
                child: SlideTransition(
                  position: _minutesSlideAnimation,
                  child: ValueListenableBuilder(
                    valueListenable: _minutes,
                    builder: (_, minutes, _) =>
                        _CountdownTimer(number: minutes, unit: 'Menit', animationTrigger: animationTrigger),
                  ),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(.66, 0),
              child: FadeTransition(
                opacity: _secondsFadeAnimation,
                child: SlideTransition(
                  position: _secondsSlideAnimation,
                  child: ValueListenableBuilder(
                    valueListenable: _seconds,
                    builder: (_, seconds, _) =>
                        _CountdownTimer(number: seconds, unit: 'Detik', animationTrigger: animationTrigger),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CountdownTimer extends StatefulWidget {
  const _CountdownTimer({required this.number, required this.unit, required this.animationTrigger});

  final int number;
  final String unit;
  final int animationTrigger;

  @override
  State<_CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<_CountdownTimer> {
  final ValueNotifier<bool> showLightningEffectBox = ValueNotifier(false);

  @override
  void didUpdateWidget(covariant _CountdownTimer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.animationTrigger == 1) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await Future.delayed(const Duration(seconds: 2));
        showLightningEffectBox.value = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: SizeScale.widthX3l,
          height: SizeScale.widthX3l,
          child: DecoratedBox(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey.shade500.withValues(alpha: .2)),
          ),
        ),
        SizedBox(
          width: SizeScale.widthX3l,
          height: SizeScale.widthX3l,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade600),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${widget.number}',
                  style: AppFonts.inter(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade200,
                    fontSize: FontScale.sm,
                    height: 1.2,
                  ),
                ),
                Text(
                  widget.unit,
                  style: AppFonts.inter(color: Colors.grey.shade200, fontSize: FontScale.xs, height: 1.2),
                ),
              ],
            ),
          ),
        ),
        if (widget.animationTrigger == 1)
          ValueListenableBuilder(
            valueListenable: showLightningEffectBox,
            builder: (_, _, _) {
              if (!showLightningEffectBox.value) return const SizedBox.shrink();
              return LightningEffectBox(width: SizeScale.widthX3l, height: SizeScale.widthX3l, borderRadius: 8, isFlash: true);
            },
          ),
      ],
    );
  }
}
