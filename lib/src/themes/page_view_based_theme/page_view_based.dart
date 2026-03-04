import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/core/helpers/app_helpers.dart';
import 'package:iv_project_invitation_theme/src/opener/initializer_wrapper.dart';
import 'package:iv_project_invitation_theme/src/page_types/page_view_with_bottom_tab_bar.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/page_view_based_cover_page.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/page_view_based_eighth_page.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/page_view_based_fifth_page.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/page_view_based_first_page.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/page_view_based_fourth_different_location_page.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/page_view_based_fourth_page.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/page_view_based_second_page.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/page_view_based_seventh_page.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/page_view_based_sixth_page.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/page_view_based_third_different_location_page.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/page_view_based_third_page.dart';
import 'package:iv_project_model/iv_project_model.dart';

class PageViewBasedConfigs {
  const PageViewBasedConfigs({
    required this.tabConfig,
    this.globalBackgroundBuilder,
    required this.coverPageConfig,
    required this.firstPageConfig,
    required this.secondPageConfig,
    required this.thirdPageConfig,
  });

  final PageViewBasedTabConfig tabConfig;
  final Widget Function()? globalBackgroundBuilder;
  final PageViewBasedCoverPageConfig coverPageConfig;
  final PageViewBasedFirstPageConfig firstPageConfig;
  final PageViewBasedSecondPageConfig secondPageConfig;
  final PageViewBasedThirdPageConfig thirdPageConfig;
}

class PageViewBasedTabConfig {
  const PageViewBasedTabConfig({
    required this.useGlassEffectOnTab,
    required this.indicatorColor,
    required this.titleActiveColor,
    required this.titleInactiveColor,
    required this.iconActiveColor,
    required this.iconInactiveColor,
  });

  final bool useGlassEffectOnTab;
  final Color indicatorColor;
  final Color titleActiveColor;
  final Color titleInactiveColor;
  final Color iconActiveColor;
  final Color iconInactiveColor;
}

class PageViewBased extends StatefulWidget {
  const PageViewBased({
    super.key,
    required this.configs,
    this.heightAdjustment = 0,
    this.initialPage = 0,
    this.viewAsImage = false,
    required this.viewType,
    required this.invitationId,
    required this.invitationData,
    this.imagesRaw,
    required this.brandProfile,
  });

  final PageViewBasedConfigs configs;
  final double heightAdjustment;
  final int initialPage;
  final bool viewAsImage;
  final ViewType viewType;
  final String invitationId;
  final InvitationDataResponse invitationData;
  final ImagesRaw? imagesRaw;
  final BrandProfileResponse brandProfile;

  @override
  State<PageViewBased> createState() => _PageViewBasedState();
}

class _PageViewBasedState extends State<PageViewBased> with WidgetsBindingObserver {
  late final InvitationThemeCoreCubit _coreCubit;

  bool _isGalleriesNotEmpty = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    _coreCubit = context.read<InvitationThemeCoreCubit>();

    _isGalleriesNotEmpty = AppHelpers.isGalleriesNotEmptyChecker(widget.viewType, widget.imagesRaw, widget.invitationData);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    AppHelpers.setSize(_coreCubit, widget.heightAdjustment);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();

