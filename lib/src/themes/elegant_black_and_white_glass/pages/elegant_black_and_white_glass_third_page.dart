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
import 'package:iv_project_model/iv_project_model.dart';

class ElegantBlackAndWhiteGlassThirdPage extends StatelessWidget {
  const ElegantBlackAndWhiteGlassThirdPage({super.key, required this.contractEvent, required this.receptionEvent});

  final EventResponse contractEvent;
  final EventResponse receptionEvent;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CoreCubit, CoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => Stack(
        children: [
          Positioned(
            bottom: 0,
            height: ScreenUtil.size.height / 1.4,
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
                    Icon(Icons.event, size: SizeScale.widthXs, color: Colors.grey.shade900),
                    const SizedBox(width: 10),
                    Text(
                      'Acara Pernikahan',
                      style: AppFonts.inter(color: Colors.grey.shade900, fontSize: FontScale.x3l, fontWeight: FontWeight.w700),
                    ),
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
                      const Spacer(),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FadeAndSlideTransition(
                            slideFromOffset: .0,
                            delayBeforeStart: const Duration(milliseconds: 500),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.volunteer_activism, color: Colors.grey.shade100),
                                const SizedBox(width: 8),
                                Text(
                                  'Akad Nikah',
                                  style: AppFonts.inter(
                                    color: Colors.grey.shade100,
                                    fontSize: FontScale.x2l,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(Icons.menu_book, color: Colors.grey.shade100),
                              ],
                            ),
                          ),
                          SizedBox(height: SizeScale.heightX2s),
                          FadeAndSlideTransition(
                            slideFromOffset: .8,
                            slideFrom: SlideFrom.bottom,
                            animationSpeed: const Duration(milliseconds: 300),
                            delayBeforeStart: const Duration(milliseconds: 800),
                            child: Column(
                              children: [
                                Text(
                                  DateUtil.format(contractEvent.startTime, DateFormatPattern.EEEEddMMMMyyyy),
                                  style: AppFonts.inter(
                                    color: Colors.grey.shade50,
                                    fontSize: FontScale.lg,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: SizeScale.heightX10s),
                                Text(
                                  'Pukul ${DateUtil.format(contractEvent.startTime, DateFormatPattern.hhmm)} WIB - ${contractEvent.finishTime == null ? 'Selesai' : 'Pukul ${DateUtil.format(contractEvent.finishTime!, DateFormatPattern.hhmm)} WIB'}',
                                  style: AppFonts.inter(
                                    color: Colors.grey.shade100,
                                    fontSize: FontScale.md,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: SizeScale.heightMd),
                          SizedBox(
                            height: SizeScale.widthX3l,
                            child: CountdownTimers(
                              time: contractEvent.startTime,
                              animationDelayBeforeStart: const Duration(milliseconds: 800),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      SizedBox(
                        height: .5,
                        width: SizeScale.widthX18l,
                        child: ColoredBox(color: Colors.grey.shade100),
                      ),
                      const Spacer(),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FadeAndSlideTransition(
                            slideFromOffset: .0,
                            delayBeforeStart: const Duration(milliseconds: 500),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.celebration, color: Colors.grey.shade100),
                                const SizedBox(width: 8),
                                Text(
                                  'Resepsi',
                                  style: AppFonts.inter(
                                    color: Colors.grey.shade100,
                                    fontSize: FontScale.x2l,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(Icons.restaurant, color: Colors.grey.shade100),
                              ],
                            ),
                          ),
                          SizedBox(height: SizeScale.heightX2s),
                          FadeAndSlideTransition(
                            slideFromOffset: .8,
                            slideFrom: SlideFrom.bottom,
                            animationSpeed: const Duration(milliseconds: 300),
                            delayBeforeStart: const Duration(milliseconds: 800),
                            child: Column(
                              children: [
                                Text(
                                  DateUtil.format(receptionEvent.startTime, DateFormatPattern.EEEEddMMMMyyyy),
                                  style: AppFonts.inter(
                                    color: Colors.grey.shade50,
                                    fontSize: FontScale.lg,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: SizeScale.heightX10s),
                                Text(
                                  'Pukul ${DateUtil.format(receptionEvent.startTime, DateFormatPattern.hhmm)} WIB - ${receptionEvent.finishTime == null ? 'Selesai' : 'Pukul ${DateUtil.format(receptionEvent.finishTime!, DateFormatPattern.hhmm)} WIB'}',
                                  style: AppFonts.inter(
                                    color: Colors.grey.shade100,
                                    fontSize: FontScale.md,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: SizeScale.heightMd),
                          SizedBox(
                            height: SizeScale.widthX3l,
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
