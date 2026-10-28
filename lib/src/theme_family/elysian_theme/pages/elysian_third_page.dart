import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/elysian_configs.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/widgets/elysian_glass_card.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/widgets/elysian_reveal.dart';
import 'package:iv_project_model/iv_project_model.dart';

class const ElysianThirdPage({
  super.key,
  required final ElysianThirdPageConfig config,
  required final ViewType viewType,
  final File? groomImage,
  required final BridegroomResponse groom,
}) extends StatefulWidget {
  @override
  State<ElysianThirdPage> createState() => _ElysianThirdPageState();
}

class _ElysianThirdPageState() extends State<ElysianThirdPage> {
  Widget? _cachedImage;

  @override
  void initState() {
    super.initState();
    _buildCachedImage();
  }

  void _buildCachedImage() {
    if (widget.viewType == .preview && widget.groomImage != null) {
      _cachedImage = Image.file(
        widget.groomImage!,
        height: .infinity,
        width: .infinity,
        fit: .cover,
      );
    } else if (widget.viewType == .example) {
      _cachedImage = Image.asset(
        widget.groom.imageUrl,
        height: .infinity,
        width: .infinity,
        fit: .cover,
        package: 'iv_project_invitation_theme',
      );
    } else {
      _cachedImage = Image.network(
        widget.groom.imageUrl,
        height: .infinity,
        width: .infinity,
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
        padding: const .symmetric(horizontal: 24, vertical: 28),
        child: Column(
          children: [
            ElysianReveal(
              delay: const Duration(milliseconds: 100),
              child: Text(
                langCode == 'en' ? 'THE GROOM' : 'MEMPELAI PRIA',
                style: TextStyle(
                  color: widget.config.titleColor,
                  fontSize: 12,
                  letterSpacing: 4,
                  fontWeight: .w600,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ElysianReveal(
                delay: const Duration(milliseconds: 250),
                initialScale: 0.9,
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 320, maxHeight: 380),
                    decoration: BoxDecoration(
                      borderRadius: const .vertical(top: .circular(160), bottom: .circular(30)),
                      border: Border.all(
                        color: widget.config.ringBorderColor,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: widget.config.ringBorderColor.withValues(alpha: .25),
                          blurRadius: 24,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    clipBehavior: .antiAlias,
                    child: _cachedImage ??
                        Container(
                          color: Colors.grey.shade900,
                          child: const Center(
                            child: Icon(Icons.person, color: Colors.white54, size: 60),
                          ),
                        ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElysianReveal(
              delay: const Duration(milliseconds: 400),
              child: ElysianGlassCard(
                backgroundColor: widget.config.cardColor,
                borderColor: widget.config.ringBorderColor.withValues(alpha: .4),
                padding: const .symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  children: [
                    Text(
                      '${widget.groom.frontTitle ?? ''} ${widget.groom.fullName} ${widget.groom.backTitle ?? ''}'
                          .trim(),
                      style: TextStyle(
                        color: widget.config.nameColor,
                        fontSize: 20,
                        fontWeight: .bold,
                        letterSpacing: 1.1,
                      ),
                      textAlign: .center,
                    ),
                    const SizedBox(height: 8),
                    _buildParentsText(langCode),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParentsText(String langCode) {
    final prefixFather = langCode == 'en' ? 'Mr. ' : 'Bp. ';
    final prefixMother = langCode == 'en' ? 'Mrs. ' : 'Ibu ';

    return Text(
      '${langCode == 'en' ? 'Son of ' : 'Putra tercinta dari '}'
      '$prefixFather${widget.groom.fatherName} & $prefixMother${widget.groom.motherName}',
      style: TextStyle(
        color: widget.config.parentsColor,
        fontSize: 12,
        height: 1.4,
      ),
      textAlign: .center,
    );
  }
}
