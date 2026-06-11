import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/opener/initializer_wrapper.dart';
import 'package:iv_project_invitation_theme/src/theme_types/page_view_tab_bar/page_view_tab_bar_configs.dart';
import 'package:iv_project_invitation_theme/src/theme_types/page_view_tab_bar/page_view_tab_bar_core.dart';
import 'package:iv_project_invitation_theme/src/theme_types/page_view_tab_bar/pages/page_view_tab_bar_cover_page.dart';
import 'package:iv_project_invitation_theme/src/theme_types/page_view_tab_bar/pages/page_view_tab_bar_eighth_page.dart';
import 'package:iv_project_invitation_theme/src/theme_types/page_view_tab_bar/pages/page_view_tab_bar_fifth_page.dart';
import 'package:iv_project_invitation_theme/src/theme_types/page_view_tab_bar/pages/page_view_tab_bar_first_page.dart';
import 'package:iv_project_invitation_theme/src/theme_types/page_view_tab_bar/pages/page_view_tab_bar_fourth_different_location_page.dart';
import 'package:iv_project_invitation_theme/src/theme_types/page_view_tab_bar/pages/page_view_tab_bar_fourth_page.dart';
import 'package:iv_project_invitation_theme/src/theme_types/page_view_tab_bar/pages/page_view_tab_bar_second_page.dart';
import 'package:iv_project_invitation_theme/src/theme_types/page_view_tab_bar/pages/page_view_tab_bar_seventh_page.dart';
import 'package:iv_project_invitation_theme/src/theme_types/page_view_tab_bar/pages/page_view_tab_bar_sixth_page.dart';
import 'package:iv_project_invitation_theme/src/theme_types/page_view_tab_bar/pages/page_view_tab_bar_third_different_location_page.dart';
import 'package:iv_project_invitation_theme/src/theme_types/page_view_tab_bar/pages/page_view_tab_bar_third_page.dart';
import 'package:iv_project_model/iv_project_model.dart';

class PageViewTabBarTheme extends StatefulWidget {
  const PageViewTabBarTheme({
    super.key,
    required this.configs,
    this.heightAdjustment = 0,
    required this.viewType,
    required this.invitationId,
    required this.invitationData,
    this.imagesRaw,
    required this.brandProfile,
  });

  final PageViewTabBarConfigs configs;
  final double heightAdjustment;
  final ViewType viewType;
  final String invitationId;
  final InvitationDataResponse invitationData;
  final ImagesRaw? imagesRaw;
  final BrandProfileResponse brandProfile;

  @override
  State<PageViewTabBarTheme> createState() => _PageViewTabBarThemeState();
}

class _PageViewTabBarThemeState extends State<PageViewTabBarTheme> with WidgetsBindingObserver {
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

