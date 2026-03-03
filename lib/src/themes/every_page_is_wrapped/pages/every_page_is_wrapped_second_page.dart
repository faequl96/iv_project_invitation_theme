import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/core/theme_colors.dart';
import 'package:iv_project_invitation_theme/src/widgets/animated_border_inviter.dart';
import 'package:iv_project_invitation_theme/src/widgets/animated_inviter.dart';
import 'package:iv_project_invitation_theme/src/widgets/animated_photo_sequence.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_invitation_theme/src/widgets/group_background.dart';
import 'package:iv_project_invitation_theme/src/widgets/group_frontground.dart';
import 'package:iv_project_model/iv_project_model.dart';

class EveryPageIsWrappedSecondPage extends StatelessWidget {
  const EveryPageIsWrappedSecondPage({
    super.key,
    required this.viewType,
    this.brideImage,
    this.groomImage,
    required this.bride,
    required this.groom,
  });

  final ViewType viewType;
  final File? brideImage;
  final File? groomImage;
  final BridegroomResponse bride;
  final BridegroomResponse groom;

  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    return BlocSelector<InvitationThemeCoreCubit, InvitationThemeCoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => Stack(
        children: [
          const GroupBackground(),
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
                    Icon(Icons.people, size: W.xs, color: ThemeColors.gold),
                    const SizedBox(width: 10),
                    Text(
                      langCode == 'en' ? 'We Invited You' : 'Kami Yang Mengundang',
                      style: AppFonts.inter(color: ThemeColors.gold, fontSize: FontSize.x3l, fontWeight: .w700),
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
              padding: .only(top: H.x6l, left: W.x6s, right: W.x6s, bottom: 76),
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.black.withValues(alpha: .7), borderRadius: .circular(20)),
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
                  border: const GradientBoxBorder(
                    width: 3,
                    gradient: LinearGradient(
                      begin: .topLeft,
                      end: .bottomRight,
                      colors: [ThemeColors.roseGold, ThemeColors.gold, ThemeColors.roseGold, ThemeColors.gold],
                      transform: GradientRotation(-0.2),
                    ),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: .circular(20),
                  child: Stack(
                    clipBehavior: .none,
                    alignment: .center,
                    children: [
                      AnimatedPhotoSequence.left(
                        viewType: viewType,
                        baseColor: ThemeColors.gold,
                        borderWidth: 2,
                        imageUrl: groom.imageUrl,
                        image: groomImage,
                      ),
                      AnimatedPhotoSequence.right(
                        viewType: viewType,
                        baseColor: ThemeColors.roseGold,
                        borderWidth: 2,
                        imageUrl: bride.imageUrl,
                        image: brideImage,
                      ),
                      AnimatedInviter.left(
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
                                  style: AppFonts.inter(fontWeight: .w700, color: ThemeColors.roseGold),
                                ),
                                if ((bride.backTitle ?? '').isNotEmpty)
                                  TextSpan(
                                    text: ', ${bride.backTitle}',
                                    style: AppFonts.inter(fontWeight: .w500),
                                  ),
                              ],
                            ),
                            style: AppFonts.inter(fontSize: FontSize.x2l, color: Colors.grey.shade200, height: 1.2),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 1,
                            width: W.x16l,
                            child: const ColoredBox(color: ThemeColors.roseGold),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            langCode == 'en' ? 'Daughter of' : 'Putri dari',
                            style: AppFonts.inter(fontSize: FontSize.xs + .2, fontWeight: .w500, color: Colors.grey.shade200),
                          ),
                          const SizedBox(height: 2),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: langCode == 'en' ? 'Mr. ' : 'Bp. ',
                                  style: AppFonts.inter(color: ThemeColors.gold),
                                ),
                                if ((bride.fatherFrontTitle ?? '').isNotEmpty)
                                  TextSpan(
                                    text: '${bride.fatherFrontTitle} ',
                                    style: AppFonts.inter(fontWeight: .w500, fontStyle: .italic),
                                  ),
                                TextSpan(
                                  text: bride.fatherName,
                                  style: AppFonts.inter(fontWeight: .w700, fontStyle: .italic, color: ThemeColors.gold),
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
                              color: Colors.grey.shade200,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            langCode == 'en' ? 'and' : 'dan',
                            style: AppFonts.inter(fontSize: FontSize.xs + .2, fontWeight: .w500, color: Colors.grey.shade200),
                          ),
                          const SizedBox(height: 2),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: langCode == 'en' ? 'Mrs. ' : 'Ibu ',
                                  style: AppFonts.inter(color: ThemeColors.roseGold),
                                ),
                                if ((bride.motherFrontTitle ?? '').isNotEmpty)
                                  TextSpan(
                                    text: '${bride.motherFrontTitle} ',
                                    style: AppFonts.inter(fontWeight: .w500, fontStyle: .italic),
                                  ),
                                TextSpan(
                                  text: bride.motherName,
                                  style: AppFonts.inter(fontWeight: .w700, fontStyle: .italic, color: ThemeColors.roseGold),
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
                              color: Colors.grey.shade200,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                      AnimatedInviter.right(
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
                                  style: AppFonts.inter(fontWeight: .w700, color: ThemeColors.gold),
                                ),
                                if ((groom.backTitle ?? '').isNotEmpty)
                                  TextSpan(
                                    text: ', ${groom.backTitle}',
                                    style: AppFonts.inter(fontWeight: .w500),
                                  ),
                              ],
                            ),
                            style: AppFonts.inter(fontSize: FontSize.x2l, color: Colors.grey.shade200, height: 1.2),
                            textAlign: .end,
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 1,
                            width: W.x16l,
                            child: const ColoredBox(color: ThemeColors.gold),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            langCode == 'en' ? 'Son of' : 'Putra dari',
                            style: AppFonts.inter(fontSize: FontSize.xs + .2, fontWeight: .w500, color: Colors.grey.shade200),
                          ),
                          const SizedBox(height: 2),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: langCode == 'en' ? 'Mr. ' : 'Bp. ',
                                  style: AppFonts.inter(color: ThemeColors.gold),
                                ),
                                if ((groom.fatherFrontTitle ?? '').isNotEmpty)
                                  TextSpan(
                                    text: '${groom.fatherFrontTitle} ',
                                    style: AppFonts.inter(fontWeight: .w500, fontStyle: .italic),
                                  ),
                                TextSpan(
                                  text: groom.fatherName,
                                  style: AppFonts.inter(fontWeight: .w700, fontStyle: .italic, color: ThemeColors.gold),
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
                              color: Colors.grey.shade200,
                              height: 1.2,
                            ),
                            textAlign: .right,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            langCode == 'en' ? 'and' : 'dan',
                            style: AppFonts.inter(fontSize: FontSize.xs + .2, fontWeight: .w500, color: Colors.grey.shade200),
                          ),
                          const SizedBox(height: 2),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: langCode == 'en' ? 'Mrs. ' : 'Ibu ',
                                  style: AppFonts.inter(color: ThemeColors.roseGold),
                                ),
                                if ((groom.motherFrontTitle ?? '').isNotEmpty)
                                  TextSpan(
                                    text: '${groom.motherFrontTitle} ',
                                    style: AppFonts.inter(fontWeight: .w500, fontStyle: .italic),
                                  ),
                                TextSpan(
                                  text: groom.motherName,
                                  style: AppFonts.inter(fontWeight: .w700, fontStyle: .italic, color: ThemeColors.roseGold),
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
                              color: Colors.grey.shade200,
                              height: 1.2,
                            ),
                            textAlign: .right,
                          ),
                        ],
                      ),
                      const AnimatedBorderInviter.top(color: ThemeColors.roseGold, borderWidth: 2),
                      const AnimatedBorderInviter.bottom(color: ThemeColors.gold, borderWidth: 2),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const GroupFrontground(),
        ],
      ),
    );
  }
}
