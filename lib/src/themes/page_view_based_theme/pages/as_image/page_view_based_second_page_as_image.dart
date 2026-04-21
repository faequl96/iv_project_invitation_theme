import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/page_view_based_configs.dart';
import 'package:iv_project_invitation_theme/src/widgets/animated_border_inviter.dart';
import 'package:iv_project_invitation_theme/src/widgets/animated_inviter.dart';
import 'package:iv_project_invitation_theme/src/widgets/animated_photo_sequence.dart';
import 'package:iv_project_invitation_theme/src/widgets/glass_effect_box.dart';
import 'package:iv_project_model/iv_project_model.dart';

class PageViewBasedSecondPageAsImage extends StatelessWidget {
  const PageViewBasedSecondPageAsImage({super.key, required this.config, required this.bride, required this.groom});

  final PageViewBasedSecondPageConfig config;
  final BridegroomResponse bride;
  final BridegroomResponse groom;

  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    return Stack(
      children: [
        if (config.firstGradientBackgroundColor != null && config.secondGradientBackgroundColor != null)
          Positioned(
            top: 0,
            height: Screen.height,
            width: Screen.width,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: .topCenter,
                  end: .bottomCenter,
                  colors: [config.firstGradientBackgroundColor!, config.secondGradientBackgroundColor!],
                ),
              ),
            ),
          ),

        config.background ?? const SizedBox.shrink(),

        Positioned(top: 0, child: _title(langCode)),

        if (config.useBackdropBlurOnScaffold)
          Positioned(
            bottom: 0,
            height: Screen.height,
            width: Screen.width,
            child: Padding(
              padding: .only(top: H.x6l, left: W.x6s, right: W.x6s, bottom: 76),
              child: RepaintBoundary(
                child: ClipRRect(
                  borderRadius: .circular(20),
                  child: BackdropFilter(
                    filter: .blur(sigmaX: 3, sigmaY: 3),
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
            ),
          )
        else
          Positioned(
            bottom: 0,
            height: Screen.height,
            width: Screen.width,
            child: Padding(
              padding: .only(top: H.x6l, left: W.x6s, right: W.x6s, bottom: 76),
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
        Positioned(
          bottom: 0,
          height: Screen.height,
          width: Screen.width,
          child: Padding(
            padding: .only(top: H.x6l, left: W.x6s, right: W.x6s, bottom: 76),
            child: DecoratedBox(
              decoration: BoxDecoration(borderRadius: .circular(20), border: config.scaffoldBorder),
              child: ClipRRect(
                borderRadius: .circular(20),
                child: Stack(
                  clipBehavior: .none,
                  alignment: .center,
                  children: [
                    AnimatedPhotoSequence.left(
                      viewType: ViewType.example,
                      frameColor: config.groomImageFrameColor,
                      borderColor: config.groomImageFrameBorderColor,
                      borderWidth: config.groomImageBorderWidth,
                      imageUrl: groom.imageUrl,
                      noAnimate: true,
                    ),
                    AnimatedPhotoSequence.right(
                      viewType: ViewType.example,
                      frameColor: config.brideImageFrameColor,
                      borderColor: config.brideImageFrameBorderColor,
                      borderWidth: config.brideImageBorderWidth,
                      imageUrl: bride.imageUrl,
                      noAnimate: true,
                    ),
                    AnimatedInviter.left(
                      noAnimate: true,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              if ((bride.frontTitle ?? '').isNotEmpty)
                                TextSpan(
                                  text: '${bride.frontTitle} ',
                                  style: AppFonts.inter(fontWeight: .w500),
                                ),
                              TextSpan(
                                text: bride.fullName,
                                style: AppFonts.inter(fontWeight: .w700, color: config.brideNameTextColor),
                              ),
                              if ((bride.backTitle ?? '').isNotEmpty)
                                TextSpan(
                                  text: ', ${bride.backTitle}',
                                  style: AppFonts.inter(fontWeight: .w500),
                                ),
                            ],
                          ),
                          style: AppFonts.inter(fontSize: FontSize.x2l, color: config.generalTextColor, height: 1.2),
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
                          style: AppFonts.inter(fontSize: FontSize.xs + .2, fontWeight: .w500, color: config.generalTextColor),
                        ),
                        const SizedBox(height: 2),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(text: langCode == 'en' ? 'Mr. ' : 'Bp. '),
                              if ((bride.fatherFrontTitle ?? '').isNotEmpty)
                                TextSpan(
                                  text: '${bride.fatherFrontTitle} ',
                                  style: AppFonts.inter(fontWeight: .w500, fontStyle: .italic),
                                ),
                              TextSpan(
                                text: bride.fatherName,
                                style: AppFonts.inter(
                                  fontWeight: .w700,
                                  fontStyle: .italic,
                                  color: config.brideFatherNameTextColor,
                                ),
                              ),
                              if ((bride.fatherBackTitle ?? '').isNotEmpty)
                                TextSpan(
                                  text: ', ${bride.fatherBackTitle}',
                                  style: AppFonts.inter(fontWeight: .w500, fontStyle: .italic),
                                ),
                            ],
                          ),
                          style: AppFonts.inter(
                            fontSize: FontSize.xs + .2,
                            fontStyle: .italic,
                            color: config.generalTextColor,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          langCode == 'en' ? 'and' : 'dan',
                          style: AppFonts.inter(fontSize: FontSize.xs + .2, fontWeight: .w500, color: config.generalTextColor),
                        ),
                        const SizedBox(height: 2),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(text: langCode == 'en' ? 'Mrs. ' : 'Ibu '),
                              if ((bride.motherFrontTitle ?? '').isNotEmpty)
                                TextSpan(
                                  text: '${bride.motherFrontTitle} ',
                                  style: AppFonts.inter(fontWeight: .w500, fontStyle: .italic),
                                ),
                              TextSpan(
                                text: bride.motherName,
                                style: AppFonts.inter(
                                  fontWeight: .w700,
                                  fontStyle: .italic,
                                  color: config.brideMotherNameTextColor,
                                ),
                              ),
                              if ((bride.motherBackTitle ?? '').isNotEmpty)
                                TextSpan(
                                  text: ', ${bride.motherBackTitle}',
                                  style: AppFonts.inter(fontWeight: .w500, fontStyle: .italic),
                                ),
                            ],
                          ),
                          style: AppFonts.inter(
                            fontSize: FontSize.xs + .2,
                            fontStyle: .italic,
                            color: config.generalTextColor,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                    AnimatedInviter.right(
                      noAnimate: true,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              if ((groom.frontTitle ?? '').isNotEmpty)
                                TextSpan(
                                  text: '${groom.frontTitle} ',
                                  style: AppFonts.inter(fontWeight: .w500),
                                ),
                              TextSpan(
                                text: groom.fullName,
                                style: AppFonts.inter(fontWeight: .w700, color: config.groomNameTextColor),
                              ),
                              if ((groom.backTitle ?? '').isNotEmpty)
                                TextSpan(
                                  text: ', ${groom.backTitle}',
                                  style: AppFonts.inter(fontWeight: .w500),
                                ),
                            ],
                          ),
                          style: AppFonts.inter(fontSize: FontSize.x2l, color: config.generalTextColor, height: 1.2),
                          textAlign: .end,
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
                          style: AppFonts.inter(fontSize: FontSize.xs + .2, fontWeight: .w500, color: config.generalTextColor),
                        ),
                        const SizedBox(height: 2),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(text: langCode == 'en' ? 'Mr. ' : 'Bp. '),
                              if ((groom.fatherFrontTitle ?? '').isNotEmpty)
                                TextSpan(
                                  text: '${groom.fatherFrontTitle} ',
                                  style: AppFonts.inter(fontWeight: .w500, fontStyle: .italic),
                                ),
                              TextSpan(
                                text: groom.fatherName,
                                style: AppFonts.inter(
                                  fontWeight: .w700,
                                  fontStyle: .italic,
                                  color: config.groomFatherNameTextColor,
                                ),
                              ),
                              if ((groom.fatherBackTitle ?? '').isNotEmpty)
                                TextSpan(
                                  text: ', ${groom.fatherBackTitle}',
                                  style: AppFonts.inter(fontWeight: .w500, fontStyle: .italic),
                                ),
                            ],
                          ),
                          style: AppFonts.inter(
                            fontSize: FontSize.xs + .2,
                            fontStyle: .italic,
                            color: config.generalTextColor,
                            height: 1.2,
                          ),
                          textAlign: .right,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          langCode == 'en' ? 'and' : 'dan',
                          style: AppFonts.inter(fontSize: FontSize.xs + .2, fontWeight: .w500, color: config.generalTextColor),
                        ),
                        const SizedBox(height: 2),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(text: langCode == 'en' ? 'Mrs. ' : 'Ibu '),
                              if ((groom.motherFrontTitle ?? '').isNotEmpty)
                                TextSpan(
                                  text: '${groom.motherFrontTitle} ',
                                  style: AppFonts.inter(fontWeight: .w500, fontStyle: .italic),
                                ),
                              TextSpan(
                                text: groom.motherName,
                                style: AppFonts.inter(
                                  fontWeight: .w700,
                                  fontStyle: .italic,
                                  color: config.groomMotherNameTextColor,
                                ),
                              ),
                              if ((groom.motherBackTitle ?? '').isNotEmpty)
                                TextSpan(
                                  text: ', ${groom.motherBackTitle}',
                                  style: AppFonts.inter(fontWeight: .w500, fontStyle: .italic),
                                ),
                            ],
                          ),
                          style: AppFonts.inter(
                            fontSize: FontSize.xs + .2,
                            fontStyle: .italic,
                            color: config.generalTextColor,
                            height: 1.2,
                          ),
                          textAlign: .right,
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
              padding: .only(top: H.x6l, left: W.x6s, right: W.x6s, bottom: 76),
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

        config.foreground ?? const SizedBox.shrink(),
      ],
    );
  }

  Widget _title(String langCode) => SizedBox(
    height: H.x6l,
    width: Screen.width,
    child: Row(
      mainAxisAlignment: .center,
      children: [
        Icon(Icons.people, size: W.xs, color: config.titlePageColor),
        const SizedBox(width: 10),
        Text(
          langCode == 'en' ? 'We Invited You' : 'Kami Yang Mengundang',
          style: AppFonts.inter(color: config.titlePageColor, fontSize: FontSize.x3l, fontWeight: .w700),
        ),
      ],
    ),
  );
}
