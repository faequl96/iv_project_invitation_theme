import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/gemini_star_configs.dart';
import 'package:iv_project_invitation_theme/src/widgets/auto_size_transition.dart';
import 'package:iv_project_invitation_theme/src/widgets/double_arrow_slider.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:iv_project_widget_core/iv_project_widget_core.dart';

class GeminiStarSixthPage extends StatelessWidget {
  const GeminiStarSixthPage({
    super.key,
    required this.config,
    required this.viewType,
    this.galleries,
    this.gallery,
  });

  final GeminiStarSixthPageConfig config;
  final ViewType viewType;
  final List<File?>? galleries;
  final GalleryResponse? gallery;

  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    return BlocSelector<InvitationThemeCoreCubit, InvitationThemeCoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => Stack(
        alignment: .center,
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
            bottom: 0,
            height: Screen.height,
            width: Screen.width,
            child: Column(
              mainAxisAlignment: .center,
              children: [
                SizedBox(
                  height: H.x17l,
                  child: Column(
                    children: [
                      const Spacer(),
                      Row(
                        mainAxisAlignment: .end,
                        children: [
                          DoubleArrowSlider(
                            axis: .horizontal,
                            firstArrowColor: Colors.grey.shade300,
                            secondArrowColor: Colors.grey.shade500,
                          ),
                          SizedBox(width: W.x14s),
                          Text(
                            'Geser ke kiri',
                            style: TextStyle(color: Colors.grey.shade200, fontWeight: .w600),
                          ),
                          SizedBox(width: W.x6s),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const .only(),
                    child: AutoSizeTransition(
                      child: _Gallery(
                        dividingLineWidth: config.dividingLineWidth,
                        dividingVerticalLineColor: config.dividingVerticalLineColor,
                        dividingHorizontalLineColor: config.dividingHorizontalLineColor,
                        viewType: viewType,
                        galleries: galleries,
                        gallery: gallery,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: H.x15l),
              ],
            ),
          ),

          Positioned(
            left: (-Screen.height / 2) + W.sm / 2,
            child: Transform.rotate(angle: -(pi / 2), child: _buildTitle(langCode)),
          ),

          if (config.decorationBuilder != null)
            SizedBox(
              height: Screen.height,
              width: Screen.width,
              child: config.decorationBuilder!(),
            ),
        ],
      ),
    );
  }

  Widget _buildTitle(String langCode) => SizedBox(
    height: W.sm,
    width: Screen.height,
    child: Row(
      crossAxisAlignment: .center,
      children: [
        SizedBox(
          width: H.x15l,
          child: ColoredBox(
            color: Colors.grey.shade400.withValues(alpha: .2),
            child: Row(
              children: [
                const Spacer(),
                Column(
                  mainAxisAlignment: .center,
                  children: [
                    FadeAndSlideTransition(
                      slideFromOffset: 1.5,
                      slideFrom: .left,
                      child: Text(
                        langCode == 'en' ? 'Gallery' : 'Galeri',
                        style: AppFonts.inter(
                          color: config.titlePageColor,
                          fontSize: FontSize.x3l,
                          fontWeight: .w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                  ],
                ),
                SizedBox(width: H.x3s),
              ],
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: W.sm,
            child: ColoredBox(color: Colors.grey.shade800.withValues(alpha: .75)),
          ),
        ),
        SizedBox(
          width: H.x17l,
          child: ColoredBox(
            color: Colors.grey.shade400.withValues(alpha: .2),
            child: Row(
              children: [
                SizedBox(width: H.x3s),
                Column(
                  mainAxisAlignment: .center,
                  children: [
                    FadeAndSlideTransition(
                      slideFromOffset: 2.5,
                      slideFrom: .right,
                      child: Text(
                        langCode == 'en' ? 'Gallery' : 'Galeri',
                        style: AppFonts.inter(
                          color: config.titlePageColor,
                          fontSize: FontSize.x3l,
                          fontWeight: .w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                  ],
                ),
                const Spacer(),
              ],
            ),
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
    required this.viewType,
    this.galleries,
    this.gallery,
  });

  final double dividingLineWidth;
  final Color dividingVerticalLineColor;
  final Color dividingHorizontalLineColor;
  final ViewType viewType;
  final List<File?>? galleries;
  final GalleryResponse? gallery;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: .horizontal,
      child: Padding(
        padding: .only(left: W.sm, right: W.x11s),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: .start,
                children: [
                  SizedBox(
                    height: .infinity,
                    width: W.x10l * 2.1,
                    child: ColoredBox(
                      color: Colors.grey.shade800,
                      child: Center(
                        child: Transform.rotate(
                          angle: -(pi / 20),
                          child: Text(
                            'Our Moments',
                            style: AppFonts.pacifico(
                              color: Colors.grey.shade400,
                              fontSize: W.xs,
                              fontStyle: .italic,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: W.x11s),
                  SizedBox(
                    height: .infinity,
                    width: W.x5l * 1.9,
                    child: _ImageViewer(
                      id: 1,
                      viewType: viewType,
                      image: galleries?[0],
                      imageUrl: gallery?.imageURL1,
                    ),
                  ),
                  SizedBox(width: W.x11s),
                  SizedBox(
                    height: .infinity,
                    width: W.x10l * 2.1,
                    child: _ImageViewer(
                      id: 2,
                      viewType: viewType,
                      image: galleries?[1],
                      imageUrl: gallery?.imageURL2,
                    ),
                  ),
                  SizedBox(width: W.x11s),
                  SizedBox(
                    height: .infinity,
                    width: W.x5l * 1.9,
                    child: _ImageViewer(
                      id: 1,
                      viewType: viewType,
                      image: galleries?[2],
                      imageUrl: gallery?.imageURL3,
                    ),
                  ),
                  SizedBox(width: W.x11s),
                  SizedBox(
                    height: .infinity,
                    width: W.x10l * 2.1,
                    child: _ImageViewer(
                      id: 2,
                      viewType: viewType,
                      image: galleries?[3],
                      imageUrl: gallery?.imageURL4,
                    ),
                  ),
                  SizedBox(width: W.x11s),
                  SizedBox(
                    height: .infinity,
                    width: W.x5l * 1.9,
                    child: _ImageViewer(
                      id: 1,
                      viewType: viewType,
                      image: galleries?[4],
                      imageUrl: gallery?.imageURL5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: W.x11s),
            Expanded(
              child: Row(
                mainAxisAlignment: .start,
                children: [
                  SizedBox(
                    height: .infinity,
                    width: W.x5l * 1.9,
                    child: _ImageViewer(
                      id: 1,
                      viewType: viewType,
                      image: galleries?[5],
                      imageUrl: gallery?.imageURL6,
                    ),
                  ),
                  SizedBox(width: W.x11s),
                  SizedBox(
                    height: .infinity,
                    width: W.x10l * 2.1,
                    child: _ImageViewer(
                      id: 2,
                      viewType: viewType,
                      image: galleries?[6],
                      imageUrl: gallery?.imageURL7,
                    ),
                  ),
                  SizedBox(width: W.x11s),
                  SizedBox(
                    height: .infinity,
                    width: W.x5l * 1.9,
                    child: _ImageViewer(
                      id: 1,
                      viewType: viewType,
                      image: galleries?[7],
                      imageUrl: gallery?.imageURL8,
                    ),
                  ),
                  SizedBox(width: W.x11s),
                  SizedBox(
                    height: .infinity,
                    width: W.x10l * 2.1,
                    child: _ImageViewer(
                      id: 2,
                      viewType: viewType,
                      image: galleries?[8],
                      imageUrl: gallery?.imageURL9,
                    ),
                  ),
                  SizedBox(width: W.x11s),
                  SizedBox(
                    height: .infinity,
                    width: W.x5l * 1.9,
                    child: _ImageViewer(
                      id: 1,
                      viewType: viewType,
                      image: galleries?[9],
                      imageUrl: gallery?.imageURL10,
                    ),
                  ),
                  SizedBox(width: W.x11s),
                  SizedBox(
                    height: .infinity,
                    width: W.x10l * 2.1,
                    child: _ImageViewer(
                      id: 2,
                      viewType: viewType,
                      image: galleries?[10],
                      imageUrl: gallery?.imageURL11,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
    return _content(context, 'image_$id');
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

    if (viewType == .preview) {
      if (image != null) {
        return wrapper(Image.file(image!, fit: .cover), Image.file(image!, fit: .contain));
      }
    } else if (viewType == .example) {
      if (imageUrl != null) {
        return wrapper(
          Image.asset(imageUrl!, fit: .cover, package: 'iv_project_invitation_theme'),
          Image.asset(imageUrl!, fit: .contain, package: 'iv_project_invitation_theme'),
        );
      }
    } else {
      if (imageUrl != null) {
        return wrapper(
          Image.network(imageUrl!, fit: .cover),
          Image.network(imageUrl!, fit: .contain),
        );
      }
    }

    return const ColoredBox(color: Colors.grey);
  }
}
