import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/editorial_theme/editorial_configs.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_model/iv_project_model.dart';

class const EditorialSecondPage({
  super.key,
  required final EditorialSecondPageConfig config,
  required final ViewType viewType,
  final File? brideImage,
  required final BridegroomResponse bride,
}) extends StatefulWidget {
  @override
  State<EditorialSecondPage> createState() => _EditorialSecondPageState();
}

class _EditorialSecondPageState() extends State<EditorialSecondPage> {
  Widget? _cachedImage;

  @override
  void initState() {
    super.initState();
    _buildCachedImage();
  }

  void _buildCachedImage() {
    if (widget.viewType == .preview && widget.brideImage != null) {
      _cachedImage = Image.file(
        widget.brideImage!,
        height: double.infinity,
        width: double.infinity,
        fit: .cover,
      );
    } else if (widget.viewType == .example) {
      _cachedImage = Image.asset(
        widget.bride.imageUrl,
        height: double.infinity,
        width: double.infinity,
        fit: .cover,
        package: 'iv_project_invitation_theme',
      );
    } else {
      _cachedImage = Image.network(
        widget.bride.imageUrl,
        height: double.infinity,
        width: double.infinity,
        fit: .cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    return BlocSelector<InvitationThemeCoreCubit, InvitationThemeCoreState, Size>(
      selector: (state) => state.size,
      builder: (_, size) => Container(
        height: size.height,
        width: size.width,
        color: widget.config.backgroundColor,
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
                    langCode == 'en' ? 'PROFILE 01' : 'PROFIL 01',
                    style: TextStyle(
                      color: widget.config.roleTagColor,
                      fontSize: 11,
                      fontWeight: .bold,
                      letterSpacing: 2,
                    ),
                  ),
                  Text(
                    langCode == 'en' ? 'THE BRIDE' : 'MEMPELAI WANITA',
                    style: TextStyle(
                      color: widget.config.nameColor,
                      fontSize: 11,
                      fontWeight: .w700,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FadeAndSlideTransition(
                slideFrom: .bottom,
                slideFromOffset: .2,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: .circular(4),
                    border: .all(color: widget.config.borderColor),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .06),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  clipBehavior: .antiAlias,
                  child:
                      _cachedImage ??
                      Container(
                        color: Colors.grey.shade200,
                        child: const Center(
                          child: Icon(Icons.person, color: Colors.grey, size: 50),
                        ),
                      ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            FadeAndSlideTransition(
              slideFrom: .bottom,
              slideFromOffset: .3,
              child: Container(
                width: double.infinity,
                padding: const .all(16),
                decoration: BoxDecoration(
                  color: widget.config.cardBackgroundColor,
                  borderRadius: .circular(4),
                  border: .all(color: widget.config.borderColor),
                ),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    _buildBrideGroomText(
                      frontTitle: widget.bride.frontTitle,
                      fullName: widget.bride.fullName,
                      backTitle: widget.bride.backTitle,
                      generalColor: widget.config.nameColor,
                    ),
                    SizedBox(height: H.x8s),
                    _buildFatherMotherText(
                      fatherFrontTitle: widget.bride.fatherFrontTitle,
                      fatherName: widget.bride.fatherName,
                      fatherBackTitle: widget.bride.fatherBackTitle,
                      motherFrontTitle: widget.bride.motherFrontTitle,
                      motherName: widget.bride.motherName,
                      motherBackTitle: widget.bride.motherBackTitle,
                      generalColor: widget.config.parentTextColor,
                      langCode: langCode,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBrideGroomText({
    String? frontTitle,
    required String fullName,
    String? backTitle,
    required Color generalColor,
  }) {
    return Text.rich(
      TextSpan(
        children: [
          if ((frontTitle ?? '').isNotEmpty)
            TextSpan(
              text: '$frontTitle ',
              style: const TextStyle(fontWeight: .w500),
            ),
          TextSpan(
            text: fullName,
            style: const TextStyle(fontWeight: .w700),
          ),
          if ((backTitle ?? '').isNotEmpty)
            TextSpan(
              text: ', $backTitle',
              style: const TextStyle(fontWeight: .w500),
            ),
        ],
      ),
      style: TextStyle(fontSize: FontSize.x3l, color: generalColor, height: 1.2),
      textAlign: .left,
    );
  }

  Widget _buildFatherMotherText({
    String? fatherFrontTitle,
    required String fatherName,
    String? fatherBackTitle,
    String? motherFrontTitle,
    required String motherName,
    String? motherBackTitle,
    required Color generalColor,
    required String langCode,
  }) {
    String prefix(bool isFather) =>
        isFather ? (langCode == 'en' ? 'Mr. ' : 'Bp. ') : (langCode == 'en' ? 'Mrs. ' : 'Ibu ');

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: langCode == 'en' ? 'Daughter of ' : 'Putri dari '),
          TextSpan(text: prefix(true)),
          if ((fatherFrontTitle ?? '').isNotEmpty)
            TextSpan(
              text: '$fatherFrontTitle ',
              style: const TextStyle(fontWeight: .w500),
            ),
          TextSpan(
            text: fatherName,
            style: const TextStyle(fontWeight: .w700),
          ),
          if ((fatherBackTitle ?? '').isNotEmpty)
            TextSpan(
              text: ', $fatherBackTitle',
              style: const TextStyle(fontWeight: .w500),
            ),
          const TextSpan(text: ' & '),
          TextSpan(text: prefix(false)),
          if ((motherFrontTitle ?? '').isNotEmpty)
            TextSpan(
              text: '$motherFrontTitle ',
              style: const TextStyle(fontWeight: .w500),
            ),
          TextSpan(
            text: motherName,
            style: const TextStyle(fontWeight: .w700),
          ),
          if ((motherBackTitle ?? '').isNotEmpty)
            TextSpan(
              text: ', $motherBackTitle',
              style: const TextStyle(fontWeight: .w500),
            ),
        ],
      ),
      style: TextStyle(fontSize: FontSize.sm, color: generalColor, height: 1.2),
    );
  }
}
