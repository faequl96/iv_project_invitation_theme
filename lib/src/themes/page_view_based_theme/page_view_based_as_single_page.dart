import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/opener/initializer_wrapper.dart';
import 'package:iv_project_invitation_theme/src/page_types/page_view_with_bottom_tab_bar_as_single_page.dart';
import 'package:iv_project_invitation_theme/src/page_types/page_view_with_bottom_tab_bar_config.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/page_view_based_configs.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/page_view_based_cover_page.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/page_view_based_eighth_page.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/page_view_based_fifth_page.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/page_view_based_first_page.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/page_view_based_fourth_page.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/page_view_based_second_page.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/page_view_based_seventh_page.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/page_view_based_sixth_page.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/page_view_based_third_page.dart';
import 'package:iv_project_model/iv_project_model.dart';

class PageViewBasedAsSinglePage extends StatefulWidget {
  const PageViewBasedAsSinglePage({
    super.key,
    required this.configs,
    this.initialPage = 0,
    required this.useWrapper,
    required this.invitationData,
    required this.brandProfile,
  });

  final PageViewBasedConfigs configs;
  final int initialPage;
  final bool useWrapper;
  final InvitationDataResponse invitationData;
  final BrandProfileResponse brandProfile;

  final ViewType viewType = .example;

  @override
  State<PageViewBasedAsSinglePage> createState() => _PageViewBasedAsSinglePageState();
}

class _PageViewBasedAsSinglePageState extends State<PageViewBasedAsSinglePage>
    with WidgetsBindingObserver {
  late final InvitationThemeCoreCubit _coreCubit;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    _coreCubit = context.read<InvitationThemeCoreCubit>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    ThemeAppHelpers.setSize(_coreCubit, 0);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();

    ThemeAppHelpers.setSize(_coreCubit, 0);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    return PageViewWithBottomTabBarAsSinglePage(
      initialPage: widget.initialPage,
      tabConfig: widget.configs.tabConfig,
      wrapper: widget.useWrapper
          ? InitializerWrapper(
              viewType: widget.viewType,
              bride: widget.invitationData.bride,
              groom: widget.invitationData.groom,
              time: widget.invitationData.contractEvent,
            )
          : null,
      backgrounds: widget.configs.globalBackgroundsBuilder?.call(),
      particleSphere: widget.configs.particleSphere,
      page: _page,
      tabsBuilder: (int tabActive) => [
        Tab(
          height: 48,
          child: _Tab(
            config: widget.configs.tabConfig,
            title: 'Cover',
            icon: Icons.image,
            tabIndex: 0,
            tabActive: tabActive,
          ),
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
            tabIndex: 8,
            tabActive: tabActive,
          ),
        ),
      ],
    );
  }

  Widget get _page => switch (widget.initialPage) {
    0 => PageViewBasedCoverPage(
      config: widget.configs.coverPageConfig,
      viewType: widget.viewType,
      general: widget.invitationData.general,
      bride: widget.invitationData.bride,
      groom: widget.invitationData.groom,
      time: widget.invitationData.contractEvent,
    ),
    1 => PageViewBasedFirstPage(
      config: widget.configs.firstPageConfig,
      general: widget.invitationData.general,
    ),
    2 => PageViewBasedSecondPage(
      config: widget.configs.secondPageConfig,
      viewType: widget.viewType,
      bride: widget.invitationData.bride,
      groom: widget.invitationData.groom,
    ),
    3 => PageViewBasedThirdPage(
      config: widget.configs.thirdPageConfig,
      contractEvent: widget.invitationData.contractEvent,
      receptionEvent: widget.invitationData.receptionEvent,
    ),

    4 => PageViewBasedFourthPage(
      config: widget.configs.fourthPageConfig,
      receptionEvent: widget.invitationData.receptionEvent,
    ),
    5 => PageViewBasedFifthPage(
      config: widget.configs.fifthPageConfig,
      viewType: widget.viewType,
      gallery: widget.invitationData.gallery,
    ),
    6 => PageViewBasedSixthPage(
      config: widget.configs.sixthPageConfig,
      bankAccounts: widget.invitationData.bankAccounts,
    ),
    7 => PageViewBasedSeventhPage(
      config: widget.configs.seventhPageConfig,
      viewType: widget.viewType,
      invitationId: '',
    ),

    8 => PageViewBasedEighthPage(
      config: widget.configs.eighthPageConfig,
      general: widget.invitationData.general,
      brideName: widget.invitationData.bride.nickname,
      groomName: widget.invitationData.groom.nickname,
      brandProfile: widget.brandProfile,
    ),
    int() => const SizedBox.shrink(),
  };
}

class _Tab extends StatelessWidget {
  const _Tab({
    required this.config,
    required this.title,
    required this.icon,
    required this.tabIndex,
    required this.tabActive,
  });

  final PageViewWithBottomTabBarConfig config;
  final String title;
  final IconData icon;
  final int tabIndex;
  final int tabActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      children: [
        const SizedBox(height: 6),
        Padding(
          padding: const .symmetric(horizontal: 6),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: tabIndex == tabActive ? config.iconActiveColor : config.iconInactiveColor,
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
          ),
        ),
      ],
    );
  }
}
