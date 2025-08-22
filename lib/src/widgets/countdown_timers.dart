import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iv_project_invitation_theme/src/core/app_fonts.dart';
import 'package:iv_project_invitation_theme/src/core/utils/font_scale.dart';
import 'package:iv_project_invitation_theme/src/core/utils/size_scale.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_invitation_theme/src/widgets/lightning_effect_box.dart';

class CountdownTimers extends StatefulWidget {
  const CountdownTimers({super.key, required this.time});

  final DateTime time;

  @override
  State<CountdownTimers> createState() => _CountdownTimersState();
}

class _CountdownTimersState extends State<CountdownTimers> {
  late final Timer _timer;
  late Duration _remaining;

  final ValueNotifier<int> _days = ValueNotifier(0);
  final ValueNotifier<int> _hours = ValueNotifier(0);
  final ValueNotifier<int> _minutes = ValueNotifier(0);
  final ValueNotifier<int> _seconds = ValueNotifier(0);

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

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FadeAndSlideTransition(
          slideFromOffset: 1.5,
          slideFrom: SlideFrom.bottom,
          delayBeforeStart: const Duration(milliseconds: 400),
          child: ValueListenableBuilder(
            valueListenable: _days,
            builder: (_, days, _) => _CountdownTimer(number: days, unit: 'Hari'),
          ),
        ),
        SizedBox(width: SizeScale.widthX4s),
        FadeAndSlideTransition(
          slideFromOffset: 2.5,
          slideFrom: SlideFrom.left,
          animationSpeed: const Duration(milliseconds: 700),
          delayBeforeStart: const Duration(milliseconds: 200),
          child: ValueListenableBuilder(
            valueListenable: _hours,
            builder: (_, hours, _) => _CountdownTimer(number: hours, unit: 'Jam'),
          ),
        ),
        SizedBox(width: SizeScale.widthX4s),
        FadeAndSlideTransition(
          slideFromOffset: 2.5,
          slideFrom: SlideFrom.right,
          animationSpeed: const Duration(milliseconds: 700),
          delayBeforeStart: const Duration(milliseconds: 200),
          child: ValueListenableBuilder(
            valueListenable: _minutes,
            builder: (_, minutes, _) => _CountdownTimer(number: minutes, unit: 'Menit'),
          ),
        ),
        SizedBox(width: SizeScale.widthX4s),
        FadeAndSlideTransition(
          slideFromOffset: 1.5,
          slideFrom: SlideFrom.bottom,
          delayBeforeStart: const Duration(milliseconds: 400),
          child: ValueListenableBuilder(
            valueListenable: _seconds,
            builder: (_, seconds, _) => _CountdownTimer(number: seconds, unit: 'Detik'),
          ),
        ),
      ],
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
                  '$number',
                  style: AppFonts.inter(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade200,
                    fontSize: FontScale.sm,
                    height: 1.2,
                  ),
                ),
                Text(
                  unit,
                  style: AppFonts.inter(color: Colors.grey.shade200, fontSize: FontScale.xs, height: 1.2),
                ),
              ],
            ),
          ),
        ),
        LightningEffectBox(
          width: SizeScale.widthX3l,
          height: SizeScale.widthX3l,
          borderRadius: 8,
          isFlash: true,
          delayBeforeStart: const Duration(milliseconds: 500),
        ),
      ],
    );
  }
}
