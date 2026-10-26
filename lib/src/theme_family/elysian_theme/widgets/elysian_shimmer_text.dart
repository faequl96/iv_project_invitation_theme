import 'package:flutter/material.dart';

class const ElysianShimmerText({
  super.key,
  required final String text,
  required final TextStyle style,
  final Color baseColor = const Color(0xFFD4AF37),
  final Color highlightColor = Colors.white,
  final TextAlign textAlign = .center,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _ShimmerAnimator(
      text: text,
      style: style,
      baseColor: baseColor,
      highlightColor: highlightColor,
      textAlign: textAlign,
    );
  }
}

class const _ShimmerAnimator({
  required final String text,
  required final TextStyle style,
  required final Color baseColor,
  required final Color highlightColor,
  required final TextAlign textAlign,
}) extends StatefulWidget {
  @override
  State<_ShimmerAnimator> createState() => _ShimmerAnimatorState();
}

class _ShimmerAnimatorState() extends State<_ShimmerAnimator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, _) {
        final val = _controller.value;
        return ShaderMask(
          blendMode: .srcIn,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: .topLeft,
              end: .bottomRight,
              stops: [
                (val - 0.25).clamp(0.0, 1.0),
                val,
                (val + 0.25).clamp(0.0, 1.0),
              ],
              colors: [
                widget.baseColor,
                widget.highlightColor,
                widget.baseColor,
              ],
            ).createShader(bounds);
          },
          child: Text(
            widget.text,
            style: widget.style,
            textAlign: widget.textAlign,
          ),
        );
      },
    );
  }
}
