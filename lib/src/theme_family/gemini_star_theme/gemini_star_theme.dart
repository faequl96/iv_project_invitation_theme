import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/opener/initializer_wrapper.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/gemini_star_configs.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/gemini_star_core.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/pages/page_view_immersive_cover_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/pages/page_view_immersive_eighth_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/pages/page_view_immersive_fifth_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/pages/page_view_immersive_first_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/pages/page_view_immersive_fourth_different_location_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/pages/page_view_immersive_fourth_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/pages/page_view_immersive_second_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/pages/page_view_immersive_seventh_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/pages/page_view_immersive_sixth_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/pages/page_view_immersive_third_different_location_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/pages/page_view_immersive_third_page.dart';
import 'package:iv_project_model/iv_project_model.dart';

class GeminiStarTheme extends StatefulWidget {
  const GeminiStarTheme({
    super.key,
    required this.configs,
    this.heightAdjustment = 0,
    required this.viewType,
    required this.invitationId,
    required this.invitationData,
    this.imagesRaw,
    required this.brandProfile,
  });

  final GeminiStarConfigs configs;
  final double heightAdjustment;
  final ViewType viewType;
  final String invitationId;
  final InvitationDataResponse invitationData;
  final ImagesRaw? imagesRaw;
  final BrandProfileResponse brandProfile;

  @override
  State<GeminiStarTheme> createState() => _GeminiStarThemeState();
}

class _GeminiStarThemeState extends State<GeminiStarTheme> with WidgetsBindingObserver {
  late final InvitationThemeCoreCubit _coreCubit;

  bool _isGalleriesNotEmpty = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    _coreCubit = context.read<InvitationThemeCoreCubit>();

    _isGalleriesNotEmpty = ThemeAppHelpers.isGalleriesNotEmptyChecker(
      widget.viewType,
      widget.imagesRaw,
      widget.invitationData,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    ThemeAppHelpers.setSize(_coreCubit, widget.heightAdjustment);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();

    ThemeAppHelpers.setSize(_coreCubit, widget.heightAdjustment);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    final invitationData = widget.invitationData;

    return GeminiStarCore(
      wrapper: InitializerWrapper(
        viewType: widget.viewType,
        bride: invitationData.bride,
        groom: invitationData.groom,
        time: invitationData.contractEvent,
      ),
      backgrounds: null,
      particleSphere: null,
      pages: [
        GeminiStarCoverPage(
          config: widget.configs.coverPageConfig,
          viewType: widget.viewType,
          coverImage: widget.imagesRaw?.coverImage,
          general: invitationData.general,
          bride: invitationData.bride,
          groom: invitationData.groom,
          time: invitationData.contractEvent,
        ),
        // GeminiStarFirstPage(
        //   config: widget.configs.firstPageConfig,
        //   general: invitationData.general,
        // ),
        // GeminiStarSecondPage(
        //   config: widget.configs.secondPageConfig,
        //   viewType: widget.viewType,
        //   brideImage: widget.imagesRaw?.brideImage,
        //   groomImage: widget.imagesRaw?.groomImage,
        //   bride: invitationData.bride,
        //   groom: invitationData.groom,
        // ),
        // if (invitationData.contractEvent.mapsUrl == invitationData.receptionEvent.mapsUrl) ...[
        //   GeminiStarThirdPage(
        //     config: widget.configs.thirdPageConfig,
        //     contractEvent: invitationData.contractEvent,
        //     receptionEvent: invitationData.receptionEvent,
        //   ),
        //   GeminiStarFourthPage(
        //     config: widget.configs.fourthPageConfig,
        //     receptionEvent: invitationData.receptionEvent,
        //   ),
        // ] else ...[
        //   GeminiStarThirdDifferentLocationPage(
        //     config: widget.configs.thirdDifferentLocationPageConfig,
        //     contractEvent: invitationData.contractEvent,
        //   ),
        //   GeminiStarFourthDifferentLocationPage(
        //     config: widget.configs.fourthDifferentLocationPageConfig,
        //     receptionEvent: invitationData.receptionEvent,
        //   ),
        // ],
        // if (_isGalleriesNotEmpty)
        //   GeminiStarFifthPage(
        //     config: widget.configs.fifthPageConfig,
        //     viewType: widget.viewType,
        //     galleries: widget.imagesRaw?.galleries,
        //     gallery: invitationData.gallery,
        //   ),
        // if (invitationData.bankAccounts.isNotEmpty)
        //   GeminiStarSixthPage(
        //     config: widget.configs.sixthPageConfig,
        //     bankAccounts: invitationData.bankAccounts,
        //   ),
        // GeminiStarSeventhPage(
        //   config: widget.configs.seventhPageConfig,
        //   viewType: widget.viewType,
        //   invitationId: widget.invitationId,
        // ),
        // GeminiStarEighthPage(
        //   config: widget.configs.eighthPageConfig,
        //   general: invitationData.general,
        //   brideName: invitationData.bride.nickname,
        //   groomName: invitationData.groom.nickname,
        //   brandProfile: widget.brandProfile,
        // ),
      ],
      navs: [
        _buildNav(title: 'Cover'),
        _buildNav(title: langCode == 'en' ? 'Intent and Purpose' : 'Maksud Dan Tujuan'),
        _buildNav(title: langCode == 'en' ? 'Inviter' : 'Pengundang'),
        if (invitationData.contractEvent.mapsUrl != invitationData.receptionEvent.mapsUrl) ...[
          _buildNav(title: langCode == 'en' ? 'Contract' : 'Akad Nikah'),
          _buildNav(title: langCode == 'en' ? 'Reception' : 'Resepsi'),
        ] else ...[
          _buildNav(title: langCode == 'en' ? 'Event' : 'Acara'),
          _buildNav(title: langCode == 'en' ? 'Location' : 'Lokasi'),
        ],
        if (_isGalleriesNotEmpty) _buildNav(title: langCode == 'en' ? 'Gallery' : 'Galeri'),
        if (invitationData.bankAccounts.isNotEmpty)
          _buildNav(title: langCode == 'en' ? 'Gift' : 'Kado'),
        _buildNav(title: 'RSVP'),
        _buildNav(title: langCode == 'en' ? 'Thank You' : 'Terima Kasih'),
      ],
    );
  }

  Widget _buildNav({required String title}) => Text(
    title,
    style: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: .w600),
    textAlign: .end,
  );
}
