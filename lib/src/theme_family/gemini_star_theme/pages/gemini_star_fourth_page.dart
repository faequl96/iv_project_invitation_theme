import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/gemini_star_configs.dart';
import 'package:iv_project_invitation_theme/src/widgets/countdown_timers_grid.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_model/iv_project_model.dart';

class GeminiStarFourthPage extends StatelessWidget {
  const GeminiStarFourthPage({
    super.key,
    required this.config,
    required this.contractEvent,
    required this.receptionEvent,
  });

  final GeminiStarFourthPageConfig config;
  final EventResponse contractEvent;
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

          if (config.decorationBuilder != null)
            SizedBox(
              height: Screen.height,
              width: Screen.width,
              child: config.decorationBuilder!(),
            ),

          Positioned(
            bottom: 0,
            height: Screen.height,
            width: Screen.width,
            child: Column(
              children: [
                const Spacer(),
                const Spacer(),
                Column(
                  mainAxisSize: .min,
                  children: [
                    FadeAndSlideTransition(
                      slideFromOffset: .8,
                      slideFrom: .bottom,
                      animationSpeed: const Duration(milliseconds: 300),
                      child: _buildContractTime(langCode),
                    ),
                    SizedBox(height: H.xs),
                    SizedBox(
                      height: (W.x3l * 2) + W.x14s,
                      child: CountdownTimersGrid(
                        paddingHorizontal: W.sm + W.x5s,
                        oddColor: config.contractCountdownOddColor,
                        evenColor: config.contractCountdownEvenColor,
                        oddBorderColor: config.contractCountdownOddBorderColor,
                        evenBorderColor: config.contractCountdownEvenBorderColor,
                        numberColor: config.contractCountdownNumberColor,
                        unitColor: config.contractCountdownUnitColor,
                        borderWidth: config.contractCountdownBorderWidth,
                        time: contractEvent.startTime,
                        animationDelayBeforeStart: const Duration(milliseconds: 100),
                        noAnimate: false,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Spacer(),
                Column(
                  mainAxisSize: .min,
                  children: [
                    FadeAndSlideTransition(
                      slideFromOffset: .8,
                      slideFrom: .bottom,
                      animationSpeed: const Duration(milliseconds: 300),
                      child: _buildReceptionTime(langCode),
                    ),
                    SizedBox(height: H.xs),
                    SizedBox(
                      height: (W.x3l * 2) + W.x14s,
                      child: CountdownTimersGrid(
                        paddingHorizontal: W.sm + W.x5s,
                        oddColor: config.receptionCountdownOddColor,
                        evenColor: config.receptionCountdownEvenColor,
                        oddBorderColor: config.receptionCountdownOddBorderColor,
                        evenBorderColor: config.receptionCountdownEvenBorderColor,
                        numberColor: config.receptionCountdownNumberColor,
                        unitColor: config.receptionCountdownUnitColor,
                        borderWidth: config.receptionCountdownBorderWidth,
                        time: receptionEvent.startTime,
                        animationDelayBeforeStart: const Duration(milliseconds: 100),
                        noAnimate: false,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(String langCode, {bool isRight = false}) {
    final contract = langCode == 'en' ? 'Marriage Contract' : 'Akad Nikah';
    final reception = langCode == 'en' ? 'Marriage Reception' : 'Resepsi Nikah';
    final titleTop = isRight ? contract : reception;
    final titleBottom = isRight ? reception : contract;

    Widget buildTitle(String title) => Expanded(
      child: Row(
        children: [
          const Spacer(),
          Column(
            mainAxisAlignment: .center,
            children: [
              FadeAndSlideTransition(
                slideFromOffset: 2.5,
                slideFrom: .left,
                child: Text(
                  title,
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
          SizedBox(width: H.xs),
        ],
      ),
    );

    return SizedBox(
      height: W.sm,
      width: Screen.height,
      child: ColoredBox(
        color: Colors.black12,
        child: Row(children: [buildTitle(titleTop), buildTitle(titleBottom)]),
      ),
    );
  }

  Widget _buildContractTime(String langCode) => Column(
    children: [
      Text(
        DateUtil.format(contractEvent.startTime, .EEEEddMMMMyyyy),
        style: AppFonts.inter(
          color: config.contractBaseTextColor,
          fontSize: FontSize.xl,
          fontWeight: .w500,
        ),
      ),
      SizedBox(height: H.x8s),
      Text(
        langCode == 'en'
            ? '${DateUtil.format(contractEvent.startTime, .HHmm)} o\'clock WIB - ${contractEvent.endTime == null ? 'Finished' : '${DateUtil.format(contractEvent.endTime!, .HHmm)} o\'clock WIB'}'
            : 'Pukul ${DateUtil.format(contractEvent.startTime, .HHmm)} WIB - ${contractEvent.endTime == null ? 'Selesai' : 'Pukul ${DateUtil.format(contractEvent.endTime!, .HHmm)} WIB'}',
        style: AppFonts.inter(
          color: config.contractBaseTextColor,
          fontSize: FontSize.md,
          fontWeight: .w400,
        ),
      ),
    ],
  );

  Widget _buildReceptionTime(String langCode) => Column(
    children: [
      Text(
        DateUtil.format(receptionEvent.startTime, .EEEEddMMMMyyyy),
        style: AppFonts.inter(
          color: config.receptionBaseTextColor,
          fontSize: FontSize.xl,
          fontWeight: .w500,
        ),
      ),
      SizedBox(height: H.x8s),
      Text(
        langCode == 'en'
            ? '${DateUtil.format(receptionEvent.startTime, .HHmm)} o\'clock WIB - ${receptionEvent.endTime == null ? 'Finished' : '${DateUtil.format(receptionEvent.endTime!, .HHmm)} o\'clock WIB'}'
            : 'Pukul ${DateUtil.format(receptionEvent.startTime, .HHmm)} WIB - ${receptionEvent.endTime == null ? 'Selesai' : 'Pukul ${DateUtil.format(receptionEvent.endTime!, .HHmm)} WIB'}',
        style: AppFonts.inter(
          color: config.receptionBaseTextColor,
          fontSize: FontSize.md,
          fontWeight: .w400,
        ),
      ),
    ],
  );
}
