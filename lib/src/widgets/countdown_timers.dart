import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_invitation_theme/src/widgets/lightning_effect_box.dart';

class const CountdownTimers({
  super.key,
  required final Color oddColor,
  required final Color evenColor,
  required final Color oddBorderColor,
  required final Color evenBorderColor,
  required final Color numberColor,
  required final Color unitColor,
  final double borderWidth = 1,
  required final DateTime time,
  required final bool useLightningEffect,
  final Duration animationDelayBeforeStart = .zero,
  final Duration lightningEffectDelayBeforeShowed = const Duration(milliseconds: 1200),
  required final bool noAnimate,
}) extends StatefulWidget {
  @override
  State<CountdownTimers> createState() => _CountdownTimersState();
}

class _CountdownTimersState() extends State<CountdownTimers> {
  Timer? _timer;
  late Duration _remaining;

  final _days = ValueNotifier(0);
  final _hours = ValueNotifier(0);
  final _minutes = ValueNotifier(0);
  final _seconds = ValueNotifier(0);

  @override
  void initState() {
    super.initState();

    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();

    _days.dispose();
    _hours.dispose();
    _minutes.dispose();
    _seconds.dispose();

    super.dispose();
  }

  void _formatDuration(Duration d) {
    final days = d.inDays;
    final hours = d.inHours % 24;
    final minutes = d.inMinutes % 60;
    final seconds = d.inSeconds % 60;

    if (_days.value != days) _days.value = days;
    if (_hours.value != hours) _hours.value = hours;
    if (_minutes.value != minutes) _minutes.value = minutes;
    if (_seconds.value != seconds) _seconds.value = seconds;
  }

  void _startTimer() {
    _remaining = widget.time.difference(.now());
    if (_remaining.isNegative) _remaining = .zero;
    _formatDuration(_remaining);

    if (widget.noAnimate || _remaining == .zero) return;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _remaining = widget.time.difference(.now());
      if (_remaining.isNegative) {
        _remaining = .zero;
        timer.cancel();
      }
      _formatDuration(_remaining);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .center,
      children: [
        _NoAnimateWrapper(
          noAnimate: widget.noAnimate,
          slideFromOffset: 1.5,
          slideFrom: .bottom,
          delayBeforeStart: (const Duration(milliseconds: 400) + widget.animationDelayBeforeStart),
          child: _countdownTimer(
            _days,
            'Hari',
            lightningEffectDelayBase: const Duration(milliseconds: 200),
          ),
        ),
        SizedBox(width: W.x4s),
        _NoAnimateWrapper(
          noAnimate: widget.noAnimate,
          slideFromOffset: 2.5,
          slideFrom: .left,
          animationSpeed: const Duration(milliseconds: 700),
          delayBeforeStart: (const Duration(milliseconds: 200) + widget.animationDelayBeforeStart),
          child: _countdownTimer(
            _hours,
            'Jam',
            lightningEffectDelayBase: const Duration(milliseconds: 400),
          ),
        ),
        SizedBox(width: W.x4s),
        _NoAnimateWrapper(
          noAnimate: widget.noAnimate,
          slideFromOffset: 2.5,
          slideFrom: .right,
          animationSpeed: const Duration(milliseconds: 700),
          delayBeforeStart: (const Duration(milliseconds: 200) + widget.animationDelayBeforeStart),
          child: _countdownTimer(
            _minutes,
            'Menit',
            lightningEffectDelayBase: const Duration(milliseconds: 600),
          ),
        ),
        SizedBox(width: W.x4s),
        RepaintBoundary(
          child: _NoAnimateWrapper(
            noAnimate: widget.noAnimate,
            slideFromOffset: 1.5,
            slideFrom: .bottom,
            delayBeforeStart:
                (const Duration(milliseconds: 400) + widget.animationDelayBeforeStart),
            child: _countdownTimer(
              _seconds,
              'Detik',
              lightningEffectDelayBase: const Duration(milliseconds: 800),
            ),
          ),
        ),
      ],
    );
  }

  Widget _countdownTimer(
    ValueNotifier<int> valueListenable,
    String unit, {
    Duration? lightningEffectDelayBase,
    double? staticLightningEffectValue,
  }) => ValueListenableBuilder(
    valueListenable: valueListenable,
    builder: (_, value, _) {
      return _CountdownTimer(
        color: widget.evenColor,
        borderColor: widget.evenBorderColor,
        numberColor: widget.numberColor,
        unitColor: widget.unitColor,
        borderWidth: widget.borderWidth,
        useLightningEffect: widget.useLightningEffect,
        number: value,
        unit: unit,
        lightningEffectDelayBeforeShowed:
            (lightningEffectDelayBase ?? .zero) + widget.lightningEffectDelayBeforeShowed,
        staticLightningEffectValue: staticLightningEffectValue,
      );
    },
  );
}

class const _CountdownTimer({
  required final Color color,
  required final Color borderColor,
  required final Color numberColor,
  required final Color unitColor,
  required final double borderWidth,
  required final bool useLightningEffect,
  required final int number,
  required final String unit,
  required final Duration lightningEffectDelayBeforeShowed,
  final double? staticLightningEffectValue,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: W.x3l,
          height: W.x3l,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: .circular(8),
              border: .all(width: borderWidth, color: borderColor),
              color: color,
            ),
            child: Column(
              mainAxisAlignment: .center,
              children: [
                Text(
                  '$number',
                  style: AppFonts.inter(
                    fontWeight: .w700,
                    color: numberColor,
                    fontSize: FontSize.sm,
                    height: 1.2,
                  ),
                ),
                Text(
                  unit,
                  style: AppFonts.inter(color: unitColor, fontSize: FontSize.xs, height: 1.2),
                ),
              ],
            ),
          ),
        ),
        if (useLightningEffect)
          LightningEffectBox(
            width: W.x3l,
            height: W.x3l,
            borderRadius: 8,
            ligthningWidth: borderWidth,
            isFlash: true,
            delayBeforeShowed: lightningEffectDelayBeforeShowed,
            staticValue: staticLightningEffectValue,
          ),
      ],
    );
  }
}

class const _NoAnimateWrapper({
  required final bool noAnimate,
  required final double slideFromOffset,
  required final SlideFrom slideFrom,
  final Duration animationSpeed = const Duration(milliseconds: 500),
  required final Duration delayBeforeStart,
  required final Widget child,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (noAnimate) return child;

    return FadeAndSlideTransition(
      slideFromOffset: slideFromOffset,
      slideFrom: slideFrom,
      animationSpeed: animationSpeed,
      delayBeforeStart: delayBeforeStart,
      child: child,
    );
  }
}
