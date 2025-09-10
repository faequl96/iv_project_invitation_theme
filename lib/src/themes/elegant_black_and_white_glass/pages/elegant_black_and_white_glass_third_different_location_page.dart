import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/core/app_fonts.dart';
import 'package:iv_project_invitation_theme/src/core/utils/date_util.dart';
import 'package:iv_project_invitation_theme/src/core/utils/font_scale.dart';
import 'package:iv_project_invitation_theme/src/core/utils/screen_util.dart';
import 'package:iv_project_invitation_theme/src/core/utils/size_scale.dart';
import 'package:iv_project_invitation_theme/src/widgets/countdown_timers.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_invitation_theme/src/widgets/glass_effect_box.dart';
import 'package:iv_project_invitation_theme/src/widgets/maps.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';
import 'package:url_launcher/url_launcher.dart';

class ElegantBlackAndWhiteGlassThirdDifferentLocationPage extends StatelessWidget {
  const ElegantBlackAndWhiteGlassThirdDifferentLocationPage({super.key, required this.contractEvent});

  final EventResponse contractEvent;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CoreCubit, CoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => Stack(
        children: [
          Positioned(
            bottom: 0,
            height: ScreenUtil.size.height / 1.2,
            width: ScreenUtil.size.width,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
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
              slideFrom: SlideFrom.top,
              child: SizedBox(
                height: SizeScale.heightX6l,
                width: ScreenUtil.size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.volunteer_activism, size: SizeScale.widthXs, color: Colors.grey.shade900),
                    const SizedBox(width: 10),
                    Text(
                      'Akad Nikah',
                      style: AppFonts.inter(color: Colors.grey.shade900, fontSize: FontScale.x3l, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(width: 10),
                    Icon(Icons.menu_book, size: SizeScale.widthXs, color: Colors.grey.shade900),
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
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black.withValues(alpha: .6), Colors.black.withValues(alpha: .6)],
                        stops: const [0, 1],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
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
                                  DateUtil.format(contractEvent.startTime, DateFormatPattern.EEEEddMMMMyyyy),
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
                              'Pukul ${DateUtil.format(contractEvent.startTime, DateFormatPattern.hhmm)} WIB - ${contractEvent.endTime == null ? 'Selesai' : 'Pukul ${DateUtil.format(contractEvent.endTime!, DateFormatPattern.hhmm)} WIB'}',
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
                              time: contractEvent.startTime,
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
                              contractEvent.place,
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
                            contractEvent.address,
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
                          url: contractEvent.mapsUrl,
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
                            launchUrl(Uri.parse(contractEvent.mapsUrl), mode: LaunchMode.externalNonBrowserApplication);
                          },
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          height: SizeScale.widthLg + SizeScale.heightX10s,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(width: .5, color: Colors.grey.shade600),
                          color: Colors.grey.shade500.withValues(alpha: .3),
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Text(
                                'Dapatkan Petunjuk Arah',
                                style: AppFonts.inter(
                                  color: Colors.grey.shade100,
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
