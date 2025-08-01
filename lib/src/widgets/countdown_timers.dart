import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_invitation_theme/src/core/cubit/core_cubit.dart';
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
  late final Animation<Offset> _daysAnimation;
  late final Animation<Offset> _hoursAnimation;
  late final Animation<Offset> _minutesAnimation;
  late final Animation<Offset> _secondsAnimation;

  late final Timer _timer;
  late Duration _remaining;

  final ValueNotifier<int> _days = ValueNotifier(0);
  final ValueNotifier<int> _hours = ValueNotifier(0);
  final ValueNotifier<int> _minutes = ValueNotifier(0);
  final ValueNotifier<int> _seconds = ValueNotifier(0);

  void _initAnimation() {
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));

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
    return BlocSelector<CoreCubit, CoreState, int>(
      selector: (state) => state.countdownsTimerAnimationTrigger,
      builder: (_, countdownsTimerAnimationTrigger) {
        if (countdownsTimerAnimationTrigger == 1) _controller.forward();
        if (countdownsTimerAnimationTrigger == 0) _controller.reverse();
        return Stack(
          children: [
            Align(
              alignment: const Alignment(-.66, 0),
              child: ValueListenableBuilder(
                valueListenable: _days,
                builder: (_, days, _) => SlideTransition(
                  position: _daysAnimation,
                  child: _CountdownTimer(number: days, unit: 'hari'),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(-.22, 0),
              child: ValueListenableBuilder(
                valueListenable: _hours,
                builder: (_, hours, _) => SlideTransition(
                  position: _hoursAnimation,
                  child: _CountdownTimer(number: hours, unit: 'jam'),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(.22, 0),
              child: ValueListenableBuilder(
                valueListenable: _minutes,
                builder: (_, minutes, _) => SlideTransition(
                  position: _minutesAnimation,
                  child: _CountdownTimer(number: minutes, unit: 'menit'),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(.66, 0),
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
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: SizedBox(
              width: SizeScale.widthX3l,
              height: SizeScale.widthX3l,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade500.withValues(alpha: .2),
                ),
              ),
            ),
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
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade200, height: 1.1),
                ),
                Text(unit, style: TextStyle(color: Colors.grey.shade200, height: 1.1)),
              ],
            ),
          ),
        ),
        LightningEffectBox(width: SizeScale.widthX3l, height: SizeScale.widthX3l, borderRadius: 8),
      ],
    );
  }
}
