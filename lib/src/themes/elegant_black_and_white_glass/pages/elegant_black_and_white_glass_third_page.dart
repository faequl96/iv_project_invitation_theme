import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/widgets/countdown_timers.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_invitation_theme/src/widgets/glass_effect_box.dart';
import 'package:iv_project_model/iv_project_model.dart';

class ElegantBlackAndWhiteGlassThirdPage extends StatelessWidget {
  const ElegantBlackAndWhiteGlassThirdPage({super.key, required this.contractEvent, required this.receptionEvent});

  final EventResponse contractEvent;
  final EventResponse receptionEvent;

  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    return BlocSelector<InvitationThemeCoreCubit, InvitationThemeCoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => Stack(
        children: [
          Positioned(
            bottom: 0,
            height: Screen.height / 1.4,
            width: Screen.width,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: .topCenter,
                  end: .bottomCenter,
                  colors: [Colors.transparent, Colors.grey.shade900],
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
                    Icon(Icons.event, size: W.xs, color: Colors.grey.shade900),
                    const SizedBox(width: 10),
                    Text(
                      langCode == 'en' ? 'Weddings Event' : 'Acara Pernikahan',
                      style: AppFonts.inter(color: Colors.grey.shade900, fontSize: FontSize.x3l, fontWeight: .w700),
                    ),
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
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: .topCenter,
                        end: .bottomCenter,
                        colors: [Colors.black.withValues(alpha: .6), Colors.black.withValues(alpha: .6)],
                        stops: const [0, 1],
                      ),
                      borderRadius: .circular(20),
                    ),
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
                      const Spacer(),
                      Column(
                        mainAxisSize: .min,
                        children: [
                          FadeAndSlideTransition(
                            slideFromOffset: .0,
                            delayBeforeStart: const Duration(milliseconds: 500),
                            child: Row(
                              mainAxisSize: .min,
                              children: [
                                Icon(Icons.volunteer_activism, color: Colors.grey.shade100),
                                const SizedBox(width: 8),
                                Text(
                                  langCode == 'en' ? 'Marriage Contract' : 'Akad Nikah',
                                  style: AppFonts.inter(color: Colors.grey.shade100, fontSize: FontSize.x2l, fontWeight: .w500),
                                ),
                                const SizedBox(width: 8),
                                Icon(Icons.menu_book, color: Colors.grey.shade100),
                              ],
                            ),
                          ),
                          SizedBox(height: H.x2s),
                          FadeAndSlideTransition(
                            slideFromOffset: .8,
                            slideFrom: .bottom,
                            animationSpeed: const Duration(milliseconds: 300),
                            delayBeforeStart: const Duration(milliseconds: 800),
                            child: Column(
                              children: [
                                Text(
                                  DateUtil.format(contractEvent.startTime, .EEEEddMMMMyyyy),
                                  style: AppFonts.inter(color: Colors.grey.shade50, fontSize: FontSize.lg, fontWeight: .w500),
                                ),
                                SizedBox(height: H.x10s),
                                Text(
                                  langCode == 'en'
                                      ? '${DateUtil.format(contractEvent.startTime, .HHmm)} o\'clock WIB - ${contractEvent.endTime == null ? 'Finished' : '${DateUtil.format(contractEvent.endTime!, .HHmm)} o\'clock WIB'}'
                                      : 'Pukul ${DateUtil.format(contractEvent.startTime, .HHmm)} WIB - ${contractEvent.endTime == null ? 'Selesai' : 'Pukul ${DateUtil.format(contractEvent.endTime!, .HHmm)} WIB'}',
                                  style: AppFonts.inter(color: Colors.grey.shade100, fontSize: FontSize.md, fontWeight: .w300),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: H.md),
                          SizedBox(
                            height: W.x3l,
                            child: CountdownTimers(
                              time: contractEvent.startTime,
                              animationDelayBeforeStart: const Duration(milliseconds: 800),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      FadeAndSlideTransition(
                        slideFromOffset: .0,
                        delayBeforeStart: const Duration(milliseconds: 1400),
                        child: SizedBox(
                          height: .5,
                          width: W.x18l,
                          child: ColoredBox(color: Colors.grey.shade100),
                        ),
                      ),
                      const Spacer(),
                      Column(
                        mainAxisSize: .min,
                        children: [
                          FadeAndSlideTransition(
                            slideFromOffset: .0,
                            delayBeforeStart: const Duration(milliseconds: 500),
                            child: Row(
                              mainAxisSize: .min,
                              children: [
                                Icon(Icons.celebration, color: Colors.grey.shade100),
                                const SizedBox(width: 8),
                                Text(
                                  langCode == 'en' ? 'Marriage Reception' : 'Resepsi Pernikahan',
                                  style: AppFonts.inter(color: Colors.grey.shade100, fontSize: FontSize.x2l, fontWeight: .w500),
                                ),
                                const SizedBox(width: 8),
                                Icon(Icons.restaurant, color: Colors.grey.shade100),
                              ],
                            ),
                          ),
                          SizedBox(height: H.x2s),
                          FadeAndSlideTransition(
                            slideFromOffset: .8,
                            slideFrom: .bottom,
                            animationSpeed: const Duration(milliseconds: 300),
                            delayBeforeStart: const Duration(milliseconds: 800),
                            child: Column(
                              children: [
                                Text(
                                  DateUtil.format(receptionEvent.startTime, .EEEEddMMMMyyyy),
                                  style: AppFonts.inter(color: Colors.grey.shade50, fontSize: FontSize.lg, fontWeight: .w500),
                                ),
                                SizedBox(height: H.x10s),
                                Text(
                                  langCode == 'en'
                                      ? '${DateUtil.format(receptionEvent.startTime, .HHmm)} o\'clock WIB - ${receptionEvent.endTime == null ? 'Finished' : '${DateUtil.format(receptionEvent.endTime!, .HHmm)} o\'clock WIB'}'
                                      : 'Pukul ${DateUtil.format(receptionEvent.startTime, .HHmm)} WIB - ${receptionEvent.endTime == null ? 'Selesai' : 'Pukul ${DateUtil.format(receptionEvent.endTime!, .HHmm)} WIB'}',
                                  style: AppFonts.inter(color: Colors.grey.shade100, fontSize: FontSize.md, fontWeight: .w300),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: H.md),
                          SizedBox(
                            height: W.x3l,
                            child: CountdownTimers(
                              time: receptionEvent.startTime,
                              animationDelayBeforeStart: const Duration(milliseconds: 800),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
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
                color: Colors.grey.shade300.withValues(alpha: .3),
                animationSpeed: const Duration(milliseconds: 600),
                delayBeforeStart: const Duration(milliseconds: 3500),
                animationInterval: const Duration(seconds: 4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
