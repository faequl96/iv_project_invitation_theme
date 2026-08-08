import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/gemini_star_configs.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_invitation_theme/src/widgets/maps.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';
import 'package:url_launcher/url_launcher.dart';

class GeminiStarFifthPage extends StatelessWidget {
  const GeminiStarFifthPage({super.key, required this.config, required this.receptionEvent});

  final GeminiStarFifthPageConfig config;
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
              top: 0,
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
            child: Column(
              children: [
                SizedBox(
                  height: H.x17l,
                  child: Column(
                    mainAxisAlignment: .center,
                    children: [
                      FadeAndSlideTransition(
                        slideFromOffset: .0,
                        slideFrom: .top,
                        delayBeforeStart: const Duration(milliseconds: 200),
                        child: _buildPlace(),
                      ),
                      const SizedBox(height: 8),
                      FadeAndSlideTransition(
                        slideFromOffset: .8,
                        slideFrom: .bottom,
                        animationSpeed: const Duration(milliseconds: 300),
                        delayBeforeStart: const Duration(milliseconds: 400),
                        child: _buildAddress(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: .symmetric(horizontal: W.sm),
                    child: Maps(
                      useBorder: false,
                      borderColor: Colors.transparent,
                      width: .infinity,
                      height: .infinity,
                      delayBeforeStart: const Duration(milliseconds: 1000),
                      url: receptionEvent.mapsUrl,
                    ),
                  ),
                ),
                SizedBox(
                  height: H.x15l,
                  child: Center(
                    child: FadeAndSlideTransition(
                      slideFromOffset: .8,
                      slideFrom: .bottom,
                      animationSpeed: const Duration(milliseconds: 300),
                      delayBeforeStart: const Duration(milliseconds: 1000),
                      child: _buildGetDirection(langCode),
                    ),
                  ),
                ),
              ],
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
      color: Colors.black12,
      child: Row(
        children: [
          SizedBox(width: isRight ? H.x17l : H.x15l),
          Expanded(
            child: SizedBox(
              height: W.sm,
              child: const ColoredBox(color: Colors.black12),
            ),
          ),
          SizedBox(
            width: isRight ? H.x15l : H.x17l,
            child: Row(
              children: [
                SizedBox(width: H.x2s),
                Column(
                  mainAxisAlignment: .center,
                  children: [
                    FadeAndSlideTransition(
                      slideFromOffset: 1.5,
                      slideFrom: .right,
                      child: Text(
                        langCode == 'en' ? 'Event Location' : 'Lokasi Acara',
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
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget _buildPlace() => Column(
    children: [
      Icon(Icons.maps_home_work_rounded, size: 32, color: config.placeIconColor),
      const SizedBox(height: 4),
      Text(
        receptionEvent.place,
        style: AppFonts.inter(
          color: config.placeTextColor,
          fontSize: FontSize.xl,
          fontWeight: .w600,
        ),
      ),
    ],
  );

  Widget _buildAddress() => Padding(
    padding: const .symmetric(horizontal: 20),
    child: Text(
      receptionEvent.address,
      style: AppFonts.inter(
        color: config.addressTextColor,
        fontSize: FontSize.xs,
        fontWeight: .w400,
      ),
      textAlign: .center,
    ),
  );

  Widget _buildGetDirection(String langCode) => QuickButton(
    onTap: () {
      launchUrl(Uri.parse(receptionEvent.mapsUrl), mode: .externalNonBrowserApplication);
    },
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
  );
}
