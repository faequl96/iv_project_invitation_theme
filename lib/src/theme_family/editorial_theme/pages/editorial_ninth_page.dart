import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/editorial_theme/editorial_configs.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_model/iv_project_model.dart';

class const EditorialNinthPage({
  super.key,
  required final EditorialNinthPageConfig config,
  required final GeneralResponse general,
  required final String brideName,
  required final String groomName,
  required final BrandProfileResponse brandProfile,
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
        padding: const .symmetric(horizontal: 24, vertical: 36),
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .start,
          children: [
            FadeAndSlideTransition(
              slideFrom: .top,
              slideFromOffset: .3,
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 2,
                    color: config.closingTitleColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    langCode == 'en' ? 'CLOSING NOTE' : 'PENUTUP',
                    style: TextStyle(
                      color: config.watermarkColor,
                      fontSize: 11,
                      fontWeight: .bold,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            FadeAndSlideTransition(
              slideFrom: .top,
              slideFromOffset: .4,
              child: Text(
                langCode == 'en' ? 'Thank You for Being Part of Our Journey' : 'Terima Kasih Atas Kehadiran & Doa Restu Anda',
                style: TextStyle(
                  color: config.closingTitleColor,
                  fontSize: 26,
                  fontWeight: .w800,
                  fontFamily: 'serif',
                  height: 1.2,
                ),
              ),
            ),
            const SizedBox(height: 24),
            FadeAndSlideTransition(
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
                  children: [
                    Text(
                      general.closing,
                      style: TextStyle(
                        color: config.closingBodyColor,
                        fontSize: 13,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      langCode == 'en' ? 'Warm regards,' : 'Kami yang berbahagia,',
                      style: TextStyle(
                        color: config.closingBodyColor,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$brideName & $groomName',
                      style: TextStyle(
                        color: config.coupleNameColor,
                        fontSize: 20,
                        fontWeight: .w800,
                        fontFamily: 'serif',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Center(
              child: FadeAndSlideTransition(
                slideFrom: .bottom,
                slideFromOffset: .4,
                child: Text(
                  'Created with in-vite • ${brandProfile.name}',
                  style: TextStyle(
                    color: config.watermarkColor,
                    fontSize: 11,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
