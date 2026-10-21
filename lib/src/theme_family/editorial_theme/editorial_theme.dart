import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/opener/initializer_wrapper.dart';
import 'package:iv_project_invitation_theme/src/theme_family/editorial_theme/editorial_configs.dart';
import 'package:iv_project_invitation_theme/src/theme_family/editorial_theme/editorial_core.dart';
import 'package:iv_project_invitation_theme/src/theme_family/editorial_theme/pages/editorial_cover_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/editorial_theme/pages/editorial_first_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/editorial_theme/pages/editorial_second_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/editorial_theme/pages/editorial_third_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/editorial_theme/pages/editorial_fourth_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/editorial_theme/pages/editorial_fourth_different_location_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/editorial_theme/pages/editorial_fifth_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/editorial_theme/pages/editorial_fifth_different_location_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/editorial_theme/pages/editorial_sixth_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/editorial_theme/pages/editorial_seventh_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/editorial_theme/pages/editorial_eighth_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/editorial_theme/pages/editorial_ninth_page.dart';
import 'package:iv_project_model/iv_project_model.dart';

class const EditorialTheme({
  super.key,
  required final EditorialConfigs configs,
  final double heightAdjustment = 0,
  required final ViewType viewType,
  required final String invitationId,
  required final InvitationDataResponse invitationData,
  final ImagesRaw? imagesRaw,
  required final BrandProfileResponse brandProfile,
}) extends StatefulWidget {
  @override
  State<EditorialTheme> createState() => _EditorialThemeState();
}

class _EditorialThemeState() extends State<EditorialTheme> with WidgetsBindingObserver {
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

    return EditorialCore(
      wrapper: InitializerWrapper(
        viewType: widget.viewType,
        bride: invitationData.bride,
        groom: invitationData.groom,
        time: invitationData.contractEvent,
      ),
      backgrounds: widget.configs.globalBackgroundsBuilder?.call(),
      pages: [
        EditorialCoverPage(
          config: widget.configs.coverPageConfig,
          viewType: widget.viewType,
          coverImage: widget.imagesRaw?.coverImage,
          general: invitationData.general,
          bride: invitationData.bride,
          groom: invitationData.groom,
          time: invitationData.contractEvent,
        ),
        EditorialFirstPage(
          config: widget.configs.firstPageConfig,
          general: invitationData.general,
        ),
        EditorialSecondPage(
          config: widget.configs.secondPageConfig,
          viewType: widget.viewType,
          brideImage: widget.imagesRaw?.brideImage,
          bride: invitationData.bride,
        ),
        EditorialThirdPage(
          config: widget.configs.thirdPageConfig,
          viewType: widget.viewType,
          groomImage: widget.imagesRaw?.groomImage,
          groom: invitationData.groom,
        ),
        if (invitationData.contractEvent.mapsUrl == invitationData.receptionEvent.mapsUrl) ...[
          EditorialFourthPage(
            config: widget.configs.fourthPageConfig,
            contractEvent: invitationData.contractEvent,
            receptionEvent: invitationData.receptionEvent,
          ),
          EditorialFifthPage(
            config: widget.configs.fifthPageConfig,
            receptionEvent: invitationData.receptionEvent,
          ),
        ] else ...[
          EditorialFourthDifferentLocationPage(
            config: widget.configs.fourthDifferentLocationPageConfig,
            contractEvent: invitationData.contractEvent,
          ),
          EditorialFifthDifferentLocationPage(
            config: widget.configs.fifthDifferentLocationPageConfig,
            receptionEvent: invitationData.receptionEvent,
          ),
        ],
        if (_isGalleriesNotEmpty)
          EditorialSixthPage(
            config: widget.configs.sixthPageConfig,
            viewType: widget.viewType,
            galleries: widget.imagesRaw?.galleries,
            gallery: invitationData.gallery,
          ),
        if (invitationData.bankAccounts.isNotEmpty)
          EditorialSeventhPage(
            config: widget.configs.seventhPageConfig,
            bankAccounts: invitationData.bankAccounts,
          ),
        EditorialEighthPage(
          config: widget.configs.eighthPageConfig,
          viewType: widget.viewType,
          invitationId: widget.invitationId,
        ),
        EditorialNinthPage(
          config: widget.configs.ninthPageConfig,
          general: invitationData.general,
          brideName: invitationData.bride.nickname,
          groomName: invitationData.groom.nickname,
          brandProfile: widget.brandProfile,
        ),
      ],
      navs: [
        _buildNav(title: 'Cover'),
        _buildNav(title: langCode == 'en' ? 'Opening' : 'Kata Pengantar'),
        _buildNav(title: langCode == 'en' ? 'The Bride' : 'Pengantin Wanita'),
        _buildNav(title: langCode == 'en' ? 'The Groom' : 'Pengantin Pria'),
        if (invitationData.contractEvent.mapsUrl != invitationData.receptionEvent.mapsUrl) ...[
          _buildNav(title: langCode == 'en' ? 'Contract' : 'Akad Nikah'),
          _buildNav(title: langCode == 'en' ? 'Reception' : 'Resepsi'),
        ] else ...[
          _buildNav(title: langCode == 'en' ? 'Schedule' : 'Jadwal Acara'),
          _buildNav(title: langCode == 'en' ? 'Location' : 'Lokasi Acara'),
        ],
        if (_isGalleriesNotEmpty) _buildNav(title: langCode == 'en' ? 'Lookbook' : 'Galeri'),
        if (invitationData.bankAccounts.isNotEmpty)
          _buildNav(title: langCode == 'en' ? 'Wedding Gift' : 'Tanda Kasih'),
        _buildNav(title: langCode == 'en' ? 'RSVP' : 'RSVP & Ucapan'),
        _buildNav(title: langCode == 'en' ? 'Thank You' : 'Penutup'),
      ],
    );
  }

  Widget _buildNav({required String title}) => Text(
    title,
    style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: .w600),
    textAlign: .end,
  );
}
