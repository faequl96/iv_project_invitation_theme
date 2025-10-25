import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/core/app_fonts.dart';
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
    return BlocSelector<InvitationThemeCoreCubit, InvitationThemeCoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => Stack(
        children: [
          Positioned(
            top: 0,
            height: ScreenUtil.size.height,
            width: ScreenUtil.size.width,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
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
              slideFrom: SlideFrom.top,
              child: SizedBox(
                height: SizeScale.heightX6l,
                width: ScreenUtil.size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.celebration, size: SizeScale.widthXs, color: Colors.grey.shade200),
                    const SizedBox(width: 10),
                    Text(
                      'Resepsi',
                      style: AppFonts.inter(color: Colors.grey.shade200, fontSize: FontScale.x3l, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(width: 10),
                    Icon(Icons.restaurant, size: SizeScale.widthXs, color: Colors.grey.shade200),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            height: ScreenUtil.size.height,
            width: ScreenUtil.size.width,
            child: Padding(
              padding: EdgeInsets.only(top: SizeScale.heightX6l, left: SizeScale.widthX6s, right: SizeScale.widthX6s, bottom: 76),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: .1), borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            height: ScreenUtil.size.height,
            width: ScreenUtil.size.width,
            child: Padding(
              padding: EdgeInsets.only(top: SizeScale.heightX6l, left: SizeScale.widthX6s, right: SizeScale.widthX6s, bottom: 76),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: .5, color: Colors.grey.shade500),
                ),
                child: ClipRect(
                  child: Column(
                    children: [
                      const Spacer(),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FadeAndSlideTransition(
                            slideFromOffset: .0,
                            slideFrom: SlideFrom.bottom,
                            delayBeforeStart: const Duration(milliseconds: 500),
                            child: Column(
                              children: [
                                Icon(Icons.event, size: 32, color: Colors.grey.shade50),
                                const SizedBox(height: 4),
                                Text(
                                  DateUtil.format(receptionEvent.startTime, DateFormatPattern.EEEEddMMMMyyyy),
                                  style: AppFonts.inter(
                                    color: Colors.grey.shade50,
                                    fontSize: FontScale.lg,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: SizeScale.heightX14s),
                          FadeAndSlideTransition(
                            slideFromOffset: .8,
                            slideFrom: SlideFrom.bottom,
                            animationSpeed: const Duration(milliseconds: 300),
                            delayBeforeStart: const Duration(milliseconds: 800),
                            child: Text(
                              'Pukul ${DateUtil.format(receptionEvent.startTime, DateFormatPattern.HHmm)} WIB - ${receptionEvent.endTime == null ? 'Selesai' : 'Pukul ${DateUtil.format(receptionEvent.endTime!, DateFormatPattern.HHmm)} WIB'}',
                              style: AppFonts.inter(
                                color: Colors.grey.shade100,
                                fontSize: FontScale.md,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          SizedBox(height: SizeScale.heightX6s),
                          SizedBox(
                            height: SizeScale.widthX3l,
                            child: CountdownTimers(
                              time: receptionEvent.startTime,
                              animationDelayBeforeStart: const Duration(milliseconds: 800),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: SizeScale.heightX4s),
                      SizedBox(
                        height: .5,
                        width: SizeScale.widthX18l,
                        child: ColoredBox(color: Colors.grey.shade100),
                      ),
                      SizedBox(height: SizeScale.heightX4s),
                      FadeAndSlideTransition(
                        slideFromOffset: .0,
                        slideFrom: SlideFrom.top,
                        delayBeforeStart: const Duration(milliseconds: 500),
                        child: Column(
                          children: [
                            Icon(Icons.location_pin, size: 32, color: Colors.grey.shade50),
                            const SizedBox(height: 3),
                            Text(
                              receptionEvent.place,
                              style: AppFonts.inter(
                                color: Colors.grey.shade50,
                                fontSize: FontScale.lg,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: SizeScale.heightX10s),
                      FadeAndSlideTransition(
                        slideFromOffset: .8,
                        slideFrom: SlideFrom.bottom,
                        animationSpeed: const Duration(milliseconds: 300),
                        delayBeforeStart: const Duration(milliseconds: 800),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            receptionEvent.address,
                            style: AppFonts.inter(
                              color: Colors.grey.shade50,
                              fontSize: FontScale.xs,
                              fontWeight: FontWeight.w400,
                              height: 1.3,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(height: SizeScale.heightX6s),
                      FadeAndSlideTransition(
                        slideFrom: SlideFrom.bottom,
                        delayBeforeStart: const Duration(milliseconds: 1100),
                        child: Maps(
                          width: ScreenUtil.size.width - (SizeScale.widthX6s * 5),
                          height: ScreenUtil.size.height - (SizeScale.heightX18l * 2.1),
                          delayBeforeStart: const Duration(milliseconds: 2200),
                          url: receptionEvent.mapsUrl,
                        ),
                      ),
                      SizedBox(height: SizeScale.heightX6s),
                      FadeAndSlideTransition(
                        slideFromOffset: .8,
                        slideFrom: SlideFrom.bottom,
                        animationSpeed: const Duration(milliseconds: 300),
                        delayBeforeStart: const Duration(milliseconds: 1800),
                        child: GeneralEffectsButton(
                          onTap: () {
                            launchUrl(Uri.parse(receptionEvent.mapsUrl), mode: LaunchMode.externalNonBrowserApplication);
                          },
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          height: SizeScale.widthLg + SizeScale.heightX10s,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(width: .5, color: Colors.grey.shade600),
                          color: Colors.white.withValues(alpha: .2),
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Text(
                                'Dapatkan Petunjuk Arah',
                                style: AppFonts.inter(
                                  color: Colors.grey.shade900,
                                  fontSize: FontScale.md,
                                  fontWeight: FontWeight.w600,
                                ),
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
            height: ScreenUtil.size.height,
            width: ScreenUtil.size.width,
            child: Padding(
              padding: EdgeInsets.only(top: SizeScale.heightX6l, left: SizeScale.widthX6s, right: SizeScale.widthX6s, bottom: 76),
              child: GlassEffectBox(
                width: ScreenUtil.size.width - 32,
                height: ScreenUtil.size.height - (76 + SizeScale.heightX6l),
                borderRadius: 20,
                sliderWidth: 90,
                color: Colors.white.withValues(alpha: .5),
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
