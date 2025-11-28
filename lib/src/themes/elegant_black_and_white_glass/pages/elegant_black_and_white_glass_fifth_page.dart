import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/core/utils/h.dart';
import 'package:iv_project_invitation_theme/src/core/utils/w.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_invitation_theme/src/widgets/glass_effect_box.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class ElegantBlackAndWhiteGlassFifthPage extends StatelessWidget {
  const ElegantBlackAndWhiteGlassFifthPage({super.key, required this.previewType, this.galleries, this.gallery});

  final ThemePreviewType previewType;
  final List<File?>? galleries;
  final GalleryResponse? gallery;

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
                width: ScreenSize.width,
                child: Row(
                  mainAxisAlignment: .center,
                  children: [
                    Icon(Icons.photo_library_rounded, size: W.xs, color: Colors.grey.shade900),
                    const SizedBox(width: 10),
                    Text(
                      langCode == 'en' ? 'Our Gallery' : 'Galeri Kami',
                      style: AppFonts.inter(color: Colors.grey.shade900, fontSize: FontSize.x3l, fontWeight: .w700),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            height: ScreenSize.height,
            width: ScreenSize.width,
            child: Padding(
              padding: .only(top: H.x6l, left: W.x6s, right: W.x6s, bottom: 76),
              child: ClipRRect(
                borderRadius: .circular(20),
                child: BackdropFilter(
                  filter: .blur(sigmaX: 3, sigmaY: 3),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: .topCenter,
                        end: .bottomCenter,
                        colors: [Colors.black.withValues(alpha: .6), Colors.black.withValues(alpha: .5)],
                        stops: const [0, 1],
                      ),
                      borderRadius: .circular(20),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            height: ScreenSize.height,
            width: ScreenSize.width,
            child: Padding(
              padding: .only(top: H.x6l, left: W.x6s, right: W.x6s, bottom: 76),
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
                      _Gallery(previewType: previewType, galleries: galleries, gallery: gallery),
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
                                useHandleBar: true,
                                handleColor: Colors.grey.shade500,
                                action: HeaderAction(
                                  actionIcon: Icons.close_rounded,
                                  iconColor: Colors.grey.shade400,
                                  onTap: () => NavigationService.pop(),
                                ),
                              ),
                              decoration: BottomSheetDecoration(
                                color: Colors.black.withValues(alpha: .85),
                                borderRadius: const .only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                              ),
                              contentBuilder: (_) {
                                return SizedBox(
                                  height: ScreenSize.height - H.x10l,
                                  child: Padding(
                                    padding: .only(left: W.x6s, right: W.x6s, bottom: W.x6s),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade700.withValues(alpha: .5),
                                        borderRadius: .circular(16),
                                      ),
                                      child: SingleChildScrollView(
                                        child: _Gallery(
                                          isShowMore: true,
                                          previewType: previewType,
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
                          border: .all(width: .5, color: Colors.grey.shade500),
                          color: Colors.black.withValues(alpha: .5),
                          child: Stack(
                            alignment: .center,
                            children: [
                              Text(
                                langCode == 'en' ? 'See More' : 'Selengkapnya',
                                style: AppFonts.inter(color: Colors.grey.shade50, fontSize: FontSize.md, fontWeight: .w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: H.xs),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            height: ScreenSize.height,
            width: ScreenSize.width,
            child: Padding(
              padding: .only(top: H.x6l, left: W.x6s, right: W.x6s, bottom: 76),
              child: GlassEffectBox(
                width: ScreenSize.width - 32,
                height: ScreenSize.height - (76 + H.x6l),
                borderRadius: 20,
                sliderWidth: 90,
                color: Colors.white.withValues(alpha: .5),
                animationSpeed: const Duration(milliseconds: 600),
                delayBeforeStart: const Duration(milliseconds: 3500),
                animationInterval: const Duration(seconds: 4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Gallery extends StatelessWidget {
  const _Gallery({this.isShowMore = false, required this.previewType, this.galleries, this.gallery});

  final bool isShowMore;
  final ThemePreviewType previewType;
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
                  child: _ImageViewer(previewType: previewType, image: galleries?[0], imageUrl: gallery?.imageURL1),
                ),
              ),
            ),
            SizedBox(width: W.x7s),
            SizedBox(
              height: W.x11l + 4,
              width: .5,
              child: ColoredBox(color: Colors.grey.shade500),
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
                  child: _ImageViewer(previewType: previewType, image: galleries?[1], imageUrl: gallery?.imageURL2),
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
              child: SizedBox(height: .5, child: ColoredBox(color: Colors.grey.shade500)),
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
                  child: _ImageViewer(previewType: previewType, image: galleries?[2], imageUrl: gallery?.imageURL3),
                ),
              ),
            ),
            SizedBox(width: W.x7s),
            SizedBox(
              height: W.x11l + 4,
              width: .5,
              child: ColoredBox(color: Colors.grey.shade500),
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
                  child: _ImageViewer(previewType: previewType, image: galleries?[3], imageUrl: gallery?.imageURL4),
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
              child: SizedBox(height: .5, child: ColoredBox(color: Colors.grey.shade500)),
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
                  height: W.x9l + 8,
                  child: _ImageViewer(previewType: previewType, image: galleries?[4], imageUrl: gallery?.imageURL5),
                ),
              ),
            ),
            SizedBox(width: W.x7s),
            SizedBox(
              height: W.x9l + 8,
              width: .5,
              child: ColoredBox(color: Colors.grey.shade500),
            ),
            SizedBox(width: W.x7s),
            Expanded(
              child: FadeAndSlideTransition(
                slideFrom: .bottom,
                slideFromOffset: .3,
                delayBeforeStart: const Duration(milliseconds: 1500),
                isNoNeedTrigger: isShowMore ? true : false,
                child: SizedBox(
                  height: W.x9l + 8,
                  child: _ImageViewer(previewType: previewType, image: galleries?[5], imageUrl: gallery?.imageURL6),
                ),
              ),
            ),
            SizedBox(width: W.x7s),
            SizedBox(
              height: W.x9l + 8,
              width: .5,
              child: ColoredBox(color: Colors.grey.shade500),
            ),
            SizedBox(width: W.x7s),
            Expanded(
              child: FadeAndSlideTransition(
                slideFrom: .bottom,
                slideFromOffset: .3,
                delayBeforeStart: const Duration(milliseconds: 1500),
                isNoNeedTrigger: isShowMore ? true : false,
                child: SizedBox(
                  height: W.x9l + 8,
                  child: _ImageViewer(previewType: previewType, image: galleries?[6], imageUrl: gallery?.imageURL7),
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
                child: SizedBox(height: .5, child: ColoredBox(color: Colors.grey.shade500)),
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
                    child: _ImageViewer(previewType: previewType, image: galleries?[7], imageUrl: gallery?.imageURL8),
                  ),
                ),
              ),
              SizedBox(width: W.x7s),
              SizedBox(
                height: W.x11l + 4,
                width: .5,
                child: ColoredBox(color: Colors.grey.shade500),
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
                    child: _ImageViewer(previewType: previewType, image: galleries?[8], imageUrl: gallery?.imageURL9),
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
                child: SizedBox(height: .5, child: ColoredBox(color: Colors.grey.shade500)),
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
                    child: _ImageViewer(previewType: previewType, image: galleries?[9], imageUrl: gallery?.imageURL10),
                  ),
                ),
              ),
              SizedBox(width: W.x7s),
              SizedBox(
                height: W.x11l + 4,
                width: .5,
                child: ColoredBox(color: Colors.grey.shade500),
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
                    child: _ImageViewer(previewType: previewType, image: galleries?[10], imageUrl: gallery?.imageURL11),
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
  const _ImageViewer({required this.previewType, this.image, this.imageUrl});

  final ThemePreviewType previewType;
  final File? image;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return previewType == ThemePreviewType.fromRaw
        ? (image != null)
              ? ClipRRect(
                  borderRadius: .circular(8),
                  child: Image.file(image!, fit: BoxFit.cover),
                )
              : DecoratedBox(
                  decoration: BoxDecoration(borderRadius: .circular(8), color: Colors.grey),
                )
        : (imageUrl ?? '').isNotEmpty
        ? ClipRRect(
            borderRadius: .circular(8),
            child: Image.network(imageUrl!, fit: BoxFit.cover),
          )
        : DecoratedBox(
            decoration: BoxDecoration(borderRadius: .circular(8), color: Colors.grey),
          );
  }
}
