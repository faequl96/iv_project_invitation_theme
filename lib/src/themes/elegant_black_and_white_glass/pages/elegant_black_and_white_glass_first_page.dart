import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_invitation_theme/src/widgets/glass_effect_box.dart';
import 'package:iv_project_model/iv_project_model.dart';

class ElegantBlackAndWhiteGlassFirstPage extends StatelessWidget {
  const ElegantBlackAndWhiteGlassFirstPage({super.key, required this.general});

  final GeneralResponse general;

  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    return BlocSelector<InvitationThemeCoreCubit, InvitationThemeCoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => Stack(
        children: [
          Positioned(
            top: 0,
            height: Screen.height / 1.2,
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
                child: Center(
                  child: Text(
                    langCode == 'en' ? 'Intent and Purpose' : 'Maksud dan Tujuan',
                    style: AppFonts.inter(color: Colors.grey.shade200, fontSize: FontSize.x3l, fontWeight: .w700),
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
              child: ClipRRect(
                borderRadius: .circular(20),
                child: BackdropFilter(
                  filter: .blur(sigmaX: 3, sigmaY: 3),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      // color: Colors.white.withValues(alpha: .1),
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
                      // SizedBox(height: H.x2l),
                      const Spacer(),
                      FadeAndSlideTransition(
                        slideFromOffset: .5,
                        slideFrom: .top,
                        delayBeforeStart: const Duration(milliseconds: 500),
                        child: Text(
                          general.opening.isNotEmpty ? general.opening : 'بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ',
                          style: AppFonts.arefRuqaa(color: Colors.grey.shade100, fontSize: FontSize.x7l),
                        ),
                      ),
                      // SizedBox(height: H.xs),
                      const Spacer(),
                      FadeAndSlideTransition(
                        slideFromOffset: .4,
                        slideFrom: .left,
                        delayBeforeStart: const Duration(milliseconds: 500),
                        child: Padding(
                          padding: .symmetric(horizontal: W.x6s),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: .all(width: .5, color: Colors.grey.shade500),
                              borderRadius: .circular(10),
                              color: Colors.white.withValues(alpha: .05),
                            ),
                            child: Padding(
                              padding: .only(top: H.md, left: 20, right: 20, bottom: H.sm),
                              child: Column(
                                mainAxisSize: .min,
                                children: [
                                  FadeAndSlideTransition(
                                    slideFromOffset: .3,
                                    slideFrom: .top,
                                    delayBeforeStart: const Duration(milliseconds: 1000),
                                    child: Text(
                                      general.openingQuote.isNotEmpty
                                          ? general.openingQuote
                                          : '"Dan di antara tanda-tanda (kebesaran)-Nya adalah Dia menciptakan pasangan-pasangan untukmu dari jenismu sendiri, agar kamu cenderung dan merasa tenteram kepadanya".',
                                      style: AppFonts.inter(
                                        color: Colors.grey.shade100,
                                        fontSize: FontSize.md,
                                        fontWeight: .w500,
                                        fontStyle: .italic,
                                      ),
                                      textAlign: .center,
                                    ),
                                  ),
                                  SizedBox(height: H.x6s),
                                  FadeAndSlideTransition(
                                    slideFromOffset: 1,
                                    slideFrom: .bottom,
                                    delayBeforeStart: const Duration(milliseconds: 1000),
                                    child: Text(
                                      general.quoteFrom.isNotEmpty ? general.quoteFrom : '(Ar-Ruum Ayat 21)',
                                      style: AppFonts.inter(
                                        color: Colors.grey.shade100,
                                        fontSize: FontSize.lg,
                                        fontWeight: .w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: H.x4s),
                      FadeAndSlideTransition(
                        slideFromOffset: .4,
                        slideFrom: .right,
                        delayBeforeStart: const Duration(milliseconds: 500),
                        child: Padding(
                          padding: .symmetric(horizontal: W.x6s),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: .all(width: .5, color: Colors.grey.shade500),
                              borderRadius: .circular(10),
                              color: Colors.white.withValues(alpha: .05),
                            ),
                            child: Padding(
                              padding: .only(top: H.xs, left: 20, right: 20, bottom: H.sm),
                              child: Column(
                                mainAxisSize: .min,
                                children: [
                                  FadeAndSlideTransition(
                                    slideFromOffset: 1,
                                    slideFrom: .top,
                                    delayBeforeStart: const Duration(milliseconds: 1000),
                                    child: Text(
                                      general.regards.isNotEmpty ? general.regards : 'Assalamu\'alaikum Wr. Wb.',
                                      style: AppFonts.inter(
                                        color: Colors.grey.shade100,
                                        fontSize: FontSize.x2l,
                                        fontWeight: .w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: H.x6s),
                                  FadeAndSlideTransition(
                                    slideFromOffset: .4,
                                    slideFrom: .bottom,
                                    delayBeforeStart: const Duration(milliseconds: 1000),
                                    child: Text(
                                      general.greeting.isNotEmpty
                                          ? general.greeting
                                          : 'Dengan memohon rahmat dan ridho Allah Subhanahu Wa Ta\'ala. Kami mengundang Bapak/Ibu/Saudara/I, untuk menghadiri resepsi pernikahan kami.',
                                      style: AppFonts.inter(
                                        color: Colors.grey.shade100,
                                        fontSize: FontSize.md,
                                        fontWeight: .w400,
                                      ),
                                      textAlign: .center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(height: H.xs),
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
                color: Colors.grey.shade300.withValues(alpha: .4),
                animationSpeed: const Duration(milliseconds: 600),
                delayBeforeStart: const Duration(milliseconds: 2000),
                animationInterval: const Duration(milliseconds: 3500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
