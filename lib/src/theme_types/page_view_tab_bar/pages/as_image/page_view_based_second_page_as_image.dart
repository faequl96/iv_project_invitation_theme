import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/src/theme_types/page_view_tab_bar/page_view_tab_bar_configs.dart';
import 'package:iv_project_invitation_theme/src/widgets/animated_border_inviter.dart';
import 'package:iv_project_invitation_theme/src/widgets/animated_inviter.dart';
import 'package:iv_project_invitation_theme/src/widgets/animated_photo_sequence.dart';
import 'package:iv_project_invitation_theme/src/widgets/glass_effect_box.dart';
import 'package:iv_project_invitation_theme/src/widgets/page_view_tab_bar_scaffold_wrapper.dart';
import 'package:iv_project_model/iv_project_model.dart';

class PageViewTabBarSecondPageAsImage extends StatelessWidget {
  const PageViewTabBarSecondPageAsImage({
    super.key,
    required this.config,
    required this.bride,
    required this.groom,
  });

  final PageViewTabBarSecondPageConfig config;
  final BridegroomResponse bride;
  final BridegroomResponse groom;

  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    final contentPadding = EdgeInsets.only(top: H.x6l, left: W.x6s, right: W.x6s, bottom: 76);

    return Stack(
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
                ),
              ),
            ),
          ),

        ?config.background,

        Positioned(top: 0, child: _buildTitle(langCode)),

        Positioned(
          bottom: 0,
          height: Screen.height,
          width: Screen.width,
          child: Padding(
            padding: contentPadding,
            child: PageViewTabBarScaffoldWrapper(
              useBackdropBlur: config.useBackdropBlurOnScaffold,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: .circular(20),
                  gradient: LinearGradient(
                    begin: .topCenter,
                    end: .bottomCenter,
                    colors: [config.firstGradientScaffoldColor, config.secondGradientScaffoldColor],
                    stops: config.stopsGradientScaffoldColor,
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
            padding: contentPadding,
            child: DecoratedBox(
              decoration: BoxDecoration(borderRadius: .circular(20), border: config.scaffoldBorder),
              child: ClipRRect(
                borderRadius: .circular(20),
                child: Stack(
                  clipBehavior: .none,
                  alignment: .center,
                  children: [
                    AnimatedPhotoSequence.left(
                      viewType: .example,
                      frameColor: config.groomImageFrameColor,
                      borderColor: config.groomImageFrameBorderColor,
                      borderWidth: config.groomImageBorderWidth,
                      imageUrl: groom.imageUrl,
                      noAnimate: true,
                    ),
                    AnimatedPhotoSequence.right(
                      viewType: .example,
                      frameColor: config.brideImageFrameColor,
                      borderColor: config.brideImageFrameBorderColor,
                      borderWidth: config.brideImageBorderWidth,
                      imageUrl: bride.imageUrl,
                      noAnimate: true,
                    ),
                    AnimatedInviter.left(
                      noAnimate: false,
                      children: [
                        _buildBrideGroomText(
                          frontTitle: bride.frontTitle,
                          fullName: bride.fullName,
                          backTitle: bride.backTitle,
                          nameColor: config.brideNameTextColor,
                          generalColor: config.generalTextColor,
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: config.brideDividingLineWidth,
                          width: W.x16l,
                          child: ColoredBox(color: config.brideDividingLineColor),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          langCode == 'en' ? 'Daughter of' : 'Putri dari',
                          style: AppFonts.inter(
                            fontSize: FontSize.xs + .2,
                            fontWeight: .w500,
                            color: config.generalTextColor,
                          ),
                        ),
                        const SizedBox(height: 2),
                        _buildFatherMotherText(
                          isFather: true,
                          frontTitle: bride.fatherFrontTitle,
                          name: bride.fatherName,
                          backTitle: bride.fatherBackTitle,
                          nameColor: config.brideFatherNameTextColor,
                          generalColor: config.generalTextColor,
                          langCode: langCode,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          langCode == 'en' ? 'and' : 'dan',
                          style: AppFonts.inter(
                            fontSize: FontSize.xs + .2,
                            fontWeight: .w500,
                            color: config.generalTextColor,
                          ),
                        ),
                        const SizedBox(height: 2),
                        _buildFatherMotherText(
                          isFather: false,
                          frontTitle: bride.motherFrontTitle,
                          name: bride.motherName,
                          backTitle: bride.motherBackTitle,
                          nameColor: config.brideMotherNameTextColor,
                          generalColor: config.generalTextColor,
                          langCode: langCode,
                        ),
                      ],
                    ),
                    AnimatedInviter.right(
                      noAnimate: false,
                      children: [
                        _buildBrideGroomText(
                          frontTitle: groom.frontTitle,
                          fullName: groom.fullName,
                          backTitle: groom.backTitle,
                          nameColor: config.groomNameTextColor,
                          generalColor: config.generalTextColor,
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: config.groomDividingLineWidth,
                          width: W.x16l,
                          child: ColoredBox(color: config.groomDividingLineColor),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          langCode == 'en' ? 'Son of' : 'Putra dari',
                          style: AppFonts.inter(
                            fontSize: FontSize.xs + .2,
                            fontWeight: .w500,
                            color: config.generalTextColor,
                          ),
                        ),
                        const SizedBox(height: 2),
                        _buildFatherMotherText(
                          isFather: true,
                          frontTitle: groom.fatherFrontTitle,
                          name: groom.fatherName,
                          backTitle: groom.fatherBackTitle,
                          nameColor: config.groomFatherNameTextColor,
                          generalColor: config.generalTextColor,
                          langCode: langCode,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          langCode == 'en' ? 'and' : 'dan',
                          style: AppFonts.inter(
                            fontSize: FontSize.xs + .2,
                            fontWeight: .w500,
                            color: config.generalTextColor,
                          ),
                        ),
                        const SizedBox(height: 2),
                        _buildFatherMotherText(
                          isFather: false,
                          frontTitle: groom.motherFrontTitle,
                          name: groom.motherName,
                          backTitle: groom.motherBackTitle,
                          nameColor: config.groomMotherNameTextColor,
                          generalColor: config.generalTextColor,
                          langCode: langCode,
                        ),
                      ],
                    ),
                    AnimatedBorderInviter.top(
                      color: config.brideDividingBorderColor,
                      borderWidth: config.brideDividingBorderWidth,
                      noAnimate: true,
                    ),
                    AnimatedBorderInviter.bottom(
                      color: config.groomDividingBorderColor,
                      borderWidth: config.groomDividingBorderWidth,
                      noAnimate: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        if (config.useGlassEffectOnScaffold)
          Positioned(
            bottom: 0,
            height: Screen.height,
            width: Screen.width,
            child: Padding(
              padding: contentPadding,
              child: GlassEffectBox(
                width: Screen.width - 32,
                height: Screen.height - (76 + H.x6l),
                borderRadius: 20,
                sliderWidth: 90,
                color: Colors.white.withValues(alpha: config.glassEffectOpacity),
                animationSpeed: const Duration(milliseconds: 600),
                delayBeforeStart: const Duration(milliseconds: 3000),
                animationInterval: const Duration(milliseconds: 3500),
                staticValue: .67,
              ),
            ),
          ),

        ?config.foreground,
      ],
    );
  }

  Widget _buildTitle(String langCode) => SizedBox(
    height: H.x6l,
    width: Screen.width,
    child: Row(
      mainAxisAlignment: .center,
      children: [
        Icon(Icons.people, size: W.xs, color: config.titlePageColor),
        const SizedBox(width: 10),
        Text(
          langCode == 'en' ? 'We Invited You' : 'Kami Yang Mengundang',
          style: AppFonts.inter(
            color: config.titlePageColor,
            fontSize: FontSize.x3l,
            fontWeight: .w700,
          ),
        ),
      ],
    ),
  );

  Widget _buildBrideGroomText({
    String? frontTitle,
    required String fullName,
    String? backTitle,
    Color? nameColor,
    required Color generalColor,
  }) {
    return Text.rich(
      TextSpan(
        children: [
          if ((frontTitle ?? '').isNotEmpty)
            TextSpan(
              text: '$frontTitle ',
              style: AppFonts.inter(fontWeight: .w500),
            ),
          TextSpan(
            text: fullName,
            style: AppFonts.inter(fontWeight: .w700, color: nameColor),
          ),
          if ((backTitle ?? '').isNotEmpty)
            TextSpan(
              text: ', $backTitle',
              style: AppFonts.inter(fontWeight: .w500),
            ),
        ],
      ),
      style: AppFonts.inter(fontSize: FontSize.x2l, color: generalColor, height: 1.2),
    );
  }

  Widget _buildFatherMotherText({
    required bool isFather,
    String? frontTitle,
    required String name,
    String? backTitle,
    Color? nameColor,
    required Color generalColor,
    required String langCode,
  }) {
    final prefix = isFather
        ? (langCode == 'en' ? 'Mr. ' : 'Bp. ')
        : (langCode == 'en' ? 'Mrs. ' : 'Ibu ');
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: prefix),
          if ((frontTitle ?? '').isNotEmpty)
            TextSpan(
              text: '$frontTitle ',
              style: AppFonts.inter(fontWeight: .w500, fontStyle: .italic),
            ),
          TextSpan(
            text: name,
            style: AppFonts.inter(fontWeight: .w700, fontStyle: .italic, color: nameColor),
          ),
          if ((backTitle ?? '').isNotEmpty)
            TextSpan(
              text: ', $backTitle',
              style: AppFonts.inter(fontWeight: .w500, fontStyle: .italic),
            ),
        ],
      ),
      style: AppFonts.inter(
        fontSize: FontSize.xs + .2,
        fontStyle: .italic,
        color: generalColor,
        height: 1.2,
      ),
    );
  }
}
