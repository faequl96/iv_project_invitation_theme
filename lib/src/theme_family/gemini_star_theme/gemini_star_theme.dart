import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/opener/initializer_wrapper.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/gemini_star_configs.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/gemini_star_core.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/pages/gemini_star_cover_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/pages/gemini_star_ninth_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/pages/gemini_star_sixth_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/pages/gemini_star_first_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/pages/gemini_star_fifth_different_location_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/pages/gemini_star_fifth_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/pages/gemini_star_second_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/pages/gemini_star_eighth_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/pages/gemini_star_seventh_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/pages/gemini_star_fourth_different_location_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/pages/gemini_star_fourth_page.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/pages/gemini_star_third_page.dart';
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

  Widget? _cachedBackgroundImage;

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

    _buildCachedImage();
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

  void _buildCachedImage() {
    if (widget.viewType == .preview && widget.imagesRaw?.coverImage != null) {
      _cachedBackgroundImage = Image.file(
        widget.imagesRaw!.coverImage!,
        height: Screen.height / 1.2,
        width: Screen.width,
        fit: .cover,
      );
    } else if (widget.viewType == .example && widget.invitationData.general.coverImageUrl != null) {
      _cachedBackgroundImage = Image.asset(
        widget.invitationData.general.coverImageUrl!,
        height: Screen.height / 1.2,
        width: Screen.width,
        fit: .cover,
        package: 'iv_project_invitation_theme',
      );
    } else if (widget.invitationData.general.coverImageUrl != null) {
      _cachedBackgroundImage = Image.network(
        widget.invitationData.general.coverImageUrl!,
        height: Screen.height / 1.2,
        width: Screen.width,
        fit: .cover,
      );
    }
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
      backgrounds: _cachedBackgroundImage != null
          ? [
              Column(children: [_cachedBackgroundImage!]),
              Positioned(
                bottom: 0,
                child: SizedBox(
                  height: Screen.height / 1.5,
                  width: Screen.width,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.grey.shade900.withValues(alpha: .0), Colors.grey.shade900],
                        stops: const [.0, .7],
                        begin: .topCenter,
                        end: .bottomCenter,
                      ),
                    ),
                  ),
                ),
              ),
            ]
          : null,
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
        GeminiStarFirstPage(
          config: widget.configs.firstPageConfig,
          general: invitationData.general,
        ),
        GeminiStarSecondPage(
          config: widget.configs.secondPageConfig,
          viewType: widget.viewType,
          brideImage: widget.imagesRaw?.brideImage,
          bride: invitationData.bride,
        ),
        GeminiStarThirdPage(
          config: widget.configs.thirdPageConfig,
          viewType: widget.viewType,
          groomImage: widget.imagesRaw?.groomImage,
          groom: invitationData.groom,
        ),
        if (invitationData.contractEvent.mapsUrl == invitationData.receptionEvent.mapsUrl) ...[
          GeminiStarFourthPage(
            config: widget.configs.fourthPageConfig,
            contractEvent: invitationData.contractEvent,
            receptionEvent: invitationData.receptionEvent,
          ),
          GeminiStarFifthPage(
            config: widget.configs.fifthPageConfig,
            receptionEvent: invitationData.receptionEvent,
          ),
        ] else ...[
          GeminiStarFourthDifferentLocationPage(
            config: widget.configs.fourthDifferentLocationPageConfig,
            contractEvent: invitationData.contractEvent,
          ),
          GeminiStarFifthDifferentLocationPage(
            config: widget.configs.fifthDifferentLocationPageConfig,
            receptionEvent: invitationData.receptionEvent,
          ),
        ],
        if (_isGalleriesNotEmpty)
          GeminiStarSixthPage(
            config: widget.configs.sixthPageConfig,
            viewType: widget.viewType,
            galleries: widget.imagesRaw?.galleries,
            gallery: invitationData.gallery,
          ),
        if (invitationData.bankAccounts.isNotEmpty)
          GeminiStarSeventhPage(
            config: widget.configs.seventhPageConfig,
            bankAccounts: invitationData.bankAccounts,
          ),
        GeminiStarEighthPage(
          config: widget.configs.eighthPageConfig,
          viewType: widget.viewType,
          invitationId: widget.invitationId,
        ),
        GeminiStarNinthPage(
          config: widget.configs.ninthPageConfig,
          general: invitationData.general,
          brideName: invitationData.bride.nickname,
          groomName: invitationData.groom.nickname,
          brandProfile: widget.brandProfile,
        ),
      ],
      navs: [
        _buildNav(title: 'Cover'),
        _buildNav(title: langCode == 'en' ? 'Intent and Purpose' : 'Maksud Dan Tujuan'),
        _buildNav(title: langCode == 'en' ? 'The Bride' : 'Pengantin Wanita'),
        _buildNav(title: langCode == 'en' ? 'The Groom' : 'Pengantin Pria'),
        if (invitationData.contractEvent.mapsUrl != invitationData.receptionEvent.mapsUrl) ...[
          _buildNav(title: langCode == 'en' ? 'Contract' : 'Akad Nikah'),
          _buildNav(title: langCode == 'en' ? 'Reception' : 'Resepsi'),
        ] else ...[
          _buildNav(title: langCode == 'en' ? 'Event' : 'Acara'),
          _buildNav(title: langCode == 'en' ? 'Location' : 'Lokasi'),
        ],
        if (_isGalleriesNotEmpty) _buildNav(title: langCode == 'en' ? 'Gallery' : 'Galeri'),
        if (invitationData.bankAccounts.isNotEmpty)
          _buildNav(title: langCode == 'en' ? 'Wedding Gift' : 'Kado Pernikahan'),
        _buildNav(title: langCode == 'en' ? 'RSVP and Greetings' : 'RSVP dan Ucapan'),
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
