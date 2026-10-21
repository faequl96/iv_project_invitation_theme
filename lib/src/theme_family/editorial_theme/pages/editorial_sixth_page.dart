import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/editorial_theme/editorial_configs.dart';
import 'package:iv_project_invitation_theme/src/widgets/double_arrow_slider.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:iv_project_widget_core/iv_project_widget_core.dart';

class const EditorialSixthPage({
  super.key,
  required final EditorialSixthPageConfig config,
  required final ViewType viewType,
  final List<File?>? galleries,
  final GalleryResponse? gallery,
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
          crossAxisAlignment: .start,
          children: [
            FadeAndSlideTransition(
              slideFrom: .top,
              slideFromOffset: .3,
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(
                    langCode == 'en' ? 'LOOKBOOK' : 'GALERI FOTO',
                    style: TextStyle(
                      color: config.headerTitleColor,
                      fontSize: 11,
                      fontWeight: .bold,
                      letterSpacing: 2,
                    ),
                  ),
                  Text(
                    'OUR MOMENTS',
                    style: TextStyle(
                      color: config.subtitleColor,
                      fontSize: 10,
                      fontWeight: .w600,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Spacer(),
            SizedBox(
              height: H.x22l,
              child: FadeAndSlideTransition(
                slideFrom: .bottom,
                slideFromOffset: .2,
                child: _Gallery(viewType: viewType, galleries: galleries, gallery: gallery),
              ),
            ),
            const SizedBox(height: 8),
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
                  style: TextStyle(color: Colors.grey.shade600, fontWeight: .w600),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class const _Gallery({
  required final ViewType viewType,
  final List<File?>? galleries,
  final GalleryResponse? gallery,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: .horizontal,
      child: Padding(
        padding: .only(right: W.x11s),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: .start,
                children: [
                  SizedBox(
                    height: .infinity,
                    width: W.x12l * 2.1,
                    child: ColoredBox(
                      color: Colors.grey.shade800,
                      child: Column(
                        mainAxisAlignment: .center,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: W.x6s),
                              Transform.rotate(
                                angle: -(pi / 20),
                                child: Text(
                                  'A glimpse of our journey.',
                                  style: AppFonts.pacifico(
                                    color: Colors.grey.shade400,
                                    fontSize: FontSize.md,
                                    fontStyle: .italic,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: H.x8s),
                          Transform.rotate(
                            angle: -(pi / 20),
                            child: Padding(
                              padding: .symmetric(horizontal: W.x6s),
                              child: Text(
                                'Moments captured in time.',
                                style: AppFonts.pacifico(
                                  color: Colors.grey.shade400,
                                  fontSize: FontSize.x6l,
                                  fontStyle: .italic,
                                  height: 1.3,
                                ),
                                textAlign: .center,
                              ),
                            ),
                          ),
                          SizedBox(height: H.x8s),
                          Row(
                            mainAxisAlignment: .end,
                            children: [
                              Transform.rotate(
                                angle: -(pi / 20),
                                child: Text(
                                  'The start of forever.',
                                  style: AppFonts.pacifico(
                                    color: Colors.grey.shade400,
                                    fontSize: FontSize.md,
                                    fontStyle: .italic,
                                  ),
                                ),
                              ),
                              SizedBox(width: W.x6s),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: W.x11s),
                  SizedBox(
                    height: .infinity,
                    width: W.x8l * 1.9,
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
                    width: W.x12l * 2.1,
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
                    width: W.x8l * 1.9,
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
                    width: W.x12l * 2.1,
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
                    width: W.x8l * 1.9,
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
                    width: W.x8l * 1.9,
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
                    width: W.x12l * 2.1,
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
                    width: W.x8l * 1.9,
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
                    width: W.x12l * 2.1,
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
                    width: W.x8l * 1.9,
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
                    width: W.x12l * 2.1,
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

class const _ImageViewer({
  required final int id,
  required final ViewType viewType,
  final File? image,
  final String? imageUrl,
}) extends StatelessWidget {
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