    return PageViewTabBarCore(
      tabConfig: widget.configs.tabConfig,
      wrapper: InitializerWrapper(
        viewType: widget.viewType,
        bride: invitationData.bride,
        groom: invitationData.groom,
        time: invitationData.contractEvent,
      ),
      backgrounds: widget.configs.globalBackgroundsBuilder?.call(),
      particleSphere: widget.configs.particleSphere,
      pages: [
        PageViewTabBarCoverPage(
          config: widget.configs.coverPageConfig,
          viewType: widget.viewType,
          coverImage: widget.imagesRaw?.coverImage,
          general: invitationData.general,
          bride: invitationData.bride,
          groom: invitationData.groom,
          time: invitationData.contractEvent,
        ),
        PageViewTabBarFirstPage(
          config: widget.configs.firstPageConfig,
          general: invitationData.general,
        ),
        PageViewTabBarSecondPage(
          config: widget.configs.secondPageConfig,
          viewType: widget.viewType,
          brideImage: widget.imagesRaw?.brideImage,
          groomImage: widget.imagesRaw?.groomImage,
          bride: invitationData.bride,
          groom: invitationData.groom,
        ),
        if (invitationData.contractEvent.mapsUrl == invitationData.receptionEvent.mapsUrl) ...[
          PageViewTabBarThirdPage(
            config: widget.configs.thirdPageConfig,
            contractEvent: invitationData.contractEvent,
            receptionEvent: invitationData.receptionEvent,
          ),
          PageViewTabBarFourthPage(
            config: widget.configs.fourthPageConfig,
            receptionEvent: invitationData.receptionEvent,
          ),
        ] else ...[
          PageViewTabBarThirdDifferentLocationPage(
            config: widget.configs.thirdDifferentLocationPageConfig,
            contractEvent: invitationData.contractEvent,
          ),
          PageViewTabBarFourthDifferentLocationPage(
            config: widget.configs.fourthDifferentLocationPageConfig,
            receptionEvent: invitationData.receptionEvent,
          ),
        ],
        if (_isGalleriesNotEmpty)
          PageViewTabBarFifthPage(
            config: widget.configs.fifthPageConfig,
            viewType: widget.viewType,
            galleries: widget.imagesRaw?.galleries,
            gallery: invitationData.gallery,
          ),
        if (invitationData.bankAccounts.isNotEmpty)
          PageViewTabBarSixthPage(
            config: widget.configs.sixthPageConfig,
            bankAccounts: invitationData.bankAccounts,
          ),
        PageViewTabBarSeventhPage(
          config: widget.configs.seventhPageConfig,
          viewType: widget.viewType,
          invitationId: widget.invitationId,
        ),
        PageViewTabBarEighthPage(
          config: widget.configs.eighthPageConfig,
          general: invitationData.general,
          brideName: invitationData.bride.nickname,
          groomName: invitationData.groom.nickname,
          brandProfile: widget.brandProfile,
        ),
      ],
      tabsBuilder: (ValueNotifier<int> tabActive) {
        int index = 0;
        return [
          _buildTab(title: 'Cover', icon: Icons.image, tabIndex: index++, tabActive: tabActive),
          _buildTab(
            title: langCode == 'en' ? 'Intent and Purpose' : 'Maksud Dan Tujuan',
            icon: Icons.lightbulb,
            tabIndex: index++,
            tabActive: tabActive,
          ),
          _buildTab(
            title: langCode == 'en' ? 'Inviter' : 'Pengundang',
            icon: Icons.people,
            tabIndex: index++,
            tabActive: tabActive,
          ),
          if (invitationData.contractEvent.mapsUrl != invitationData.receptionEvent.mapsUrl) ...[
            _buildTab(
              title: langCode == 'en' ? 'Contract' : 'Akad Nikah',
              icon: Icons.volunteer_activism,
              tabIndex: index++,
              tabActive: tabActive,
            ),
            _buildTab(
              title: langCode == 'en' ? 'Reception' : 'Resepsi',
              icon: Icons.celebration,
              tabIndex: index++,
              tabActive: tabActive,
            ),
          ] else ...[
            _buildTab(
              title: langCode == 'en' ? 'Event' : 'Acara',
              icon: Icons.event,
              tabIndex: index++,
              tabActive: tabActive,
            ),
            _buildTab(
              title: langCode == 'en' ? 'Location' : 'Lokasi',
              icon: Icons.location_pin,
              tabIndex: index++,
              tabActive: tabActive,
            ),
          ],
          if (_isGalleriesNotEmpty)
            _buildTab(
              title: langCode == 'en' ? 'Gallery' : 'Galeri',
              icon: Icons.photo_library_rounded,
              tabIndex: index++,
              tabActive: tabActive,
            ),
          if (invitationData.bankAccounts.isNotEmpty)
            _buildTab(
              title: langCode == 'en' ? 'Gift' : 'Kado',
              icon: Icons.card_giftcard,
              tabIndex: index++,
              tabActive: tabActive,
            ),
          _buildTab(
            title: 'RSVP',
            icon: Icons.event_available,
            tabIndex: index++,
            tabActive: tabActive,
          ),
          _buildTab(
            title: langCode == 'en' ? 'Thank You' : 'Terima Kasih',
            icon: Icons.emoji_emotions,
            tabIndex: index++,
            tabActive: tabActive,
          ),
        ];
      },
    );
  }

  Widget _buildTab({
    required String title,
    required IconData icon,
    required int tabIndex,
    required ValueNotifier<int> tabActive,
  }) => Tab(
    height: 48,
    child: _Tab(
      config: widget.configs.tabConfig,
      title: title,
      icon: icon,
      tabIndex: tabIndex,
      tabActive: tabActive,
    ),
  );
}

class _Tab extends StatelessWidget {
  const _Tab({
    required this.config,
    required this.title,
    required this.icon,
    required this.tabIndex,
    required this.tabActive,
  });

  final PageViewTabBarTabConfig config;
  final String title;
  final IconData icon;
  final int tabIndex;
  final ValueNotifier<int> tabActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      children: [
        const SizedBox(height: 6),
        Padding(
          padding: const .symmetric(horizontal: 6),
          child: ValueListenableBuilder(
            valueListenable: tabActive,
            builder: (_, tabActive, _) {
              return Row(
                children: [
                  Icon(
                    icon,
                    size: 20,
                    color: tabIndex == tabActive
                        ? config.iconActiveColor
                        : config.iconInactiveColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: AppFonts.inter(
                      color: tabIndex == tabActive
                          ? config.titleActiveColor
                          : config.titleInactiveColor,
                      fontWeight: .w500,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
