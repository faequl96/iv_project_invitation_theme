import 'package:flutter/material.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_model/iv_project_model.dart';

class BridegroomName extends StatelessWidget {
  const BridegroomName({
    super.key,
    required this.brideNameColor,
    required this.groomNameColor,
    required this.bride,
    required this.groom,
    required this.noAnimate,
  });

  final Color brideNameColor;
  final Color groomNameColor;
  final BridegroomResponse bride;
  final BridegroomResponse groom;
  final bool noAnimate;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (!noAnimate) ...[
          Align(
            alignment: const Alignment(0, 0),
            child: FadeAndSlideTransition(
              slideFromOffset: .3,
              slideFrom: .left,
              animationSpeed: const Duration(milliseconds: 500),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: bride.nickname,
                      style: TextStyle(fontSize: FontSize.x8l, color: brideNameColor),
                    ),
                    TextSpan(
                      text: ' & ',
                      style: TextStyle(fontSize: FontSize.x4l, color: Colors.transparent),
                    ),
                    TextSpan(
                      text: groom.nickname,
                      style: TextStyle(fontSize: FontSize.x8l, color: Colors.transparent),
                    ),
                  ],
                ),
                style: AppFonts.pacifico(fontSize: FontSize.x8l, height: 1.1),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, 0),
            child: FadeAndSlideTransition(
              slideFromOffset: 0,
              delayBeforeStart: const Duration(milliseconds: 300),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: bride.nickname,
                      style: TextStyle(fontSize: FontSize.x8l, color: Colors.transparent),
                    ),
                    TextSpan(
                      text: ' & ',
                      style: TextStyle(fontSize: FontSize.x4l, color: Colors.grey.shade300),
                    ),
                    TextSpan(
                      text: groom.nickname,
                      style: TextStyle(fontSize: FontSize.x8l, color: Colors.transparent),
                    ),
                  ],
                ),
                style: AppFonts.pacifico(fontSize: FontSize.x8l, height: 1.1),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, 0),
            child: FadeAndSlideTransition(
              slideFromOffset: .3,
              slideFrom: .right,
              animationSpeed: const Duration(milliseconds: 500),
              delayBeforeStart: const Duration(milliseconds: 400),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: bride.nickname,
                      style: TextStyle(fontSize: FontSize.x8l, color: Colors.transparent),
                    ),
                    TextSpan(
                      text: ' & ',
                      style: TextStyle(fontSize: FontSize.x4l, color: Colors.transparent),
                    ),
                    TextSpan(
                      text: groom.nickname,
                      style: TextStyle(fontSize: FontSize.x8l, color: groomNameColor),
                    ),
                  ],
                ),
                style: AppFonts.pacifico(fontSize: FontSize.x8l, height: 1.1),
              ),
            ),
          ),
        ] else
          Align(
            alignment: const Alignment(0, 0),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: bride.nickname,
                    style: TextStyle(fontSize: FontSize.x8l, color: brideNameColor),
                  ),
                  TextSpan(
                    text: ' & ',
                    style: TextStyle(fontSize: FontSize.x4l, color: Colors.transparent),
                  ),
                  TextSpan(
                    text: groom.nickname,
                    style: TextStyle(fontSize: FontSize.x8l, color: groomNameColor),
                  ),
                ],
              ),
              style: AppFonts.pacifico(fontSize: FontSize.x8l, height: 1.1),
            ),
          ),
      ],
    );
  }
}
