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
                  Expanded(
                    child: Container(width: .infinity, height: 2, color: config.closingBodyColor),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    langCode == 'en' ? 'CLOSING NOTE' : 'PENUTUP',
                    style: TextStyle(
                      color: config.watermarkColor,
                      fontSize: FontSize.lg,
                      fontWeight: .w600,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            FadeAndSlideTransition(
              slideFrom: .top,
              slideFromOffset: .4,
              child: Center(
                child: Text(
                  langCode == 'en' ? 'Thank You' : 'Terima Kasih',
                  style: TextStyle(
                    color: config.closingTitleColor,
                    fontSize: 26,
                    fontWeight: .w800,
                    height: 1.2,
                  ),
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
                      style: TextStyle(color: config.closingBodyColor, fontSize: 13, height: 1.6),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      langCode == 'en' ? 'Warm regards,' : 'Kami yang berbahagia,',
                      style: TextStyle(
                        color: config.closingBodyColor,
                        fontSize: 12,
                        fontStyle: .italic,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$brideName & $groomName',
                      style: TextStyle(
                        color: config.coupleNameColor,
                        fontSize: 20,
                        fontWeight: .w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: .center,
              children: [
                Text(
                  'Made By',
                  style: AppFonts.inter(fontWeight: .w400, color: config.watermarkColor),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: .center,
                  children: [
                    if (brandProfile.logoUrl != null)
                      Image.network(brandProfile.logoUrl!, height: 44),
                    if (brandProfile.logoUrl != null) const SizedBox(width: 10),
                    Text(
                      brandProfile.name,
                      style: AppFonts.inter(
                        fontWeight: .w700,
                        fontSize: 15,
                        color: config.watermarkColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: H.x10s),
                Row(
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      'Email : ',
                      style: AppFonts.inter(fontWeight: .w400, color: config.watermarkColor),
                    ),
                    Text(
                      brandProfile.email,
                      style: AppFonts.inter(fontWeight: .w700, color: config.watermarkColor),
                    ),
                  ],
                ),
                if (brandProfile.phone != null)
                  Row(
                    mainAxisAlignment: .center,
                    children: [
                      Text(
                        'WhatsApp : ',
                        style: AppFonts.inter(fontWeight: .w400, color: config.watermarkColor),
                      ),
                      Text(
                        brandProfile.phone!,
                        style: AppFonts.inter(fontWeight: .w700, color: config.watermarkColor),
                      ),
                    ],
                  ),
                if (brandProfile.instagram != null)
                  Row(
                    mainAxisAlignment: .center,
                    children: [
                      Text(
                        'Instagram : ',
                        style: AppFonts.inter(fontWeight: .w400, color: config.watermarkColor),
                      ),
                      Text.rich(
                        TextSpan(children: [TextSpan(text: brandProfile.instagram!)]),
                        style: AppFonts.inter(fontWeight: .w700, color: config.watermarkColor),
                      ),
                    ],
                  ),
                SizedBox(height: H.x10s),
                if (brandProfile.address != null)
                  Text(
                    brandProfile.address!,
                    style: AppFonts.inter(
                      fontWeight: .w400,
                      color: config.watermarkColor,
                      fontSize: 13,
                    ),
                    textAlign: .center,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
