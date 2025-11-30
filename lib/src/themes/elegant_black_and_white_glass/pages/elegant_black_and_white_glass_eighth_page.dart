import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/core/utils/h.dart';
import 'package:iv_project_invitation_theme/src/core/utils/screen.dart';
import 'package:iv_project_invitation_theme/src/core/utils/w.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_invitation_theme/src/widgets/glass_effect_box.dart';
import 'package:iv_project_model/iv_project_model.dart';

class ElegantBlackAndWhiteGlassEighthPage extends StatelessWidget {
  const ElegantBlackAndWhiteGlassEighthPage({
    super.key,
    required this.general,
    required this.brideName,
    required this.groomName,
    required this.brandProfile,
  });

  final GeneralResponse general;
  final String brideName;
  final String groomName;
  final BrandProfileResponse brandProfile;

  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    return BlocSelector<InvitationThemeCoreCubit, InvitationThemeCoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => Stack(
        children: [
          Positioned(
            top: 0,
            child: FadeAndSlideTransition(
              slideFromOffset: .5,
              slideFrom: .top,
              child: SizedBox(
                height: H.x6l,
                width: Screen.width,
                child: Row(
                  mainAxisAlignment: .center,
                  children: [
                    Icon(Icons.emoji_emotions, size: W.xs, color: Colors.grey.shade900),
                    const SizedBox(width: 10),
                    Text(
                      langCode == 'en' ? 'Thank You' : 'Terima Kasih',
                      style: AppFonts.inter(color: Colors.grey.shade900, fontSize: FontSize.x3l, fontWeight: .w700),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            height: Screen.height,
            width: Screen.width,
            child: Padding(
              padding: .only(top: H.x6l, left: W.x6s, right: W.x6s, bottom: H.x16l),
              child: ClipRRect(
                borderRadius: .circular(20),
                child: BackdropFilter(
                  filter: .blur(sigmaX: 3, sigmaY: 3),
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: .1), borderRadius: .circular(20)),
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
              padding: .only(top: H.x6l, left: W.x6s, right: W.x6s, bottom: H.x16l),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: .circular(20),
                  border: .all(width: .5, color: Colors.grey.shade500),
                ),
                child: ClipRRect(
                  borderRadius: .circular(20),
                  child: Column(
                    mainAxisAlignment: .center,
                    children: [
                      Padding(
                        padding: .symmetric(horizontal: W.md),
                        child: FadeAndSlideTransition(
                          slideFromOffset: .8,
                          slideFrom: .bottom,
                          animationSpeed: const Duration(milliseconds: 300),
                          delayBeforeStart: const Duration(milliseconds: 800),
                          child: Text(
                            general.closing.isNotEmpty
                                ? general.closing
                                : 'Merupakan suatu kehormatan dan kebahagiaan bagi kami apabila Bapak/Ibu/Saudara/i berkenan hadir dan memberikan doa restu untuk pernikahan kami. Atas kehadiran dan doa restunya, kami mengucapkan terima kasih.',
                            style: AppFonts.inter(color: Colors.grey.shade900, fontSize: FontSize.md, fontWeight: .w600),
                            textAlign: .center,
                          ),
                        ),
                      ),
                      SizedBox(height: H.lg),
                      Padding(
                        padding: .symmetric(horizontal: W.md),
                        child: FadeAndSlideTransition(
                          slideFromOffset: .8,
                          slideFrom: .bottom,
                          animationSpeed: const Duration(milliseconds: 300),
                          delayBeforeStart: const Duration(milliseconds: 1100),
                          child: Text(
                            '$brideName & $groomName',
                            style: AppFonts.pacifico(color: Colors.grey.shade900, fontSize: FontSize.x5l, fontWeight: .w500),
                            textAlign: .center,
                          ),
                        ),
                      ),
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
              padding: .only(top: H.x6l, left: W.x6s, right: W.x6s, bottom: H.x16l),
              child: GlassEffectBox(
                width: Screen.width - 32,
                height: Screen.height - (76 + H.x6l),
                borderRadius: 20,
                sliderWidth: 90,
                color: Colors.white.withValues(alpha: .5),
                animationSpeed: const Duration(milliseconds: 600),
                delayBeforeStart: const Duration(milliseconds: 3500),
                animationInterval: const Duration(seconds: 4),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            height: H.x16l - H.x4s,
            width: Screen.width,
            child: ClipRRect(
              borderRadius: const .only(topLeft: .circular(20), topRight: .circular(20)),
              child: BackdropFilter(
                filter: .blur(sigmaX: 3, sigmaY: 3),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: .5),
                    borderRadius: const .only(topLeft: .circular(20), topRight: .circular(20)),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            height: H.x16l - H.x4s,
            width: Screen.width,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: const .only(topLeft: .circular(20), topRight: .circular(20)),
                border: .all(width: .5, color: Colors.grey.shade100),
              ),
              child: ClipRRect(
                borderRadius: const .only(topLeft: .circular(20), topRight: .circular(20)),
                child: Padding(
                  padding: .symmetric(horizontal: W.x6s),
                  child: Column(
                    mainAxisAlignment: .center,
                    children: [
                      Text(
                        'Made By :',
                        style: AppFonts.inter(fontWeight: .w400, color: Colors.grey.shade100),
                      ),
                      Row(
                        mainAxisAlignment: .center,
                        children: [
                          if (brandProfile.logoUrl != null) Image.network(brandProfile.logoUrl!),
                          if (brandProfile.logoUrl != null) const SizedBox(width: 10),
                          Text(
                            brandProfile.name,
                            style: AppFonts.inter(fontWeight: .bold, fontSize: 15, color: Colors.grey.shade100),
                          ),
                        ],
                      ),
                      SizedBox(height: H.x10s),
                      Row(
                        mainAxisAlignment: .center,
                        children: [
                          Text(
                            'Email : ',
                            style: AppFonts.inter(fontWeight: .w400, color: Colors.grey.shade100),
                          ),
                          Text(
                            brandProfile.email,
                            style: AppFonts.inter(fontWeight: .bold, color: Colors.grey.shade100),
                          ),
                        ],
                      ),
                      if (brandProfile.phone != null)
                        Row(
                          mainAxisAlignment: .center,
                          children: [
                            Text(
                              'WhatsApp : ',
                              style: AppFonts.inter(fontWeight: .w400, color: Colors.grey.shade100),
                            ),
                            Text(
                              brandProfile.phone!,
                              style: AppFonts.inter(fontWeight: .bold, color: Colors.grey.shade100),
                            ),
                          ],
                        ),
                      if (brandProfile.instagram != null)
                        Row(
                          mainAxisAlignment: .center,
                          children: [
                            Text(
                              'Instagram : ',
                              style: AppFonts.inter(fontWeight: .w400, color: Colors.grey.shade100),
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(text: '@'),
                                  TextSpan(text: brandProfile.instagram!),
                                ],
                              ),
                              style: AppFonts.inter(fontWeight: .bold, color: Colors.grey.shade100),
                            ),
                          ],
                        ),
                      SizedBox(height: H.x10s),
                      if (brandProfile.address != null)
                        Text(
                          brandProfile.address!,
                          style: AppFonts.inter(fontWeight: .w400, color: Colors.grey.shade100, fontSize: 13),
                          textAlign: .center,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
