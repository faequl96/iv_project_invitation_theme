import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_invitation_theme/src/widgets/lightning_effect_box.dart';

class CountdownTimers extends StatefulWidget {
  const CountdownTimers({
    super.key,
    required this.time,
    this.animationDelayBeforeStart = Duration.zero,
    this.lightningEffectDelayBeforeShowed = const Duration(milliseconds: 1200),
  });

  final DateTime time;
  final Duration animationDelayBeforeStart;
  final Duration lightningEffectDelayBeforeShowed;

  @override
  State<CountdownTimers> createState() => _CountdownTimersState();
}

class _CountdownTimersState extends State<CountdownTimers> {
  late final Timer _timer;
  late Duration _remaining;

  final _days = ValueNotifier(0);
  final _hours = ValueNotifier(0);
  final _minutes = ValueNotifier(0);
  final _seconds = ValueNotifier(0);

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
  }

  @override
  void dispose() {
    _timer.cancel();
    _days.dispose();
    _hours.dispose();
    _minutes.dispose();
    _seconds.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .center,
      children: [
        FadeAndSlideTransition(
          slideFromOffset: 1.5,
          slideFrom: .bottom,
          delayBeforeStart: (const Duration(milliseconds: 400) + widget.animationDelayBeforeStart),
          child: ValueListenableBuilder(
            valueListenable: _days,
            builder: (_, days, _) {
              return _CountdownTimer(
                number: days,
                unit: 'Hari',
                lightningEffectDelayBeforeShowed: const Duration(milliseconds: 200) + widget.lightningEffectDelayBeforeShowed,
              );
            },
          ),
        ),
        SizedBox(width: W.x4s),
        FadeAndSlideTransition(
          slideFromOffset: 2.5,
          slideFrom: .left,
          animationSpeed: const Duration(milliseconds: 700),
          delayBeforeStart: (const Duration(milliseconds: 200) + widget.animationDelayBeforeStart),
          child: ValueListenableBuilder(
            valueListenable: _hours,
            builder: (_, hours, _) {
              return _CountdownTimer(
                number: hours,
                unit: 'Jam',
                lightningEffectDelayBeforeShowed: const Duration(milliseconds: 400) + widget.lightningEffectDelayBeforeShowed,
              );
            },
          ),
        ),
        SizedBox(width: W.x4s),
        FadeAndSlideTransition(
          slideFromOffset: 2.5,
          slideFrom: .right,
          animationSpeed: const Duration(milliseconds: 700),
          delayBeforeStart: (const Duration(milliseconds: 200) + widget.animationDelayBeforeStart),
          child: ValueListenableBuilder(
            valueListenable: _minutes,
            builder: (_, minutes, _) {
              return _CountdownTimer(
                number: minutes,
                unit: 'Menit',
                lightningEffectDelayBeforeShowed: const Duration(milliseconds: 600) + widget.lightningEffectDelayBeforeShowed,
              );
            },
          ),
        ),
        SizedBox(width: W.x4s),
        FadeAndSlideTransition(
          slideFromOffset: 1.5,
          slideFrom: .bottom,
          delayBeforeStart: (const Duration(milliseconds: 400) + widget.animationDelayBeforeStart),
          child: ValueListenableBuilder(
            valueListenable: _seconds,
            builder: (_, seconds, _) {
              return _CountdownTimer(
                number: seconds,
                unit: 'Detik',
                lightningEffectDelayBeforeShowed: const Duration(milliseconds: 800) + widget.lightningEffectDelayBeforeShowed,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CountdownTimer extends StatelessWidget {
  const _CountdownTimer({required this.number, required this.unit, required this.lightningEffectDelayBeforeShowed});

  final int number;
  final String unit;
  final Duration lightningEffectDelayBeforeShowed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: W.x3l,
          height: W.x3l,
          child: DecoratedBox(
            decoration: BoxDecoration(borderRadius: .circular(8), color: Colors.grey.shade500.withValues(alpha: .2)),
          ),
        ),
        SizedBox(
          width: W.x3l,
          height: W.x3l,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: .circular(8),
              border: .all(color: Colors.grey.shade600),
            ),
            child: Column(
              mainAxisAlignment: .center,
              children: [
                Text(
                  '$number',
                  style: AppFonts.inter(fontWeight: .w700, color: Colors.grey.shade200, fontSize: FontSize.sm, height: 1.2),
                ),
                Text(
                  unit,
                  style: AppFonts.inter(color: Colors.grey.shade200, fontSize: FontSize.xs, height: 1.2),
                ),
              ],
            ),
          ),
        ),
        LightningEffectBox(
          width: W.x3l,
          height: W.x3l,
          borderRadius: 8,
          isFlash: true,
          delayBeforeShowed: lightningEffectDelayBeforeShowed,
        ),
      ],
    );
  }
}
