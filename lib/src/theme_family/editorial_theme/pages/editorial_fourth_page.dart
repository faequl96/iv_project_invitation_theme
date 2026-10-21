import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/editorial_theme/editorial_configs.dart';
import 'package:iv_project_invitation_theme/src/widgets/countdown_timers_grid.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_model/iv_project_model.dart';

class const EditorialFourthPage({
  super.key,
  required final EditorialFourthPageConfig config,
  required final EventResponse contractEvent,
  required final EventResponse receptionEvent,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    return BlocSelector<InvitationThemeCoreCubit, InvitationThemeCoreState, Size>(
      selector: (state) => state.size,
      builder: (_, size) => Container(
        height: size.height,
        width: size.width,
        color: config.backgroundColor,
        padding: const .symmetric(horizontal: 20, vertical: 32),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            FadeAndSlideTransition(
              slideFrom: .top,
              slideFromOffset: .3,
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(
                    langCode == 'en' ? 'ITINERARY' : 'RANGKAIAN ACARA',
                    style: TextStyle(
                      color: config.sectionHeaderColor,
                      fontSize: 11,
                      fontWeight: .bold,
                      letterSpacing: 2,
                    ),
                  ),
                  Text(
                    'WEDDING SCHEDULE',
                    style: TextStyle(
                      color: config.eventDetailColor,
                      fontSize: 10,
                      fontWeight: .w600,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FadeAndSlideTransition(
                slideFrom: .bottom,
                slideFromOffset: .2,
                child: Container(
                  width: double.infinity,
                  padding: const .all(20),
                  decoration: BoxDecoration(
                    color: config.cardBackgroundColor,
                    borderRadius: .circular(4),
                    border: .all(color: config.borderColor),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: .start,
                    mainAxisAlignment: .center,
                    children: [
                      Container(
                        padding: const .symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: config.badgeBgColor,
                          borderRadius: .circular(2),
                        ),
                        child: Text(
                          langCode == 'en' ? 'HOLY MATRIMONY / AKAD' : 'AKAD NIKAH',
                          style: TextStyle(
                            color: config.badgeTextColor,
                            fontSize: 11,
                            fontWeight: .bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        DateUtil.format(contractEvent.startTime, .EEEEddMMMMyyyy),
                        style: TextStyle(
                          color: config.eventTitleColor,
                          fontSize: 18,
                          fontWeight: .w800,
                          fontFamily: 'serif',
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        langCode == 'en'
                            ? '${DateUtil.format(contractEvent.startTime, .HHmm)} o\'clock WIB - ${contractEvent.endTime == null ? 'Finished' : '${DateUtil.format(contractEvent.endTime!, .HHmm)} o\'clock WIB'}'
                            : 'Pukul ${DateUtil.format(contractEvent.startTime, .HHmm)} WIB - ${contractEvent.endTime == null ? 'Selesai' : 'Pukul ${DateUtil.format(contractEvent.endTime!, .HHmm)} WIB'}',
                        style: TextStyle(
                          color: config.eventDetailColor,
                          fontSize: 13,
                          fontWeight: .w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: W.x15s),
            FadeAndSlideTransition(
              slideFrom: .bottom,
              slideFromOffset: .3,
              child: CountdownTimersGrid(
                paddingHorizontal: 0,
                time: contractEvent.startTime,
                borderWidth: 1,
                oddBorderColor: config.countdownBorderColor,
                evenBorderColor: config.countdownBorderColor,
                numberColor: config.countdownTextColor,
                unitColor: config.countdownLabelColor,
                oddColor: config.countdownBgColor,
                evenColor: config.countdownBgColor,
                noAnimate: false,
                topLeftBorderRadius: .circular(4),
                topRightBorderRadius: .circular(4),
                bottomLeftBorderRadius: .circular(4),
                bottomRightBorderRadius: .circular(4),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FadeAndSlideTransition(
                slideFrom: .bottom,
                slideFromOffset: .3,
                child: Container(
                  width: double.infinity,
                  padding: const .all(20),
                  decoration: BoxDecoration(
                    color: config.cardBackgroundColor,
                    borderRadius: .circular(4),
                    border: .all(color: config.borderColor),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: .start,
                    mainAxisAlignment: .center,
                    children: [
                      Container(
                        padding: const .symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: config.badgeBgColor,
                          borderRadius: .circular(2),
                        ),
                        child: Text(
                          langCode == 'en' ? 'WEDDING RECEPTION' : 'RESEPSI PERNIKAHAN',
                          style: TextStyle(
                            color: config.badgeTextColor,
                            fontSize: 11,
                            fontWeight: .bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        DateUtil.format(receptionEvent.startTime, .EEEEddMMMMyyyy),
                        style: TextStyle(
                          color: config.eventTitleColor,
                          fontSize: 18,
                          fontWeight: .w800,
                          fontFamily: 'serif',
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        langCode == 'en'
                            ? '${DateUtil.format(receptionEvent.startTime, .HHmm)} o\'clock WIB - ${receptionEvent.endTime == null ? 'Finished' : '${DateUtil.format(receptionEvent.endTime!, .HHmm)} o\'clock WIB'}'
                            : 'Pukul ${DateUtil.format(receptionEvent.startTime, .HHmm)} WIB - ${receptionEvent.endTime == null ? 'Selesai' : 'Pukul ${DateUtil.format(receptionEvent.endTime!, .HHmm)} WIB'}',
                        style: TextStyle(
                          color: config.eventDetailColor,
                          fontSize: 13,
                          fontWeight: .w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: W.x15s),
            FadeAndSlideTransition(
              slideFrom: .bottom,
              slideFromOffset: .3,
              child: CountdownTimersGrid(
                paddingHorizontal: 0,
                time: receptionEvent.startTime,
                borderWidth: 1,
                oddBorderColor: config.countdownBorderColor,
                evenBorderColor: config.countdownBorderColor,
                numberColor: config.countdownTextColor,
                unitColor: config.countdownLabelColor,
                oddColor: config.countdownBgColor,
                evenColor: config.countdownBgColor,
                noAnimate: false,
                topLeftBorderRadius: .circular(4),
                topRightBorderRadius: .circular(4),
                bottomLeftBorderRadius: .circular(4),
                bottomRightBorderRadius: .circular(4),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
