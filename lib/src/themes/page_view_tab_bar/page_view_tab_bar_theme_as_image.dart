import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/src/opener/initializer_wrapper_as_image.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_tab_bar/page_view_tab_bar_core_as_image.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_tab_bar/page_view_tab_bar_configs.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_tab_bar/pages/as_image/page_view_based_cover_page_as_image.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_tab_bar/pages/as_image/page_view_based_eighth_page_as_image.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_tab_bar/pages/as_image/page_view_based_fifth_page_as_image.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_tab_bar/pages/as_image/page_view_based_first_page_as_image.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_tab_bar/pages/as_image/page_view_based_fourth_page_as_image.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_tab_bar/pages/as_image/page_view_based_second_page_as_image.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_tab_bar/pages/as_image/page_view_based_seventh_page_as_image.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_tab_bar/pages/as_image/page_view_based_sixth_page_as_image.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_tab_bar/pages/as_image/page_view_based_third_page_as_image.dart';
import 'package:iv_project_model/iv_project_model.dart';

class PageViewTabBarThemeAsImage extends StatelessWidget {
  const PageViewTabBarThemeAsImage({
    super.key,
    required this.configs,
    this.initialPage = 0,
    required this.useWrapper,
    required this.invitationData,
    required this.brandProfile,
  });

  final PageViewTabBarConfigs configs;
  final int initialPage;
  final bool useWrapper;
  final InvitationDataResponse invitationData;
  final BrandProfileResponse brandProfile;

  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    return PageViewTabBarCoreAsImage(
      initialPage: initialPage,
      tabConfig: configs.tabConfig,
      wrapper: useWrapper
          ? InitializerWrapperAsImage(
              bride: invitationData.bride,
              groom: invitationData.groom,
              time: invitationData.contractEvent,
            )
          : null,
      backgrounds: configs.globalBackgroundsBuilder?.call(),
      particleSphere: configs.particleSphere,
      page: _buildPage,
      tabsBuilder: (int tabActive) {
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
          _buildTab(
            title: langCode == 'en' ? 'Gallery' : 'Galeri',
            icon: Icons.photo_library_rounded,
            tabIndex: index++,
            tabActive: tabActive,
          ),
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

  Widget get _buildPage => switch (initialPage) {
    0 => PageViewTabBarCoverPageAsImage(
      config: configs.coverPageConfig,
      general: invitationData.general,
      bride: invitationData.bride,
      groom: invitationData.groom,
      time: invitationData.contractEvent,
      useWrapper: useWrapper,
    ),
    1 => PageViewTabBarFirstPageAsImage(
      config: configs.firstPageConfig,
      general: invitationData.general,
    ),
    2 => PageViewTabBarSecondPageAsImage(
      config: configs.secondPageConfig,
      bride: invitationData.bride,
      groom: invitationData.groom,
    ),
    3 => PageViewTabBarThirdPageAsImage(
      config: configs.thirdPageConfig,
      contractEvent: invitationData.contractEvent,
      receptionEvent: invitationData.receptionEvent,
    ),
    4 => PageViewTabBarFourthPageAsImage(
      config: configs.fourthPageConfig,
      receptionEvent: invitationData.receptionEvent,
    ),
    5 => PageViewTabBarFifthPageAsImage(
      config: configs.fifthPageConfig,
      gallery: invitationData.gallery,
    ),
    6 => PageViewTabBarSixthPageAsImage(
      config: configs.sixthPageConfig,
      bankAccounts: invitationData.bankAccounts,
    ),
    7 => PageViewTabBarSeventhPageAsImage(config: configs.seventhPageConfig),
    8 => PageViewTabBarEighthPageAsImage(
      config: configs.eighthPageConfig,
      general: invitationData.general,
      brideName: invitationData.bride.nickname,
      groomName: invitationData.groom.nickname,
      brandProfile: brandProfile,
    ),
    int() => const SizedBox.shrink(),
  };

  Widget _buildTab({
    required String title,
    required IconData icon,
    required int tabIndex,
    required int tabActive,
  }) => Tab(
    height: 48,
    child: _Tab(
      config: configs.tabConfig,
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
