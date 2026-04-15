import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_invitation_theme/src/widgets/lightning_effect_box.dart';

class CountdownTimers extends StatefulWidget {
  const CountdownTimers({
    super.key,
    required this.oddColor,
    required this.evenColor,
    required this.oddBorderColor,
    required this.evenBorderColor,
    required this.numberColor,
    required this.unitColor,
    this.borderWidth = 1,
    required this.time,
    required this.useLightningEffect,
    this.animationDelayBeforeStart = .zero,
    this.lightningEffectDelayBeforeShowed = const Duration(milliseconds: 1200),
    required this.noAnimate,
  });

  final Color oddColor;
  final Color evenColor;
  final Color oddBorderColor;
  final Color evenBorderColor;
  final Color numberColor;
  final Color unitColor;
  final double borderWidth;
  final DateTime time;
  final bool useLightningEffect;
  final Duration animationDelayBeforeStart;
  final Duration lightningEffectDelayBeforeShowed;
  final bool noAnimate;

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
      _remaining = widget.time.difference(.now());
      if (_remaining.isNegative) {
        _remaining = .zero;
        _timer.cancel();
      }
      _formatDuration(_remaining);
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.noAnimate) {
      _remaining = widget.time.difference(.now());
      _formatDuration(_remaining);
    } else {
      _startTimer();
    }
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
        if (!widget.noAnimate) ...[
          FadeAndSlideTransition(
            slideFromOffset: 1.5,
            slideFrom: .bottom,
            delayBeforeStart: (const Duration(milliseconds: 400) + widget.animationDelayBeforeStart),
            child: _countdownTimer(_days, 'Hari', lightningEffectDelayBase: const Duration(milliseconds: 200)),
          ),
          SizedBox(width: W.x4s),
          FadeAndSlideTransition(
            slideFromOffset: 2.5,
            slideFrom: .left,
            animationSpeed: const Duration(milliseconds: 700),
            delayBeforeStart: (const Duration(milliseconds: 200) + widget.animationDelayBeforeStart),
            child: _countdownTimer(_hours, 'Jam', lightningEffectDelayBase: const Duration(milliseconds: 400)),
          ),
          SizedBox(width: W.x4s),
          FadeAndSlideTransition(
            slideFromOffset: 2.5,
            slideFrom: .right,
            animationSpeed: const Duration(milliseconds: 700),
            delayBeforeStart: (const Duration(milliseconds: 200) + widget.animationDelayBeforeStart),
            child: _countdownTimer(_minutes, 'Menit', lightningEffectDelayBase: const Duration(milliseconds: 600)),
          ),
          SizedBox(width: W.x4s),
          FadeAndSlideTransition(
            slideFromOffset: 1.5,
            slideFrom: .bottom,
            delayBeforeStart: (const Duration(milliseconds: 400) + widget.animationDelayBeforeStart),
            child: _countdownTimer(_seconds, 'Detik', lightningEffectDelayBase: const Duration(milliseconds: 800)),
          ),
        ] else ...[
          _countdownTimer(_days, 'Hari', staticLightningEffectValue: .6),
          SizedBox(width: W.x4s),
          _countdownTimer(_hours, 'Jam', staticLightningEffectValue: .45),
          SizedBox(width: W.x4s),
          _countdownTimer(_minutes, 'Menit', staticLightningEffectValue: .3),
          SizedBox(width: W.x4s),
          _countdownTimer(_seconds, 'Detik', staticLightningEffectValue: .15),
        ],
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
        lightningEffectDelayBeforeShowed: (lightningEffectDelayBase ?? Duration.zero) + widget.lightningEffectDelayBeforeShowed,
        staticLightningEffectValue: staticLightningEffectValue,
      );
    },
  );
}

class _CountdownTimer extends StatelessWidget {
  const _CountdownTimer({
    required this.color,
    required this.borderColor,
    required this.numberColor,
    required this.unitColor,
    required this.borderWidth,
    required this.useLightningEffect,
    required this.number,
    required this.unit,
    required this.lightningEffectDelayBeforeShowed,
    this.staticLightningEffectValue,
  });

  final Color color;
  final Color borderColor;
  final Color numberColor;
  final Color unitColor;
  final double borderWidth;
  final bool useLightningEffect;
  final int number;
  final String unit;
  final Duration lightningEffectDelayBeforeShowed;
  final double? staticLightningEffectValue;

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
                  style: AppFonts.inter(fontWeight: .w700, color: numberColor, fontSize: FontSize.sm, height: 1.2),
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
