import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:iv_project_widget_core/iv_project_widget_core.dart';

class const VerticalGallery({
  super.key,
  final bool isShowMore = false,
  required final ViewType viewType,
  final List<File?>? galleries,
  final GalleryResponse? gallery,
}) extends StatelessWidget {
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
                  child: _ImageViewer(
                    id: 1,
                    viewType: viewType,
                    image: galleries?[0],
                    imageUrl: gallery?.imageURL1,
                  ),
                ),
              ),
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
                  child: _ImageViewer(
                    id: 2,
                    viewType: viewType,
                    image: galleries?[1],
                    imageUrl: gallery?.imageURL2,
                  ),
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
              flex: 3,
              child: FadeAndSlideTransition(
                slideFrom: .right,
                slideFromOffset: .3,
                delayBeforeStart: const Duration(milliseconds: 1000),
                isNoNeedTrigger: isShowMore ? true : false,
                child: SizedBox(
                  height: W.x11l + 4,
                  child: _ImageViewer(
                    id: 3,
                    viewType: viewType,
                    image: galleries?[2],
                    imageUrl: gallery?.imageURL3,
                  ),
                ),
              ),
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
                  child: _ImageViewer(
                    id: 4,
                    viewType: viewType,
                    image: galleries?[3],
                    imageUrl: gallery?.imageURL4,
                  ),
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
              flex: 5,
              child: FadeAndSlideTransition(
                slideFrom: isShowMore ? .left : .bottom,
                slideFromOffset: .3,
                delayBeforeStart: const Duration(milliseconds: 1500),
                isNoNeedTrigger: isShowMore ? true : false,
                child: SizedBox(
                  height: W.x11l + 4,
                  child: _ImageViewer(
                    id: 5,
                    viewType: viewType,
                    image: galleries?[4],
                    imageUrl: gallery?.imageURL8,
                  ),
                ),
              ),
            ),
            SizedBox(width: W.x7s),
            Expanded(
              flex: 3,
              child: FadeAndSlideTransition(
                slideFrom: isShowMore ? .right : .bottom,
                slideFromOffset: .3,
                delayBeforeStart: Duration(milliseconds: isShowMore ? 2000 : 1500),
                isNoNeedTrigger: isShowMore ? true : false,
                child: SizedBox(
                  height: W.x11l + 4,
                  child: _ImageViewer(
                    id: 6,
                    viewType: viewType,
                    image: galleries?[5],
                    imageUrl: gallery?.imageURL9,
                  ),
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
                flex: 3,
                child: FadeAndSlideTransition(
                  slideFrom: isShowMore ? .right : .bottom,
                  slideFromOffset: .3,
                  delayBeforeStart: const Duration(milliseconds: 2000),
                  isNoNeedTrigger: isShowMore ? true : false,
                  child: SizedBox(
                    height: W.x11l + 4,
                    child: _ImageViewer(
                      id: 7,
                      viewType: viewType,
                      image: galleries?[6],
                      imageUrl: gallery?.imageURL10,
                    ),
                  ),
                ),
              ),
              SizedBox(width: W.x7s),
              Expanded(
                flex: 5,
                child: FadeAndSlideTransition(
                  slideFrom: isShowMore ? .left : .bottom,
                  slideFromOffset: .3,
                  delayBeforeStart: const Duration(milliseconds: 1500),
                  isNoNeedTrigger: isShowMore ? true : false,
                  child: SizedBox(
                    height: W.x11l + 4,
                    child: _ImageViewer(
                      id: 8,
                      viewType: viewType,
                      image: galleries?[7],
                      imageUrl: gallery?.imageURL11,
                    ),
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
                child: FadeAndSlideTransition(
                  slideFrom: .bottom,
                  slideFromOffset: .3,
                  delayBeforeStart: const Duration(milliseconds: 2500),
                  isNoNeedTrigger: isShowMore ? true : false,
                  child: SizedBox(
                    height: W.x10l + 4,
                    child: _ImageViewer(
                      id: 9,
                      viewType: viewType,
                      image: galleries?[8],
                      imageUrl: gallery?.imageURL5,
                    ),
                  ),
                ),
              ),
              SizedBox(width: W.x7s),
              Expanded(
                child: FadeAndSlideTransition(
                  slideFrom: .bottom,
                  slideFromOffset: .3,
                  delayBeforeStart: const Duration(milliseconds: 2500),
                  isNoNeedTrigger: isShowMore ? true : false,
                  child: SizedBox(
                    height: W.x10l + 4,
                    child: _ImageViewer(
                      id: 10,
                      viewType: viewType,
                      image: galleries?[9],
                      imageUrl: gallery?.imageURL6,
                    ),
                  ),
                ),
              ),
              SizedBox(width: W.x7s),
              Expanded(
                child: FadeAndSlideTransition(
                  slideFrom: .bottom,
                  slideFromOffset: .3,
                  delayBeforeStart: const Duration(milliseconds: 2500),
                  isNoNeedTrigger: isShowMore ? true : false,
                  child: SizedBox(
                    height: W.x10l + 4,
                    child: _ImageViewer(
                      id: 11,
                      viewType: viewType,
                      image: galleries?[10],
                      imageUrl: gallery?.imageURL7,
                    ),
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

class const _ImageViewer({
  required final int id,
  required final ViewType viewType,
  final File? image,
  final String? imageUrl,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(borderRadius: .circular(2), child: _content(context, 'image_$id'));
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
