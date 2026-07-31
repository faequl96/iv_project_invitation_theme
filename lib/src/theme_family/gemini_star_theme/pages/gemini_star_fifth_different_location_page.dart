import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/gemini_star_configs.dart';
import 'package:iv_project_invitation_theme/src/widgets/countdown_timers_grid.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_invitation_theme/src/widgets/maps.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';
import 'package:url_launcher/url_launcher.dart';

class GeminiStarFifthDifferentLocationPage extends StatelessWidget {
  const GeminiStarFifthDifferentLocationPage({
    super.key,
    required this.config,
    required this.receptionEvent,
  });

  final GeminiStarFifthDifferentLocationPageConfig config;
  final EventResponse receptionEvent;

  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    return BlocSelector<InvitationThemeCoreCubit, InvitationThemeCoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => Stack(
        alignment: .center,
        children: [
          if (config.firstGradientBackgroundColor != null &&
              config.secondGradientBackgroundColor != null)
            Positioned(
              bottom: 0,
              height: Screen.height,
              width: Screen.width,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: .topCenter,
                    end: .bottomCenter,
                    colors: [
                      config.firstGradientBackgroundColor!,
                      config.secondGradientBackgroundColor!,
                    ],
                    stops: const [.2, .8],
                  ),
                ),
              ),
            ),

          Positioned(
            left: (-Screen.height / 2) + W.sm / 2,
            child: Transform.rotate(angle: -(pi / 2), child: _buildTitle(langCode)),
          ),

          Positioned(
            right: (-Screen.height / 2) + W.sm / 2,
            child: Transform.rotate(angle: (pi / 2), child: _buildTitle(langCode, isRight: true)),
          ),

          Positioned(
            bottom: 0,
            height: Screen.height,
            width: Screen.width,
            child: Padding(
              padding: .symmetric(horizontal: W.sm),
              child: Column(
                children: [
                  SizedBox(
                    height: H.x20l + H.md,
                    child: Column(
                      children: [
                        const Spacer(flex: 2),
                        Column(
                          mainAxisSize: .min,
                          children: [
                            FadeAndSlideTransition(
                              slideFromOffset: .0,
                              slideFrom: .bottom,
                              child: Column(
                                children: [
                                  Icon(Icons.event, size: 32, color: config.dateTimeIconColor),
                                  const SizedBox(height: 4),
                                  Text(
                                    DateUtil.format(receptionEvent.startTime, .EEEEddMMMMyyyy),
                                    style: AppFonts.inter(
                                      color: config.dateTimeBaseTextColor,
                                      fontSize: FontSize.xl,
                                      fontWeight: .w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: H.x10s),
                            FadeAndSlideTransition(
                              slideFromOffset: .8,
                              slideFrom: .bottom,
                              animationSpeed: const Duration(milliseconds: 300),
                              delayBeforeStart: const Duration(milliseconds: 300),
                              child: Text(
                                langCode == 'en'
                                    ? '${DateUtil.format(receptionEvent.startTime, .HHmm)} o\'clock WIB - ${receptionEvent.endTime == null ? 'Finished' : '${DateUtil.format(receptionEvent.endTime!, .HHmm)} o\'clock WIB'}'
                                    : 'Pukul ${DateUtil.format(receptionEvent.startTime, .HHmm)} WIB - ${receptionEvent.endTime == null ? 'Selesai' : 'Pukul ${DateUtil.format(receptionEvent.endTime!, .HHmm)} WIB'}',
                                style: AppFonts.inter(
                                  color: config.dateTimeBaseTextColor,
                                  fontSize: FontSize.md,
                                  fontWeight: .w400,
                                ),
                              ),
                            ),
                            SizedBox(height: H.x6s),
                            SizedBox(
                              height: (W.x3l * 2) + W.x14s,
                              child: CountdownTimersGrid(
                                paddingHorizontal: W.x5s,
                                oddColor: config.countdownOddColor,
                                evenColor: config.countdownEvenColor,
                                oddBorderColor: config.countdownOddBorderColor,
                                evenBorderColor: config.countdownEvenBorderColor,
                                numberColor: config.countdownNumberColor,
                                unitColor: config.countdownUnitColor,
                                borderWidth: config.countdownBorderWidth,
                                time: receptionEvent.startTime,
                                animationDelayBeforeStart: const Duration(milliseconds: 300),
                                noAnimate: false,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        FadeAndSlideTransition(
                          slideFromOffset: .0,
                          slideFrom: .top,
                          child: Column(
                            children: [
                              Icon(Icons.location_pin, size: 32, color: config.placeIconColor),
                              const SizedBox(height: 3),
                              Text(
                                receptionEvent.place,
                                style: AppFonts.inter(
                                  color: config.placeBaseTextColor,
                                  fontSize: FontSize.xl,
                                  fontWeight: .w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: H.x10s),
                        FadeAndSlideTransition(
                          slideFromOffset: .8,
                          slideFrom: .bottom,
                          animationSpeed: const Duration(milliseconds: 300),
                          delayBeforeStart: const Duration(milliseconds: 300),
                          child: Padding(
                            padding: const .symmetric(horizontal: 20),
                            child: Text(
                              receptionEvent.address,
                              style: AppFonts.inter(
                                color: config.addressTextColor,
                                fontSize: FontSize.xs,
                                fontWeight: .w400,
                                height: 1.3,
                              ),
                              textAlign: .center,
                            ),
                          ),
                        ),
                        SizedBox(height: H.x4s),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Maps(
                      useBorder: false,
                      borderColor: config.mapsBorderColor,
                      width: .infinity,
                      height: .infinity,
                      delayBeforeStart: const Duration(milliseconds: 2200),
                      url: receptionEvent.mapsUrl,
                    ),
                  ),
                  SizedBox(
                    height: H.x12l - H.x3s,
                    child: Column(
                      children: [
                        SizedBox(height: H.x2s),
                        FadeAndSlideTransition(
                          slideFromOffset: .8,
                          slideFrom: .bottom,
                          animationSpeed: const Duration(milliseconds: 300),
                          delayBeforeStart: const Duration(milliseconds: 1800),
                          child: QuickButton(
                            onTap: () => launchUrl(
                              Uri.parse(receptionEvent.mapsUrl),
                              mode: .externalNonBrowserApplication,
                            ),
                            style: QuickButtonStyle(
                              padding: const .symmetric(horizontal: 24),
                              height: W.lg + H.x10s,
                              borderRadius: .circular(30),
                              border: .all(
                                width: config.getDirectionsButtonBorderWidth,
                                color: config.getDirectionsButtonBorderColor,
                              ),
                              color: config.getDirectionsButtonColor,
                              elevation: 0,
                            ),
                            child: Stack(
                              alignment: .center,
                              children: [
                                Text(
                                  langCode == 'en' ? 'Get Directions' : 'Dapatkan Petunjuk Arah',
                                  style: AppFonts.inter(
                                    color: config.getDirectionsButtonLabelColor,
                                    fontSize: FontSize.md,
                                    fontWeight: .w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (config.decorationBuilder != null)
            SizedBox(
              height: Screen.height,
              width: Screen.width,
              child: config.decorationBuilder!(),
            ),
        ],
      ),
    );
  }

  Widget _buildTitle(String langCode, {bool isRight = false}) => SizedBox(
    height: W.sm,
    width: Screen.height,
    child: ColoredBox(
      color: Colors.black54,
      child: Row(
        children: [
          if (!isRight) ...[SizedBox(width: H.x12l - H.x3s), const Spacer()],
          SizedBox(
            width: H.x20l + H.md,
            child: Row(
              children: [
                if (isRight) const Spacer(),
                if (!isRight) SizedBox(width: H.x2s),
                Column(
                  mainAxisAlignment: .center,
                  children: [
                    FadeAndSlideTransition(
                      slideFromOffset: 1.5,
                      slideFrom: isRight ? .left : .right,
                      child: Text(
                        langCode == 'en' ? 'Marriage Reception' : 'Resepsi Nikah',
                        style: AppFonts.inter(
                          color: config.titlePageColor,
                          fontSize: FontSize.x3l,
                          fontWeight: .w700,
                        ),
                      ),
                    ),
                    if (!isRight) const SizedBox(height: 2),
                  ],
                ),
                if (isRight) SizedBox(width: H.x2s),
                if (!isRight) const Spacer(),
              ],
            ),
          ),
          if (isRight) ...[SizedBox(width: H.x12l - H.x3s), const Spacer()],
        ],
      ),
    ),
  );
}
