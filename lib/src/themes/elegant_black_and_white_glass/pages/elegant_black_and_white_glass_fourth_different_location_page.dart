import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/widgets/countdown_timers.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_invitation_theme/src/widgets/glass_effect_box.dart';
import 'package:iv_project_invitation_theme/src/widgets/maps.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';
import 'package:url_launcher/url_launcher.dart';

class ElegantBlackAndWhiteGlassFourthDifferentLocationPage extends StatelessWidget {
  const ElegantBlackAndWhiteGlassFourthDifferentLocationPage({super.key, required this.receptionEvent});

  final EventResponse receptionEvent;

  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    return BlocSelector<InvitationThemeCoreCubit, InvitationThemeCoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => Stack(
        children: [
          Positioned(
            top: 0,
            height: Screen.height,
            width: Screen.width,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: .topCenter,
                  end: .bottomCenter,
                  colors: [Colors.grey.shade900, Colors.transparent],
                  stops: const [.2, .8],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: FadeAndSlideTransition(
              slideFromOffset: .5,
              slideFrom: .top,
              child: SizedBox(
                height: H.x6l,
                width: Screen.width,
                child: Row(
                  mainAxisAlignment: .center,
                  children: [
                    Icon(Icons.celebration, size: W.xs, color: Colors.grey.shade200),
                    const SizedBox(width: 10),
                    Text(
                      langCode == 'en' ? 'Marriage Reception' : 'Resepsi Pernikahan',
                      style: AppFonts.inter(color: Colors.grey.shade200, fontSize: FontSize.x3l, fontWeight: .w700),
                    ),
                    const SizedBox(width: 10),
                    Icon(Icons.restaurant, size: W.xs, color: Colors.grey.shade200),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            height: Screen.height,
            width: Screen.width,
            child: Padding(
              padding: .only(top: H.x6l, left: W.x6s, right: W.x6s, bottom: 76),
              child: ClipRRect(
                borderRadius: .circular(20),
                child: BackdropFilter(
                  filter: .blur(sigmaX: 3, sigmaY: 3),
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: .1), borderRadius: .circular(20)),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            height: Screen.height,
            width: Screen.width,
            child: Padding(
              padding: .only(top: H.x6l, left: W.x6s, right: W.x6s, bottom: 76),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: .circular(20),
                  border: .all(width: .5, color: Colors.grey.shade500),
                ),
                child: ClipRect(
                  child: Column(
                    children: [
                      const Spacer(),
                      Column(
                        mainAxisSize: .min,
                        children: [
                          FadeAndSlideTransition(
                            slideFromOffset: .0,
                            slideFrom: .bottom,
                            delayBeforeStart: const Duration(milliseconds: 500),
                            child: Column(
                              children: [
                                Icon(Icons.event, size: 32, color: Colors.grey.shade50),
                                const SizedBox(height: 4),
                                Text(
                                  DateUtil.format(receptionEvent.startTime, .EEEEddMMMMyyyy),
                                  style: AppFonts.inter(color: Colors.grey.shade50, fontSize: FontSize.lg, fontWeight: .w500),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: H.x14s),
                          FadeAndSlideTransition(
                            slideFromOffset: .8,
                            slideFrom: .bottom,
                            animationSpeed: const Duration(milliseconds: 300),
                            delayBeforeStart: const Duration(milliseconds: 800),
                            child: Text(
                              langCode == 'en'
                                  ? '${DateUtil.format(receptionEvent.startTime, .HHmm)} o\'clock WIB - ${receptionEvent.endTime == null ? 'Finished' : '${DateUtil.format(receptionEvent.endTime!, .HHmm)} o\'clock WIB'}'
                                  : 'Pukul ${DateUtil.format(receptionEvent.startTime, .HHmm)} WIB - ${receptionEvent.endTime == null ? 'Selesai' : 'Pukul ${DateUtil.format(receptionEvent.endTime!, .HHmm)} WIB'}',
                              style: AppFonts.inter(color: Colors.grey.shade100, fontSize: FontSize.md, fontWeight: .w300),
                            ),
                          ),
                          SizedBox(height: H.x6s),
                          SizedBox(
                            height: W.x3l,
                            child: CountdownTimers(
                              time: receptionEvent.startTime,
                              animationDelayBeforeStart: const Duration(milliseconds: 800),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: H.x4s),
                      SizedBox(
                        height: .5,
                        width: W.x18l,
                        child: ColoredBox(color: Colors.grey.shade100),
                      ),
                      SizedBox(height: H.x4s),
                      FadeAndSlideTransition(
                        slideFromOffset: .0,
                        slideFrom: .top,
                        delayBeforeStart: const Duration(milliseconds: 500),
                        child: Column(
                          children: [
                            Icon(Icons.location_pin, size: 32, color: Colors.grey.shade50),
                            const SizedBox(height: 3),
                            Text(
                              receptionEvent.place,
                              style: AppFonts.inter(color: Colors.grey.shade50, fontSize: FontSize.lg, fontWeight: .w600),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: H.x10s),
                      FadeAndSlideTransition(
                        slideFromOffset: .8,
                        slideFrom: .bottom,
                        animationSpeed: const Duration(milliseconds: 300),
                        delayBeforeStart: const Duration(milliseconds: 800),
                        child: Padding(
                          padding: const .symmetric(horizontal: 20),
                          child: Text(
                            receptionEvent.address,
                            style: AppFonts.inter(
                              color: Colors.grey.shade50,
                              fontSize: FontSize.xs,
                              fontWeight: .w400,
                              height: 1.3,
                            ),
                            textAlign: .center,
                          ),
                        ),
                      ),
                      SizedBox(height: H.x6s),
                      FadeAndSlideTransition(
                        slideFrom: .bottom,
                        delayBeforeStart: const Duration(milliseconds: 1100),
                        child: Maps(
                          width: Screen.width - (W.x6s * 5),
                          height: Screen.height - (H.x18l * 2.1),
                          delayBeforeStart: const Duration(milliseconds: 2200),
                          url: receptionEvent.mapsUrl,
                        ),
                      ),
                      SizedBox(height: H.x6s),
                      FadeAndSlideTransition(
                        slideFromOffset: .8,
                        slideFrom: .bottom,
                        animationSpeed: const Duration(milliseconds: 300),
                        delayBeforeStart: const Duration(milliseconds: 1800),
                        child: GeneralEffectsButton(
                          onTap: () {
                            launchUrl(Uri.parse(receptionEvent.mapsUrl), mode: .externalNonBrowserApplication);
                          },
                          padding: const .symmetric(horizontal: 24),
                          height: W.lg + H.x10s,
                          borderRadius: .circular(30),
                          border: .all(width: .5, color: Colors.grey.shade600),
                          color: Colors.white.withValues(alpha: .2),
                          child: Stack(
                            alignment: .center,
                            children: [
                              Text(
                                langCode == 'en' ? 'Get Directions' : 'Dapatkan Petunjuk Arah',
                                style: AppFonts.inter(color: Colors.grey.shade900, fontSize: FontSize.md, fontWeight: .w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            height: Screen.height,
            width: Screen.width,
            child: Padding(
              padding: .only(top: H.x6l, left: W.x6s, right: W.x6s, bottom: 76),
              child: GlassEffectBox(
                width: Screen.width - 32,
                height: Screen.height - (76 + H.x6l),
                borderRadius: 20,
                sliderWidth: 90,
                color: Colors.white.withValues(alpha: .4),
                animationSpeed: const Duration(milliseconds: 600),
                delayBeforeStart: const Duration(milliseconds: 2700),
                animationInterval: const Duration(milliseconds: 3500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
