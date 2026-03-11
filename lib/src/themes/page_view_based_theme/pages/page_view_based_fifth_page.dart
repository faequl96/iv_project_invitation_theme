import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_invitation_theme/src/widgets/glass_effect_box.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:iv_project_widget_core/iv_project_widget_core.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class PageViewBasedFifthPageConfig {
  const PageViewBasedFifthPageConfig({
    this.frontground,
    this.background,
    required this.useBackdropBlurOnScaffold,
    required this.firstGradientScaffoldColor,
    required this.secondGradientScaffoldColor,
    required this.scaffoldBorder,
    required this.useGlassEffectOnScaffold,
    this.glassEffectOpacity = .4,
    this.firstGradientBackgroundColor,
    this.secondGradientBackgroundColor,
    required this.titlePageColor,
    required this.dividingLineWidth,
    required this.dividingVerticalLineColor,
    required this.dividingHorizontalLineColor,
    required this.seeMoreButtonColor,
    required this.seeMoreButtonLabelColor,
    required this.seeMoreButtonBorderWidth,
    required this.seeMoreButtonBorderColor,
    required this.bottomSheetHandleColor,
    required this.bottomSheetContentScaffoldColor,
    required this.bottomSheetBackgroundColor,
    required this.bottomSheetCloseIconColor,
    this.bottomSheetOnHoverCloseIconColor,
  });

  final Widget? frontground;
  final Widget? background;
  final bool useBackdropBlurOnScaffold;
  final Color firstGradientScaffoldColor;
  final Color secondGradientScaffoldColor;
  final BoxBorder scaffoldBorder;
  final bool useGlassEffectOnScaffold;
  final double glassEffectOpacity;
  final Color? firstGradientBackgroundColor;
  final Color? secondGradientBackgroundColor;
  final Color titlePageColor;
  final double dividingLineWidth;
  final Color dividingVerticalLineColor;
  final Color dividingHorizontalLineColor;
  final Color seeMoreButtonColor;
  final Color seeMoreButtonLabelColor;
  final double seeMoreButtonBorderWidth;
  final Color seeMoreButtonBorderColor;
  final Color? bottomSheetHandleColor;
  final Color bottomSheetContentScaffoldColor;
  final Color bottomSheetBackgroundColor;
  final Color bottomSheetCloseIconColor;
  final Color? bottomSheetOnHoverCloseIconColor;
}

class PageViewBasedFifthPage extends StatelessWidget {
  const PageViewBasedFifthPage({super.key, required this.config, required this.viewType, this.galleries, this.gallery});

