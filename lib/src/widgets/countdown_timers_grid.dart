import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';

class CountdownTimersGrid extends StatefulWidget {
  const CountdownTimersGrid({
    super.key,
    required this.paddingHorizontal,
    required this.oddColor,
    required this.evenColor,
    required this.oddBorderColor,
    required this.evenBorderColor,
    required this.numberColor,
    required this.unitColor,
    this.borderWidth = 1,
    required this.time,
    this.animationDelayBeforeStart = .zero,
    required this.noAnimate,
  });

  final double paddingHorizontal;
  final Color oddColor;
  final Color evenColor;
  final Color oddBorderColor;
  final Color evenBorderColor;
  final Color numberColor;
  final Color unitColor;
  final double borderWidth;
  final DateTime time;
  final Duration animationDelayBeforeStart;
  final bool noAnimate;

  @override
  State<CountdownTimersGrid> createState() => _CountdownTimersGridState();
}

class _CountdownTimersGridState extends State<CountdownTimersGrid> {
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: .center,
          children: [
            SizedBox(width: widget.paddingHorizontal),
            Expanded(
              child: _NoAnimateWrapper(
                noAnimate: widget.noAnimate,
                slideFromOffset: 1.5,
                slideFrom: .bottom,
                delayBeforeStart:
                    (const Duration(milliseconds: 400) + widget.animationDelayBeforeStart),
                child: _countdownTimer(_days, 'Hari'),
              ),
            ),
            SizedBox(width: W.x15s),
            Expanded(
              child: _NoAnimateWrapper(
                noAnimate: widget.noAnimate,
                slideFromOffset: 2.5,
                slideFrom: .left,
                animationSpeed: const Duration(milliseconds: 700),
                delayBeforeStart:
                    (const Duration(milliseconds: 200) + widget.animationDelayBeforeStart),
                child: _countdownTimer(_hours, 'Jam'),
              ),
            ),
            SizedBox(width: widget.paddingHorizontal),
          ],
        ),
        SizedBox(height: W.x15s),
        Row(
          mainAxisAlignment: .center,
          children: [
            SizedBox(width: widget.paddingHorizontal),
            Expanded(
              child: _NoAnimateWrapper(
                noAnimate: widget.noAnimate,
                slideFromOffset: 2.5,
                slideFrom: .right,
                animationSpeed: const Duration(milliseconds: 700),
                delayBeforeStart:
                    (const Duration(milliseconds: 200) + widget.animationDelayBeforeStart),
                child: _countdownTimer(_minutes, 'Menit'),
              ),
            ),
            SizedBox(width: W.x15s),
            Expanded(
              child: RepaintBoundary(
                child: _NoAnimateWrapper(
                  noAnimate: widget.noAnimate,
                  slideFromOffset: 1.5,
                  slideFrom: .bottom,
                  delayBeforeStart:
                      (const Duration(milliseconds: 400) + widget.animationDelayBeforeStart),
                  child: _countdownTimer(_seconds, 'Detik'),
                ),
              ),
            ),
            SizedBox(width: widget.paddingHorizontal),
          ],
        ),
      ],
    );
  }

  Widget _countdownTimer(ValueNotifier<int> valueListenable, String unit) => ValueListenableBuilder(
    valueListenable: valueListenable,
    builder: (_, value, _) {
      return _CountdownTimer(
        color: widget.evenColor,
        borderColor: widget.evenBorderColor,
        numberColor: widget.numberColor,
        unitColor: widget.unitColor,
        borderWidth: widget.borderWidth,
        number: value,
        unit: unit,
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
    required this.number,
    required this.unit,
  });

  final Color color;
  final Color borderColor;
  final Color numberColor;
  final Color unitColor;
  final double borderWidth;
  final int number;
  final String unit;

  @override
  Widget build(BuildContext context) {
    final BorderRadiusGeometry borderRadius = switch (unit) {
      'Hari' => const .only(bottomRight: .circular(12), topLeft: .circular(10)),
      'Jam' => const .only(bottomLeft: .circular(12), topRight: .circular(10)),
      'Menit' => const .only(topRight: .circular(12), bottomLeft: .circular(10)),
      'Detik' => const .only(topLeft: .circular(12), bottomRight: .circular(10)),
      String() => const .only(),
    };

    return SizedBox(
      width: .infinity,
      height: W.x3l,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
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
    );
  }
}

class _NoAnimateWrapper extends StatelessWidget {
  const _NoAnimateWrapper({
    required this.noAnimate,
    required this.slideFromOffset,
    required this.slideFrom,
    this.animationSpeed = const Duration(milliseconds: 500),
    required this.delayBeforeStart,
    required this.child,
  });

  final bool noAnimate;
  final double slideFromOffset;
  final SlideFrom slideFrom;
  final Duration animationSpeed;
  final Duration delayBeforeStart;
  final Widget child;

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
