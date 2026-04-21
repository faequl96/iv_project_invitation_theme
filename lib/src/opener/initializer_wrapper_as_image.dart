import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/src/opener/blurry_clear_cover.dart';
import 'package:iv_project_invitation_theme/src/opener/padlock.dart';
import 'package:iv_project_invitation_theme/src/widgets/lightning_effect_box.dart';
import 'package:iv_project_model/iv_project_model.dart';

class InitializerWrapperAsImage extends StatelessWidget {
  const InitializerWrapperAsImage({super.key, required this.bride, required this.groom, required this.time});

  final BridegroomResponse bride;
  final BridegroomResponse groom;
  final EventResponse time;

  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    return SizedBox(
      height: Screen.height,
      width: Screen.width,
      child: Stack(
        alignment: .center,
        children: [
          const Positioned(left: -1.5, child: BlurryClearCover(isLeft: true)),
          const Positioned(right: -1.5, child: BlurryClearCover(isLeft: false)),

          Align(
            alignment: const Alignment(0, -.8),
            child: Stack(
              children: [
                SizedBox(
                  width: (Screen.width) - W.x9l,
                  height: W.x4l,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: .circular(60),
                      border: .all(width: .5, color: Colors.grey.shade500),
                      color: Colors.grey.shade300.withValues(alpha: .2),
                    ),
                    child: Center(
                      child: Text(
                        langCode == 'en' ? 'Wedding Invitation' : 'Undangan Pernikahan',
                        style: AppFonts.pacifico(fontSize: FontSize.x4l, fontWeight: .w700, color: Colors.grey.shade900),
                      ),
                    ),
                  ),
                ),
                LightningEffectBox(
                  width: (Screen.width) - W.x9l,
                  height: W.x4l,
                  borderRadius: 60,
                  animationSpeed: const Duration(seconds: 2),
                  ligthningColor: Colors.black,
                  staticValue: .4,
                ),
              ],
            ),
          ),
          Align(
            alignment: const Alignment(-.18, -.3),
            child: SizedBox(
              height: H.x11l,
              width: H.x11l,
              child: Center(
                child: Text(
                  bride.nickname.isNotEmpty ? bride.nickname[0] : '',
                  style: AppFonts.pacifico(fontSize: FontSize.xl + H.xl, fontWeight: .w500, color: Colors.grey.shade300),
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(.18, -.1),
            child: SizedBox(
              height: H.x11l,
              width: H.x11l,
              child: Center(
                child: Text(
                  groom.nickname.isNotEmpty ? groom.nickname[0] : '',
                  style: AppFonts.pacifico(fontSize: FontSize.xl + H.xl, fontWeight: .w500, color: Colors.grey.shade300),
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, .3),
            child: Text(
              DateUtil.format(time.startTime, .EEEEddMMMMyyyy),
              style: AppFonts.inter(fontSize: FontSize.md, color: Colors.grey.shade300, fontWeight: .w300),
            ),
          ),
          Align(
            alignment: const Alignment(0, .6),
            child: SizedBox(
              height: H.x10l,
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  Text(
                    langCode == 'en' ? 'To :' : 'Kepada :',
                    style: AppFonts.inter(fontSize: FontSize.sm, fontWeight: .w300, color: Colors.grey.shade300),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '-',
                    style: AppFonts.inter(fontSize: FontSize.md, fontWeight: .w500, color: Colors.grey.shade300),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
          ),
          Positioned(bottom: 40, child: Padlock(onOpened: () {}, noAnimate: true)),
        ],
      ),
    );
  }
}
