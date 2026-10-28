import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/elysian_configs.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/widgets/elysian_reveal.dart';
import 'package:iv_project_invitation_theme/src/widgets/double_arrow_slider.dart';
import 'package:iv_project_model/iv_project_model.dart';

class const ElysianSixthPage({
  super.key,
  required final ElysianSixthPageConfig config,
  required final ViewType viewType,
  final List<File?>? galleries,
  final GalleryResponse? gallery,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    final imageList = _buildImageList();

    return BlocSelector<InvitationThemeCoreCubit, InvitationThemeCoreState, Size>(
      selector: (state) => state.size,
      builder: (_, size) => Container(
        height: size.height,
        width: size.width,
        color: config.backgroundColor,
        padding: const .symmetric(vertical: 28),
        child: Column(
          children: [
            ElysianReveal(
              delay: const Duration(milliseconds: 100),
              child: Padding(
                padding: const .symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Text(
                      langCode == 'en' ? 'OUR MOMENTS' : 'GALERI KISAH KAMI',
                      style: TextStyle(
                        color: config.titleColor,
                        fontSize: 12,
                        letterSpacing: 4,
                        fontWeight: .w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      langCode == 'en' ? 'A glimpse of our sacred journey together' : 'Setiap detik kisah yang terukir abadi',
                      style: TextStyle(
                        color: config.subtitleColor,
                        fontSize: 12,
                        fontStyle: .italic,
                      ),
                      textAlign: .center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ElysianReveal(
                delay: const Duration(milliseconds: 250),
                child: ListView.separated(
                  padding: const .symmetric(horizontal: 24),
                  scrollDirection: .horizontal,
                  itemCount: imageList.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 16),
                  itemBuilder: (_, index) => Center(
                    child: Container(
                      width: 250,
                      height: size.height * 0.58,
                      decoration: BoxDecoration(
                        borderRadius: .circular(24),
                        border: Border.all(
                          color: config.cardBorderColor,
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: .3),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      clipBehavior: .antiAlias,
                      child: imageList[index],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElysianReveal(
              delay: const Duration(milliseconds: 400),
              child: Row(
                mainAxisAlignment: .center,
                children: [
                  DoubleArrowSlider(
                    axis: .horizontal,
                    firstArrowColor: config.titleColor,
                    secondArrowColor: config.titleColor.withValues(alpha: .4),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    langCode == 'en' ? 'Swipe to explore' : 'Geser untuk melihat',
                    style: TextStyle(
                      color: config.subtitleColor,
                      fontSize: 12,
                      fontWeight: .w500,
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

  List<Widget> _buildImageList() {
    final list = <Widget>[];

    final urls = [
      gallery?.imageURL1,
      gallery?.imageURL2,
      gallery?.imageURL3,
      gallery?.imageURL4,
      gallery?.imageURL5,
      gallery?.imageURL6,
      gallery?.imageURL7,
      gallery?.imageURL8,
      gallery?.imageURL9,
      gallery?.imageURL10,
    ];

    for (var i = 0; i < 10; i++) {
      final file = galleries != null && galleries!.length > i ? galleries![i] : null;
      final url = urls[i];

      if (viewType == .preview && file != null) {
        list.add(Image.file(file, fit: .cover));
      } else if (viewType == .example && url != null) {
        list.add(Image.asset(url, fit: .cover, package: 'iv_project_invitation_theme'));
      } else if (url != null && url.isNotEmpty) {
        list.add(Image.network(url, fit: .cover));
      }
    }

    if (list.isEmpty) {
      list.add(
        Container(
          color: Colors.grey.shade900,
          child: const Center(
            child: Icon(Icons.photo_library_outlined, color: Colors.white38, size: 48),
          ),
        ),
      );
    }

    return list;
  }
}
