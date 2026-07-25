import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/gemini_star_configs.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_model/iv_project_model.dart';

class GeminiStarThirdPage extends StatefulWidget {
  const GeminiStarThirdPage({
    super.key,
    required this.config,
    required this.viewType,
    this.groomImage,
    required this.groom,
  });

  final GeminiStarThirdPageConfig config;
  final ViewType viewType;
  final File? groomImage;
  final BridegroomResponse groom;

  @override
  State<GeminiStarThirdPage> createState() => _GeminiStarThirdPageState();
}

class _GeminiStarThirdPageState extends State<GeminiStarThirdPage> {
  Widget? _cachedImage;

  @override
  void initState() {
    super.initState();

    _buildCachedImage();
  }

  void _buildCachedImage() {
    if (widget.viewType == .preview && widget.groomImage != null) {
      _cachedImage = Image.file(widget.groomImage!, fit: .cover);
    } else if (widget.viewType == .example) {
      _cachedImage = Image.asset(
        widget.groom.imageUrl,
        fit: .cover,
        package: 'iv_project_invitation_theme',
      );
    } else {
      _cachedImage = Image.network(widget.groom.imageUrl, fit: .cover);
    }
  }

  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    return BlocSelector<InvitationThemeCoreCubit, InvitationThemeCoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => Stack(
        alignment: .center,
        children: [
          if (widget.config.firstGradientBackgroundColor != null &&
              widget.config.secondGradientBackgroundColor != null)
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
                      widget.config.firstGradientBackgroundColor!,
                      widget.config.secondGradientBackgroundColor!,
                    ],
                  ),
                ),
              ),
            ),

          if (_cachedImage != null)
            Column(
              children: [
                Expanded(
                  child: ColoredBox(
                    color: Colors.grey.shade500.withValues(alpha: .75),
                    child: Padding(
                      padding: .only(left: W.sm, right: W.sm, top: 60),
                      child: _cachedImage!,
                    ),
                  ),
                ),
                SizedBox(height: H.x16l + W.sm),
              ],
            ),

          Positioned(
            top: 0,
            child: SizedBox(
              height: 60,
              width: Screen.width,
              child: Padding(
                padding: .symmetric(horizontal: W.sm),
                child: ColoredBox(color: Colors.grey.shade300.withValues(alpha: .5)),
              ),
            ),
          ),

          Positioned(
            left: (-Screen.height / 2) + W.sm / 2,
            child: Transform.rotate(angle: -(pi / 2), child: _buildTitle(langCode)),
          ),

          Positioned(
            right: (-Screen.height / 2) + W.sm / 2,
            child: Transform.rotate(angle: (pi / 2), child: _buildTitle(langCode, isRight: true)),
          ),

          Positioned(
            bottom: 0,
            child: SizedBox(
              height: H.x16l + W.sm + .5,
              width: Screen.width,
              child: ColoredBox(
                color: Colors.grey.shade900,
                child: Padding(
                  padding: .symmetric(horizontal: W.sm),
                  child: Column(
                    children: [
                      const Spacer(flex: 5),
                      _buildBrideGroomText(
                        frontTitle: widget.groom.frontTitle,
                        fullName: widget.groom.fullName,
                        backTitle: widget.groom.backTitle,
                        nameColor: widget.config.brideNameTextColor,
                        generalColor: widget.config.generalTextColor,
                      ),
                      SizedBox(height: H.x3s),
                      Text(
                        langCode == 'en' ? 'Son of' : 'Putra dari',
                        style: AppFonts.inter(
                          fontSize: FontSize.md,
                          fontWeight: .w500,
                          color: widget.config.generalTextColor,
                        ),
                      ),
                      SizedBox(height: H.x9s),
                      _buildFatherMotherText(
                        isFather: true,
                        frontTitle: widget.groom.fatherFrontTitle,
                        name: widget.groom.fatherName,
                        backTitle: widget.groom.fatherBackTitle,
                        nameColor: widget.config.brideFatherNameTextColor,
                        generalColor: widget.config.generalTextColor,
                        langCode: langCode,
                      ),
                      SizedBox(height: H.x9s),
                      Text(
                        langCode == 'en' ? 'and' : 'dan',
                        style: AppFonts.inter(
                          fontSize: FontSize.md,
                          fontWeight: .w500,
                          color: widget.config.generalTextColor,
                        ),
                      ),
                      SizedBox(height: H.x9s),
                      _buildFatherMotherText(
                        isFather: false,
                        frontTitle: widget.groom.motherFrontTitle,
                        name: widget.groom.motherName,
                        backTitle: widget.groom.motherBackTitle,
                        nameColor: widget.config.brideMotherNameTextColor,
                        generalColor: widget.config.generalTextColor,
                        langCode: langCode,
                      ),
                      const Spacer(flex: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),

          if (widget.config.decorationBuilder != null)
            SizedBox(
              height: Screen.height,
              width: Screen.width,
              child: widget.config.decorationBuilder!(),
            ),
        ],
      ),
    );
  }

  Widget _buildTitle(String langCode, {bool isRight = false}) => SizedBox(
    height: W.sm,
    width: Screen.height,
    child: Row(
      crossAxisAlignment: .center,
      children: [
        if (!isRight) SizedBox(width: H.x16l),
        Expanded(
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
                        langCode == 'en' ? 'The Groom' : 'Pengantin Pria',
                        style: AppFonts.inter(
                          color: widget.config.titlePageColor,
                          fontSize: FontSize.x3l,
                          fontWeight: .w700,
                        ),
                      ),
                    ),
                    if (!isRight) const SizedBox(height: 2),
                  ],
                ),
                SizedBox(width: isRight ? H.x5l : H.x5l + H.x3s),
              ],
            ),
          ),
        ),
        if (isRight) SizedBox(width: H.x16l),
      ],
    ),
  );

  Widget _buildBrideGroomText({
    String? frontTitle,
    required String fullName,
    String? backTitle,
    Color? nameColor,
    required Color generalColor,
  }) {
    return Text.rich(
      TextSpan(
        children: [
          if ((frontTitle ?? '').isNotEmpty)
            TextSpan(
              text: '$frontTitle ',
              style: AppFonts.inter(fontWeight: .w500),
            ),
          TextSpan(
            text: fullName,
            style: AppFonts.inter(fontWeight: .w700, color: nameColor),
          ),
          if ((backTitle ?? '').isNotEmpty)
            TextSpan(
              text: ', $backTitle',
              style: AppFonts.inter(fontWeight: .w500),
            ),
        ],
      ),
      style: AppFonts.inter(fontSize: FontSize.x4l, color: generalColor, height: 1.2),
      textAlign: .center,
    );
  }

  Widget _buildFatherMotherText({
    required bool isFather,
    String? frontTitle,
    required String name,
    String? backTitle,
    Color? nameColor,
    required Color generalColor,
    required String langCode,
  }) {
    final prefix = isFather
        ? (langCode == 'en' ? 'Mr. ' : 'Bp. ')
        : (langCode == 'en' ? 'Mrs. ' : 'Ibu ');
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: prefix),
          if ((frontTitle ?? '').isNotEmpty)
            TextSpan(
              text: '$frontTitle ',
              style: AppFonts.inter(fontWeight: .w500, fontStyle: .italic),
            ),
          TextSpan(
            text: name,
            style: AppFonts.inter(fontWeight: .w700, fontStyle: .italic, color: nameColor),
          ),
          if ((backTitle ?? '').isNotEmpty)
            TextSpan(
              text: ', $backTitle',
              style: AppFonts.inter(fontWeight: .w500, fontStyle: .italic),
            ),
        ],
      ),
      style: AppFonts.inter(
        fontSize: FontSize.lg,
        fontStyle: .italic,
        color: generalColor,
        height: 1.2,
      ),
      textAlign: .center,
    );
  }
}
