import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/glass_theme/glass_configs.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_invitation_theme/src/widgets/glass_effect_box.dart';
import 'package:iv_project_invitation_theme/src/widgets/vertical_gallery.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class const GlassFifthPage({
  super.key,
  required final GlassFifthPageConfig config,
  required final ViewType viewType,
  final List<File?>? galleries,
  final GalleryResponse? gallery,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    final contentPadding = EdgeInsets.only(top: H.x6l, left: W.x6s, right: W.x6s, bottom: 76);
    // final contentPadding = EdgeInsets.only(top: H.x6l, left: 0, right: 0, bottom: 76);

    return BlocSelector<InvitationThemeCoreCubit, InvitationThemeCoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => Stack(
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

          Positioned(
            top: 0,
            child: FadeAndSlideTransition(
              slideFromOffset: .5,
              slideFrom: .top,
              child: _buildTitle(langCode),
            ),
          ),

          Positioned(
            bottom: 0,
            height: Screen.height,
            width: Screen.width,
            child: Padding(
              padding: contentPadding,
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
                        colors: [
                          config.firstGradientScaffoldColor,
                          config.secondGradientScaffoldColor,
                        ],
                        stops: config.stopsGradientScaffoldColor,
                      ),
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
                decoration: BoxDecoration(
                  borderRadius: .circular(20),
                  border: config.scaffoldBorder,
                ),
                child: ClipRRect(
                  borderRadius: .circular(20),
                  child: Column(
                    mainAxisAlignment: .center,
                    children: [
                      const Spacer(),
                      VerticalGallery(viewType: viewType, galleries: galleries, gallery: gallery),
                      FadeAndSlideTransition(
                        slideFromOffset: .8,
                        slideFrom: .bottom,
                        animationSpeed: const Duration(milliseconds: 300),
                        delayBeforeStart: const Duration(milliseconds: 2000),
                        child: _buildSeeMore(context, langCode),
                      ),
                      const Spacer(),
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
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(String langCode) => SizedBox(
    height: H.x6l,
    width: Screen.width,
    child: Row(
      mainAxisAlignment: .center,
      children: [
        Icon(Icons.photo_library_rounded, size: W.xs, color: config.titlePageColor),
        const SizedBox(width: 10),
        Text(
          langCode == 'en' ? 'Our Gallery' : 'Galeri Kami',
          style: AppFonts.inter(
            color: config.titlePageColor,
            fontSize: FontSize.x3l,
            fontWeight: .w700,
          ),
        ),
      ],
    ),
  );

  Widget _buildSeeMore(BuildContext context, String langCode) => QuickButton(
    onTap: () {
      FloatingOverlay.showBottomSheet(
        context,
        barrierColor: Colors.grey.shade700.withValues(alpha: .5),
        header: BottomSheetHeader(
          title: .handleBar(color: config.bottomSheetHandleColor),
          action: HeaderAction(
            actionIcon: Icons.close_rounded,
            iconColor: config.bottomSheetCloseIconColor,
            onHoverIconColor: config.bottomSheetOnHoverCloseIconColor,
            onTap: () => NavigationService.pop(),
          ),
        ),
        decoration: BottomSheetDecoration(
          color: config.bottomSheetBackgroundColor,
          borderRadius: const .only(topLeft: .circular(20), topRight: .circular(20)),
        ),
        contentBuilder: (_) {
          return SizedBox(
            height: Screen.height - H.x10l,
            child: Padding(
              padding: .only(left: W.x6s, right: W.x6s, bottom: W.x6s),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: config.bottomSheetContentScaffoldColor,
                  borderRadius: .circular(16),
                ),
                child: SingleChildScrollView(
                  child: VerticalGallery(
                    isShowMore: true,
                    viewType: viewType,
                    galleries: galleries,
                    gallery: gallery,
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
    style: QuickButtonStyle(
      padding: const .symmetric(horizontal: 48),
      height: W.lg + H.x10s,
      borderRadius: .circular(30),
      border: .all(width: config.seeMoreButtonBorderWidth, color: config.seeMoreButtonBorderColor),
      color: config.seeMoreButtonColor,
      elevation: 0,
    ),
    child: Stack(
      alignment: .center,
      children: [
        Text(
          langCode == 'en' ? 'See More' : 'Selengkapnya',
          style: AppFonts.inter(
            color: config.seeMoreButtonLabelColor,
            fontSize: FontSize.md,
            fontWeight: .w600,
          ),
        ),
      ],
    ),
  );
}
