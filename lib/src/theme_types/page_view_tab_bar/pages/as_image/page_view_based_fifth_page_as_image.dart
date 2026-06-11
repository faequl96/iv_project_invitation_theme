import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/src/theme_types/page_view_tab_bar/page_view_tab_bar_configs.dart';
import 'package:iv_project_invitation_theme/src/widgets/glass_effect_box.dart';
import 'package:iv_project_invitation_theme/src/widgets/page_view_tab_bar_scaffold_wrapper.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class PageViewTabBarFifthPageAsImage extends StatelessWidget {
  const PageViewTabBarFifthPageAsImage({super.key, required this.config, this.gallery});

  final PageViewTabBarFifthPageConfig config;
  final GalleryResponse? gallery;

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
                child: Column(
                  mainAxisAlignment: .center,
                  children: [
                    const Spacer(),
                    _Gallery(
                      dividingLineWidth: config.dividingLineWidth,
                      dividingVerticalLineColor: config.dividingVerticalLineColor,
                      dividingHorizontalLineColor: config.dividingHorizontalLineColor,
                      gallery: gallery,
                    ),
                    _buildSeeMore(context, langCode),
                    const Spacer(),
                    const Spacer(),
                    const Spacer(),
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
    onTap: () {},
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

class _Gallery extends StatelessWidget {
  const _Gallery({
    required this.dividingLineWidth,
    required this.dividingVerticalLineColor,
    required this.dividingHorizontalLineColor,
    this.gallery,
  });

  final double dividingLineWidth;
  final Color dividingVerticalLineColor;
  final Color dividingHorizontalLineColor;
  final GalleryResponse? gallery;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: H.x2s),
        Row(
          children: [
            SizedBox(width: W.x4s),
            Expanded(
              flex: 5,
              child: SizedBox(
                height: W.x11l + 4,
                child: _ImageViewer(imageUrl: gallery?.imageURL1),
              ),
            ),
            SizedBox(width: W.x7s),
            SizedBox(
              height: W.x11l + 4,
              width: dividingLineWidth,
              child: ColoredBox(color: dividingVerticalLineColor),
            ),
            SizedBox(width: W.x7s),
            Expanded(
              flex: 3,
              child: SizedBox(
                height: W.x11l + 4,
                child: _ImageViewer(imageUrl: gallery?.imageURL2),
              ),
            ),
            SizedBox(width: W.x4s),
          ],
        ),
        SizedBox(height: W.x7s),
        Row(
          children: [
            SizedBox(width: W.x4s),
            Expanded(
              child: SizedBox(
                height: dividingLineWidth,
                child: ColoredBox(color: dividingHorizontalLineColor),
              ),
            ),
            SizedBox(width: W.x4s),
          ],
        ),
        SizedBox(height: W.x7s),
        Row(
          children: [
            SizedBox(width: W.x4s),
            Expanded(
              flex: 3,
              child: SizedBox(
                height: W.x11l + 4,
                child: _ImageViewer(imageUrl: gallery?.imageURL3),
              ),
            ),
            SizedBox(width: W.x7s),
            SizedBox(
              height: W.x11l + 4,
              width: dividingLineWidth,
              child: ColoredBox(color: dividingVerticalLineColor),
            ),
            SizedBox(width: W.x7s),
            Expanded(
              flex: 5,
              child: SizedBox(
                height: W.x11l + 4,
                child: _ImageViewer(imageUrl: gallery?.imageURL4),
              ),
            ),
            SizedBox(width: W.x4s),
          ],
        ),
        SizedBox(height: W.x7s),
        Row(
          children: [
            SizedBox(width: W.x4s),
            Expanded(
              child: SizedBox(
                height: dividingLineWidth,
                child: ColoredBox(color: dividingHorizontalLineColor),
              ),
            ),
            SizedBox(width: W.x4s),
          ],
        ),
        SizedBox(height: W.x7s),
        Row(
          children: [
            SizedBox(width: W.x4s),
            Expanded(
              child: SizedBox(
                height: W.x10l - 4,
                child: _ImageViewer(imageUrl: gallery?.imageURL5),
              ),
            ),
            SizedBox(width: W.x7s),
            SizedBox(
              height: W.x10l - 4,
              width: dividingLineWidth,
              child: ColoredBox(color: dividingVerticalLineColor),
            ),
            SizedBox(width: W.x7s),
            Expanded(
              child: SizedBox(
                height: W.x10l - 4,
                child: _ImageViewer(imageUrl: gallery?.imageURL6),
              ),
            ),
            SizedBox(width: W.x7s),
            SizedBox(
              height: W.x10l - 4,
              width: dividingLineWidth,
              child: ColoredBox(color: dividingVerticalLineColor),
            ),
            SizedBox(width: W.x7s),
            Expanded(
              child: SizedBox(
                height: W.x10l - 4,
                child: _ImageViewer(imageUrl: gallery?.imageURL7),
              ),
            ),
            SizedBox(width: W.x4s),
          ],
        ),
        SizedBox(height: H.x2s),
      ],
    );
  }
}

class _ImageViewer extends StatelessWidget {
  const _ImageViewer({this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(borderRadius: .circular(8), child: _content());
  }

  Widget _content() {
    if (imageUrl != null) {
      return Image.asset(imageUrl!, fit: .cover, package: 'iv_project_invitation_theme');
    }

    return const ColoredBox(color: Colors.grey);
  }
}