    AppHelpers.setSize(_coreCubit, widget.heightAdjustment);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    return PageViewWithBottomTabBar(
      heightAdjustment: widget.heightAdjustment,
      initialPage: widget.initialPage,
      viewAsImage: widget.viewAsImage,
      useGlassEffectOnTab: widget.configs.tabConfig.useGlassEffectOnTab,
      tabIndicatorColor: widget.configs.tabConfig.indicatorColor,
      wrapper: InitializerWrapper(
        viewType: widget.viewType,
        bride: widget.invitationData.bride,
        groom: widget.invitationData.groom,
        time: widget.invitationData.contractEvent,
      ),
      background: widget.configs.globalBackgroundBuilder?.call(),
      pages: [
        PageViewBasedCoverPage(
          config: widget.configs.coverPageConfig,
          viewType: widget.viewType,
          coverImage: widget.imagesRaw?.coverImage,
          general: widget.invitationData.general,
          bride: widget.invitationData.bride,
          groom: widget.invitationData.groom,
          time: widget.invitationData.contractEvent,
        ),
        PageViewBasedFirstPage(config: widget.configs.firstPageConfig, general: widget.invitationData.general),
        PageViewBasedSecondPage(
          config: widget.configs.secondPageConfig,
          viewType: widget.viewType,
          brideImage: widget.imagesRaw?.brideImage,
          groomImage: widget.imagesRaw?.groomImage,
          bride: widget.invitationData.bride,
          groom: widget.invitationData.groom,
        ),
        if (widget.invitationData.contractEvent.mapsUrl == widget.invitationData.receptionEvent.mapsUrl) ...[
          PageViewBasedThirdPage(
            config: widget.configs.thirdPageConfig,
            contractEvent: widget.invitationData.contractEvent,
            receptionEvent: widget.invitationData.receptionEvent,
          ),
          PageViewBasedFourthPage(receptionEvent: widget.invitationData.receptionEvent),
        ] else ...[
          PageViewBasedThirdDifferentLocationPage(contractEvent: widget.invitationData.contractEvent),
          PageViewBasedFourthDifferentLocationPage(receptionEvent: widget.invitationData.receptionEvent),
        ],
        if (_isGalleriesNotEmpty)
          PageViewBasedFifthPage(
            viewType: widget.viewType,
            galleries: widget.imagesRaw?.galleries,
            gallery: widget.invitationData.gallery,
          ),
        if (widget.invitationData.bankAccounts.isNotEmpty)
          PageViewBasedSixthPage(bankAccounts: widget.invitationData.bankAccounts),
        PageViewBasedSeventhPage(viewType: widget.viewType, invitationId: widget.invitationId),
        PageViewBasedEighthPage(
          general: widget.invitationData.general,
          brideName: widget.invitationData.bride.nickname,
          groomName: widget.invitationData.groom.nickname,
          brandProfile: widget.brandProfile,
        ),
      ],
      tabsBuilder: (ValueNotifier<int> tabActive) => [
        Tab(
          height: 48,
          child: _Tab(config: widget.configs.tabConfig, title: 'Cover', icon: Icons.image, tabIndex: 0, tabActive: tabActive),
        ),
        Tab(
          height: 48,
          child: _Tab(
            config: widget.configs.tabConfig,
            title: langCode == 'en' ? 'Intent and Purpose' : 'Maksud Dan Tujuan',
            icon: Icons.lightbulb,
            tabIndex: 1,
            tabActive: tabActive,
          ),
        ),
        Tab(
          height: 48,
          child: _Tab(
            config: widget.configs.tabConfig,
            title: langCode == 'en' ? 'Inviter' : 'Pengundang',
            icon: Icons.people,
            tabIndex: 2,
            tabActive: tabActive,
          ),
        ),
        if (widget.invitationData.contractEvent.mapsUrl != widget.invitationData.receptionEvent.mapsUrl) ...[
          Tab(
            height: 48,
            child: _Tab(
              config: widget.configs.tabConfig,
              title: langCode == 'en' ? 'Contract' : 'Akad Nikah',
              icon: Icons.volunteer_activism,
              tabIndex: 3,
              tabActive: tabActive,
            ),
          ),
          Tab(
            height: 48,
            child: _Tab(
              config: widget.configs.tabConfig,
              title: langCode == 'en' ? 'Reception' : 'Resepsi',
              icon: Icons.celebration,
              tabIndex: 4,
              tabActive: tabActive,
            ),
          ),
        ] else ...[
          Tab(
            height: 48,
            child: _Tab(
              config: widget.configs.tabConfig,
              title: langCode == 'en' ? 'Event' : 'Acara',
              icon: Icons.event,
              tabIndex: 3,
              tabActive: tabActive,
            ),
          ),
          Tab(
            height: 48,
            child: _Tab(
              config: widget.configs.tabConfig,
              title: langCode == 'en' ? 'Location' : 'Lokasi',
              icon: Icons.location_pin,
              tabIndex: 4,
              tabActive: tabActive,
            ),
          ),
        ],
        if (_isGalleriesNotEmpty)
          Tab(
            height: 48,
            child: _Tab(
              config: widget.configs.tabConfig,
              title: langCode == 'en' ? 'Gallery' : 'Galeri',
              icon: Icons.photo_library_rounded,
              tabIndex: 5,
              tabActive: tabActive,
            ),
          ),
        if (widget.invitationData.bankAccounts.isNotEmpty)
          Tab(
            height: 48,
            child: _Tab(
              config: widget.configs.tabConfig,
              title: langCode == 'en' ? 'Gift' : 'Kado',
              icon: Icons.card_giftcard,
              tabIndex: 6,
              tabActive: tabActive,
            ),
          ),
        Tab(
          height: 48,
          child: _Tab(
            config: widget.configs.tabConfig,
            title: 'RSVP',
            icon: Icons.event_available,
            tabIndex: 7,
            tabActive: tabActive,
          ),
        ),
        Tab(
          height: 48,
          child: _Tab(
            config: widget.configs.tabConfig,
            title: langCode == 'en' ? 'Thank You' : 'Terima Kasih',
            icon: Icons.emoji_emotions,
            tabIndex: 7,
            tabActive: tabActive,
          ),
        ),
      ],
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({required this.config, required this.title, required this.icon, required this.tabIndex, required this.tabActive});

  final PageViewBasedTabConfig config;
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
                  Icon(icon, size: 20, color: tabIndex == tabActive ? config.iconActiveColor : config.iconInactiveColor),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: AppFonts.inter(
                      color: tabIndex == tabActive ? config.titleActiveColor : config.titleInactiveColor,
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
