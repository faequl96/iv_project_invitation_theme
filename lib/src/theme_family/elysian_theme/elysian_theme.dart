import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/opener/initializer_wrapper.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/elysian_configs.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/elysian_core.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/pages/elysian_cover_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/pages/elysian_eighth_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/pages/elysian_fifth_different_location_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/pages/elysian_fifth_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/pages/elysian_first_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/pages/elysian_fourth_different_location_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/pages/elysian_fourth_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/pages/elysian_ninth_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/pages/elysian_second_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/pages/elysian_seventh_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/pages/elysian_sixth_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/pages/elysian_third_page.dart';
import 'package:iv_project_model/iv_project_model.dart';

class const ElysianTheme({
  super.key,
  required final ElysianConfigs configs,
  final double heightAdjustment = 0,
  required final ViewType viewType,
  required final String invitationId,
  required final InvitationDataResponse invitationData,
  final ImagesRaw? imagesRaw,
  required final BrandProfileResponse brandProfile,
}) extends StatefulWidget {
  @override
  State<ElysianTheme> createState() => _ElysianThemeState();
}

class _ElysianThemeState() extends State<ElysianTheme> with WidgetsBindingObserver {
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

    return ElysianCore(
      wrapper: InitializerWrapper(
        viewType: widget.viewType,
        bride: invitationData.bride,
        groom: invitationData.groom,
        time: invitationData.contractEvent,
      ),
      backgrounds: widget.configs.globalBackgroundsBuilder?.call(),
      pages: [
        ElysianCoverPage(
          config: widget.configs.coverPageConfig,
          viewType: widget.viewType,
          coverImage: widget.imagesRaw?.coverImage,
          general: invitationData.general,
          bride: invitationData.bride,
          groom: invitationData.groom,
          time: invitationData.contractEvent,
        ),
        ElysianFirstPage(
          config: widget.configs.firstPageConfig,
          general: invitationData.general,
        ),
        ElysianSecondPage(
          config: widget.configs.secondPageConfig,
          viewType: widget.viewType,
          brideImage: widget.imagesRaw?.brideImage,
          bride: invitationData.bride,
        ),
        ElysianThirdPage(
          config: widget.configs.thirdPageConfig,
          viewType: widget.viewType,
          groomImage: widget.imagesRaw?.groomImage,
          groom: invitationData.groom,
        ),
        if (invitationData.contractEvent.mapsUrl == invitationData.receptionEvent.mapsUrl) ...[
          ElysianFourthPage(
            config: widget.configs.fourthPageConfig,
            contractEvent: invitationData.contractEvent,
            receptionEvent: invitationData.receptionEvent,
          ),
          ElysianFifthPage(
            config: widget.configs.fifthPageConfig,
            receptionEvent: invitationData.receptionEvent,
          ),
        ] else ...[
          ElysianFourthDifferentLocationPage(
            config: widget.configs.fourthDifferentLocationPageConfig,
            contractEvent: invitationData.contractEvent,
          ),
          ElysianFifthDifferentLocationPage(
            config: widget.configs.fifthDifferentLocationPageConfig,
            receptionEvent: invitationData.receptionEvent,
          ),
        ],
        if (_isGalleriesNotEmpty)
          ElysianSixthPage(
            config: widget.configs.sixthPageConfig,
            viewType: widget.viewType,
            galleries: widget.imagesRaw?.galleries,
            gallery: invitationData.gallery,
          ),
        if (invitationData.bankAccounts.isNotEmpty)
          ElysianSeventhPage(
            config: widget.configs.seventhPageConfig,
            bankAccounts: invitationData.bankAccounts,
          ),
        ElysianEighthPage(
          config: widget.configs.eighthPageConfig,
          viewType: widget.viewType,
          invitationId: widget.invitationId,
        ),
        ElysianNinthPage(
          config: widget.configs.ninthPageConfig,
          general: invitationData.general,
          brideName: invitationData.bride.nickname,
          groomName: invitationData.groom.nickname,
          brandProfile: widget.brandProfile,
        ),
      ],
      navs: [
        _buildNav('Cover'),
        _buildNav(langCode == 'en' ? 'Opening' : 'Pengantar'),
        _buildNav(langCode == 'en' ? 'The Bride' : 'Mempelai Wanita'),
        _buildNav(langCode == 'en' ? 'The Groom' : 'Mempelai Pria'),
        if (invitationData.contractEvent.mapsUrl != invitationData.receptionEvent.mapsUrl) ...[
          _buildNav(langCode == 'en' ? 'Akad' : 'Akad Nikah'),
          _buildNav(langCode == 'en' ? 'Reception' : 'Resepsi'),
        ] else ...[
          _buildNav(langCode == 'en' ? 'Events' : 'Acara'),
          _buildNav(langCode == 'en' ? 'Location' : 'Lokasi'),
        ],
        if (_isGalleriesNotEmpty) _buildNav(langCode == 'en' ? 'Gallery' : 'Galeri'),
        if (invitationData.bankAccounts.isNotEmpty)
          _buildNav(langCode == 'en' ? 'Gift' : 'Tanda Kasih'),
        _buildNav(langCode == 'en' ? 'RSVP' : 'Ucapan & RSVP'),
        _buildNav(langCode == 'en' ? 'Thank You' : 'Terima Kasih'),
      ],
    );
  }

  Widget _buildNav(String title) => Text(
    title,
    style: const TextStyle(fontSize: 14, color: Color(0xFFE5C88F), fontWeight: .w600),
    textAlign: .end,
  );
}
