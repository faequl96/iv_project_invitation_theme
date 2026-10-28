import 'dart:ui';
import 'package:flutter/material.dart';

class const ElysianGlassCard({
  super.key,
  required final Widget child,
  final EdgeInsetsGeometry padding = const .all(20),
  final EdgeInsetsGeometry margin = .zero,
  final double borderRadius = 20,
  final Color backgroundColor = const Color(0x2AFFFFFF),
  final Color borderColor = const Color(0x66D4AF37),
  final double blurAmount = 14,
  final double borderWidth = 1.2,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: ClipRRect(
        borderRadius: .circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurAmount, sigmaY: blurAmount),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: .circular(borderRadius),
              border: Border.all(
                color: borderColor,
                width: borderWidth,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .25),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
                BoxShadow(
                  color: borderColor.withValues(alpha: .15),
                  blurRadius: 16,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
