import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/editorial_theme/editorial_configs.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_model/iv_project_model.dart';

class const EditorialFirstPage({
  super.key,
  required final EditorialFirstPageConfig config,
  required final GeneralResponse general,
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
          mainAxisAlignment: .center,
          crossAxisAlignment: .start,
          children: [
            FadeAndSlideTransition(
              slideFrom: .top,
              slideFromOffset: .3,
              child: Row(
                children: [
                  Expanded(child: Container(width: 24, height: 2, color: config.categoryTagColor)),
                  SizedBox(width: W.x10s),
                  _buildTitle(langCode),
                  SizedBox(width: W.x10s),
                  // Expanded(child: Container(width: 24, height: 2, color: config.headlineColor)),
                ],
              ),
            ),
            SizedBox(height: H.x6l),
            Center(
              child: FadeAndSlideTransition(
                slideFrom: .top,
                slideFromOffset: .4,
                child: _buildOpening(),
              ),
            ),
            SizedBox(height: H.x4s),
            FadeAndSlideTransition(
              slideFrom: .bottom,
              slideFromOffset: .3,
              child: Container(
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
                  children: [
                    Icon(Icons.format_quote, color: config.quoteIconColor, size: 36),
                    SizedBox(height: H.x6s),
                    _buildOpeningQuote(),
                    SizedBox(height: H.x6s),
                    _buildQuoteFrom(),
                  ],
                ),
              ),
            ),
            SizedBox(height: H.x2l),
            Center(child: _buildRegards()),
            SizedBox(height: H.x6s),
            FadeAndSlideTransition(
              slideFrom: .bottom,
              slideFromOffset: .3,
              child: Container(
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
                child: _buildGreeting(),
              ),
            ),
            SizedBox(height: H.xl),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(String langCode) => Center(
    child: Text(
      langCode == 'en' ? 'OPENING WORDS' : 'KATA PENGANTAR',
      style: TextStyle(
        color: config.categoryTagColor,
        fontSize: FontSize.lg,
        fontWeight: .w600,
        letterSpacing: 2,
      ),
    ),
  );

  Widget _buildOpening() => Text(
    general.opening.isNotEmpty ? general.opening : 'بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ',
    style: AppFonts.arefRuqaa(color: config.bodyTextColor, fontSize: FontSize.x7l),
  );

  Widget _buildOpeningQuote() => Text(
    general.openingQuote.isNotEmpty ? general.openingQuote : '"Dan di antara tanda-tanda (kebesaran)-Nya adalah Dia menciptakan pasangan-pasangan untukmu dari jenismu sendiri, agar kamu cenderung dan merasa tenteram kepadanya".',
    style: TextStyle(
      color: config.bodyTextColor,
      fontSize: FontSize.md,
      fontWeight: .w500,
      fontStyle: .italic,
    ),
  );

  Widget _buildQuoteFrom() => Text(
    general.quoteFrom.isNotEmpty ? general.quoteFrom : '(Ar-Ruum Ayat 21)',
    style: TextStyle(color: config.bodyTextColor, fontSize: FontSize.lg, fontWeight: .w600),
  );

  Widget _buildRegards() => Text(
    general.regards.isNotEmpty ? general.regards : 'Assalamu\'alaikum Wr. Wb.',
    style: TextStyle(color: config.bodyTextColor, fontSize: FontSize.x2l, fontWeight: .w600),
  );

  Widget _buildGreeting() => Text(
    general.greeting.isNotEmpty ? general.greeting : 'Dengan memohon rahmat dan ridho Allah Subhanahu Wa Ta\'ala. Kami mengundang Bapak/Ibu/Saudara/I, untuk menghadiri resepsi pernikahan kami.',
    style: TextStyle(color: config.bodyTextColor, fontSize: FontSize.md, fontWeight: .w400),
    // textAlign: .center,
  );
}
