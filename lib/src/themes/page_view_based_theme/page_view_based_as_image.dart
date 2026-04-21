import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/src/opener/initializer_wrapper_as_image.dart';
import 'package:iv_project_invitation_theme/src/page_types/page_view_with_bottom_tab_bar_as_image.dart';
import 'package:iv_project_invitation_theme/src/page_types/page_view_with_bottom_tab_bar_config.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/page_view_based_configs.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/as_image/page_view_based_cover_page_as_image.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/as_image/page_view_based_eighth_page_as_image.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/as_image/page_view_based_fifth_page_as_image.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/as_image/page_view_based_first_page_as_image.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/as_image/page_view_based_fourth_page_as_image.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/as_image/page_view_based_second_page_as_image.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/as_image/page_view_based_seventh_page_as_image.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/as_image/page_view_based_sixth_page_as_image.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/pages/as_image/page_view_based_third_page_as_image.dart';
import 'package:iv_project_model/iv_project_model.dart';

class PageViewBasedAsImage extends StatelessWidget {
  const PageViewBasedAsImage({
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

  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    return PageViewWithBottomTabBarAsImage(
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
      page: _page,
      tabsBuilder: (int tabActive) => [
        Tab(
          height: 48,
          child: _Tab(config: configs.tabConfig, title: 'Cover', icon: Icons.image, tabIndex: 0, tabActive: tabActive),
        ),
        Tab(
          height: 48,
          child: _Tab(
            config: configs.tabConfig,
            title: langCode == 'en' ? 'Intent and Purpose' : 'Maksud Dan Tujuan',
            icon: Icons.lightbulb,
            tabIndex: 1,
            tabActive: tabActive,
          ),
        ),
        Tab(
          height: 48,
          child: _Tab(
            config: configs.tabConfig,
            title: langCode == 'en' ? 'Inviter' : 'Pengundang',
            icon: Icons.people,
            tabIndex: 2,
            tabActive: tabActive,
          ),
        ),
        Tab(
          height: 48,
          child: _Tab(
            config: configs.tabConfig,
            title: langCode == 'en' ? 'Event' : 'Acara',
            icon: Icons.event,
            tabIndex: 3,
            tabActive: tabActive,
          ),
        ),
        Tab(
          height: 48,
          child: _Tab(
            config: configs.tabConfig,
            title: langCode == 'en' ? 'Location' : 'Lokasi',
            icon: Icons.location_pin,
            tabIndex: 4,
            tabActive: tabActive,
          ),
        ),
        Tab(
          height: 48,
          child: _Tab(
            config: configs.tabConfig,
            title: langCode == 'en' ? 'Gallery' : 'Galeri',
            icon: Icons.photo_library_rounded,
            tabIndex: 5,
            tabActive: tabActive,
          ),
        ),
        Tab(
          height: 48,
          child: _Tab(
            config: configs.tabConfig,
            title: langCode == 'en' ? 'Gift' : 'Kado',
            icon: Icons.card_giftcard,
            tabIndex: 6,
            tabActive: tabActive,
          ),
        ),
        Tab(
          height: 48,
          child: _Tab(config: configs.tabConfig, title: 'RSVP', icon: Icons.event_available, tabIndex: 7, tabActive: tabActive),
        ),
        Tab(
          height: 48,
          child: _Tab(
            config: configs.tabConfig,
            title: langCode == 'en' ? 'Thank You' : 'Terima Kasih',
            icon: Icons.emoji_emotions,
            tabIndex: 8,
            tabActive: tabActive,
          ),
        ),
      ],
    );
  }

  Widget get _page => switch (initialPage) {
    0 => PageViewBasedCoverPageAsImage(
      config: configs.coverPageConfig,
      general: invitationData.general,
      bride: invitationData.bride,
      groom: invitationData.groom,
      time: invitationData.contractEvent,
      useWrapper: useWrapper,
    ),
    1 => PageViewBasedFirstPageAsImage(config: configs.firstPageConfig, general: invitationData.general),
    2 => PageViewBasedSecondPageAsImage(
      config: configs.secondPageConfig,
      bride: invitationData.bride,
      groom: invitationData.groom,
    ),
    3 => PageViewBasedThirdPageAsImage(
      config: configs.thirdPageConfig,
      contractEvent: invitationData.contractEvent,
      receptionEvent: invitationData.receptionEvent,
    ),
    4 => PageViewBasedFourthPageAsImage(config: configs.fourthPageConfig, receptionEvent: invitationData.receptionEvent),
    5 => PageViewBasedFifthPageAsImage(config: configs.fifthPageConfig, gallery: invitationData.gallery),
    6 => PageViewBasedSixthPageAsImage(config: configs.sixthPageConfig, bankAccounts: invitationData.bankAccounts),
    7 => PageViewBasedSeventhPageAsImage(config: configs.seventhPageConfig),
    8 => PageViewBasedEighthPageAsImage(
      config: configs.eighthPageConfig,
      general: invitationData.general,
      brideName: invitationData.bride.nickname,
      groomName: invitationData.groom.nickname,
      brandProfile: brandProfile,
    ),
    int() => const SizedBox.shrink(),
  };
}

class _Tab extends StatelessWidget {
  const _Tab({required this.config, required this.title, required this.icon, required this.tabIndex, required this.tabActive});

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
          ),
        ),
      ],
    );
  }
}