  final PageViewBasedFifthPageConfig config;
  final ViewType viewType;
  final List<File?>? galleries;
  final GalleryResponse? gallery;

  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    return BlocSelector<InvitationThemeCoreCubit, InvitationThemeCoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => Stack(
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
                    Icon(Icons.photo_library_rounded, size: W.xs, color: config.titlePageColor),
                    const SizedBox(width: 10),
                    Text(
                      langCode == 'en' ? 'Our Gallery' : 'Galeri Kami',
                      style: AppFonts.inter(color: config.titlePageColor, fontSize: FontSize.x3l, fontWeight: .w700),
                    ),
                  ],
                ),
              ),
            ),
          ),
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
                  child: Column(
                    mainAxisAlignment: .center,
                    children: [
                      const Spacer(),
                      _Gallery(
                        dividingLineWidth: config.dividingLineWidth,
                        dividingVerticalLineColor: config.dividingVerticalLineColor,
                        dividingHorizontalLineColor: config.dividingHorizontalLineColor,
                        viewType: viewType,
                        galleries: galleries,
                        gallery: gallery,
                      ),
                      FadeAndSlideTransition(
                        slideFromOffset: .8,
                        slideFrom: .bottom,
                        animationSpeed: const Duration(milliseconds: 300),
                        delayBeforeStart: const Duration(milliseconds: 2000),
                        child: GeneralEffectsButton(
                          onTap: () {
                            ShowModal.bottomSheet(
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
                                        child: _Gallery(
                                          dividingLineWidth: config.dividingLineWidth,
                                          dividingVerticalLineColor: config.dividingVerticalLineColor,
                                          dividingHorizontalLineColor: config.dividingHorizontalLineColor,
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
                          padding: const .symmetric(horizontal: 48),
                          height: W.lg + H.x10s,
                          borderRadius: .circular(30),
                          border: .all(width: config.seeMoreButtonBorderWidth, color: config.seeMoreButtonBorderColor),
                          color: config.seeMoreButtonColor,
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
                        ),
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
                ),
              ),
            ),

          config.frontground ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class _Gallery extends StatelessWidget {
  const _Gallery({
    required this.dividingLineWidth,
    required this.dividingVerticalLineColor,
    required this.dividingHorizontalLineColor,
    this.isShowMore = false,
    required this.viewType,
    this.galleries,
    this.gallery,
  });

  final double dividingLineWidth;
  final Color dividingVerticalLineColor;
  final Color dividingHorizontalLineColor;
  final bool isShowMore;
  final ViewType viewType;
  final List<File?>? galleries;
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
              child: FadeAndSlideTransition(
                slideFrom: .left,
                slideFromOffset: .3,
                delayBeforeStart: const Duration(milliseconds: 500),
                isNoNeedTrigger: isShowMore ? true : false,
                child: SizedBox(
                  height: W.x11l + 4,
                  child: _ImageViewer(id: 1, viewType: viewType, image: galleries?[0], imageUrl: gallery?.imageURL1),
                ),
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
              child: FadeAndSlideTransition(
                slideFrom: .right,
                slideFromOffset: .3,
                delayBeforeStart: const Duration(milliseconds: 1000),
                isNoNeedTrigger: isShowMore ? true : false,
                child: SizedBox(
                  height: W.x11l + 4,
                  child: _ImageViewer(id: 2, viewType: viewType, image: galleries?[1], imageUrl: gallery?.imageURL2),
                ),
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
              child: FadeAndSlideTransition(
                slideFrom: .right,
                slideFromOffset: .3,
                delayBeforeStart: const Duration(milliseconds: 1000),
                isNoNeedTrigger: isShowMore ? true : false,
                child: SizedBox(
                  height: W.x11l + 4,
                  child: _ImageViewer(id: 3, viewType: viewType, image: galleries?[2], imageUrl: gallery?.imageURL3),
                ),
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
              child: FadeAndSlideTransition(
                slideFrom: .left,
                slideFromOffset: .3,
                delayBeforeStart: const Duration(milliseconds: 500),
                isNoNeedTrigger: isShowMore ? true : false,
                child: SizedBox(
                  height: W.x11l + 4,
                  child: _ImageViewer(id: 4, viewType: viewType, image: galleries?[3], imageUrl: gallery?.imageURL4),
                ),
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
              child: FadeAndSlideTransition(
                slideFrom: .bottom,
                slideFromOffset: .3,
                delayBeforeStart: const Duration(milliseconds: 1500),
                isNoNeedTrigger: isShowMore ? true : false,
                child: SizedBox(
                  height: W.x10l - 4,
                  child: _ImageViewer(id: 5, viewType: viewType, image: galleries?[4], imageUrl: gallery?.imageURL5),
                ),
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
              child: FadeAndSlideTransition(
                slideFrom: .bottom,
                slideFromOffset: .3,
                delayBeforeStart: const Duration(milliseconds: 1500),
                isNoNeedTrigger: isShowMore ? true : false,
                child: SizedBox(
                  height: W.x10l - 4,
                  child: _ImageViewer(id: 6, viewType: viewType, image: galleries?[5], imageUrl: gallery?.imageURL6),
                ),
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
              child: FadeAndSlideTransition(
                slideFrom: .bottom,
                slideFromOffset: .3,
                delayBeforeStart: const Duration(milliseconds: 1500),
                isNoNeedTrigger: isShowMore ? true : false,
                child: SizedBox(
                  height: W.x10l - 4,
                  child: _ImageViewer(id: 7, viewType: viewType, image: galleries?[6], imageUrl: gallery?.imageURL7),
                ),
              ),
            ),
            SizedBox(width: W.x4s),
          ],
        ),
        if (isShowMore) ...[
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
                flex: 5,
                child: FadeAndSlideTransition(
                  slideFrom: .bottom,
                  slideFromOffset: .3,
                  delayBeforeStart: const Duration(milliseconds: 2000),
                  isNoNeedTrigger: isShowMore ? true : false,
                  child: SizedBox(
                    height: W.x11l + 4,
                    child: _ImageViewer(id: 8, viewType: viewType, image: galleries?[7], imageUrl: gallery?.imageURL8),
                  ),
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
                child: FadeAndSlideTransition(
                  slideFrom: .bottom,
                  slideFromOffset: .3,
                  delayBeforeStart: const Duration(milliseconds: 2000),
                  isNoNeedTrigger: isShowMore ? true : false,
                  child: SizedBox(
                    height: W.x11l + 4,
                    child: _ImageViewer(id: 9, viewType: viewType, image: galleries?[8], imageUrl: gallery?.imageURL9),
                  ),
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
                child: FadeAndSlideTransition(
                  slideFrom: .bottom,
                  slideFromOffset: .3,
                  delayBeforeStart: const Duration(milliseconds: 2500),
                  isNoNeedTrigger: isShowMore ? true : false,
                  child: SizedBox(
                    height: W.x11l + 4,
                    child: _ImageViewer(id: 10, viewType: viewType, image: galleries?[9], imageUrl: gallery?.imageURL10),
                  ),
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
                child: FadeAndSlideTransition(
                  slideFrom: .bottom,
                  slideFromOffset: .3,
                  delayBeforeStart: const Duration(milliseconds: 2500),
                  isNoNeedTrigger: isShowMore ? true : false,
                  child: SizedBox(
                    height: W.x11l + 4,
                    child: _ImageViewer(id: 11, viewType: viewType, image: galleries?[10], imageUrl: gallery?.imageURL11),
                  ),
                ),
              ),
              SizedBox(width: W.x4s),
            ],
          ),
        ],
        SizedBox(height: H.x2s),
      ],
    );
  }
}

class _ImageViewer extends StatelessWidget {
  const _ImageViewer({required this.id, required this.viewType, this.image, this.imageUrl});

  final int id;
  final ViewType viewType;
  final File? image;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(borderRadius: .circular(8), child: _content(context, 'image_$id'));
  }

  Widget _content(BuildContext context, String tag) {
    Widget wrapper(Widget itemImage, Widget detailImage) {
      return GestureDetector(
        onTap: () => Navigator.push(
          context,
          ZoomImageRoute(
            page: ZoomImagePage(image: detailImage, tag: tag),
          ),
        ),
        child: Hero(tag: tag, child: itemImage),
      );
    }

    if (viewType == ViewType.preview) {
      if (image != null) return wrapper(Image.file(image!, fit: .cover), Image.file(image!, fit: .contain));
    } else if (viewType == ViewType.example) {
      if (imageUrl != null) {
        return wrapper(
          Image.asset(imageUrl!, fit: .cover, package: 'iv_project_invitation_theme'),
          Image.asset(imageUrl!, fit: .contain, package: 'iv_project_invitation_theme'),
        );
      }
    } else {
      if (imageUrl != null) {
        return wrapper(Image.network(imageUrl!, fit: .cover), Image.network(imageUrl!, fit: .contain));
      }
    }

    return const ColoredBox(color: Colors.grey);
  }
}
