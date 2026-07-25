import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/gemini_star_configs.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_model/iv_project_model.dart';

class GeminiStarFirstPage extends StatelessWidget {
  const GeminiStarFirstPage({super.key, required this.config, required this.general});

  final GeminiStarFirstPageConfig config;
  final GeneralResponse general;

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
                    stops: const [.3, .8],
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
            child: ClipRect(
              child: Column(
                children: [
                  const Spacer(),
                  const Spacer(),
                  const Spacer(),
                  const Spacer(),
                  Padding(
                    padding: .only(left: W.sm, right: W.sm),
                    child: FadeAndSlideTransition(
                      slideFromOffset: .5,
                      slideFrom: .top,
                      child: _buildOpening(),
                    ),
                  ),
                  SizedBox(height: H.x4s),
                  Row(
                    children: [
                      SizedBox(width: W.sm),
                      SizedBox(width: W.x5s),
                      Expanded(
                        child: Column(
                          children: [
                            FadeAndSlideTransition(
                              slideFromOffset: .3,
                              slideFrom: .top,
                              delayBeforeStart: const Duration(milliseconds: 500),
                              child: _buildOpeningQuote(),
                            ),
                            SizedBox(height: H.x9s),
                            FadeAndSlideTransition(
                              slideFromOffset: 1,
                              slideFrom: .bottom,
                              delayBeforeStart: const Duration(milliseconds: 500),
                              child: _buildQuoteFrom(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: W.x5s),
                      SizedBox(width: W.sm),
                    ],
                  ),
                  SizedBox(height: H.xs),
                  Row(
                    children: [
                      SizedBox(width: W.sm),
                      SizedBox(width: W.x5s),
                      Expanded(
                        child: Column(
                          children: [
                            FadeAndSlideTransition(
                              slideFromOffset: 1,
                              slideFrom: .top,
                              delayBeforeStart: const Duration(milliseconds: 500),
                              child: _buildRegards(),
                            ),
                            SizedBox(height: H.x9s),
                            FadeAndSlideTransition(
                              slideFromOffset: .4,
                              slideFrom: .bottom,
                              delayBeforeStart: const Duration(milliseconds: 500),
                              child: _buildGreeting(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: W.x5s),
                      SizedBox(width: W.sm),
                    ],
                  ),
                  SizedBox(height: H.x6l),
                ],
              ),
            ),
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
          const Spacer(),
          Column(
            mainAxisAlignment: .center,
            children: [
              FadeAndSlideTransition(
                slideFromOffset: 1.5,
                slideFrom: .left,
                child: Text(
                  langCode == 'en' ? 'Intent and Purpose' : 'Maksud dan Tujuan',
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
          SizedBox(width: isRight ? H.x5l : H.x5l + H.x3s),
        ],
      ),
    ),
  );

  Widget _buildOpening() => Text(
    general.opening.isNotEmpty ? general.opening : 'بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ',
    style: AppFonts.arefRuqaa(color: config.openingTextColor, fontSize: FontSize.x7l),
  );

  Widget _buildOpeningQuote() => Text(
    general.openingQuote.isNotEmpty
        ? general.openingQuote
        : '"Dan di antara tanda-tanda (kebesaran)-Nya adalah Dia menciptakan pasangan-pasangan untukmu dari jenismu sendiri, agar kamu cenderung dan merasa tenteram kepadanya".',
    style: AppFonts.inter(
      color: config.generalTextColor,
      fontSize: FontSize.md,
      fontWeight: .w500,
      fontStyle: .italic,
    ),
    textAlign: .center,
  );

  Widget _buildQuoteFrom() => Text(
    general.quoteFrom.isNotEmpty ? general.quoteFrom : '(Ar-Ruum Ayat 21)',
    style: AppFonts.inter(color: config.generalTextColor, fontSize: FontSize.lg, fontWeight: .w600),
  );

  Widget _buildRegards() => Text(
    general.regards.isNotEmpty ? general.regards : 'Assalamu\'alaikum Wr. Wb.',
    style: AppFonts.inter(
      color: config.generalTextColor,
      fontSize: FontSize.x2l,
      fontWeight: .w600,
    ),
  );

  Widget _buildGreeting() => Text(
    general.greeting.isNotEmpty
        ? general.greeting
        : 'Dengan memohon rahmat dan ridho Allah Subhanahu Wa Ta\'ala. Kami mengundang Bapak/Ibu/Saudara/I, untuk menghadiri resepsi pernikahan kami.',
    style: AppFonts.inter(color: config.generalTextColor, fontSize: FontSize.md, fontWeight: .w400),
    textAlign: .center,
  );
}
