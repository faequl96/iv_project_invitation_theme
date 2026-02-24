import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/core/helpers/app_helpers.dart';
import 'package:iv_project_invitation_theme/src/opener/initializer_wrapper.dart';
import 'package:iv_project_invitation_theme/src/page_types/page_view_with_bottom_tab_bar.dart';
import 'package:iv_project_invitation_theme/src/themes/every_page_is_wrapped/pages/every_page_is_wrapped_cover_page.dart';
import 'package:iv_project_invitation_theme/src/themes/every_page_is_wrapped/pages/every_page_is_wrapped_eighth_page.dart';
import 'package:iv_project_invitation_theme/src/themes/every_page_is_wrapped/pages/every_page_is_wrapped_fifth_page.dart';
import 'package:iv_project_invitation_theme/src/themes/every_page_is_wrapped/pages/every_page_is_wrapped_first_page.dart';
import 'package:iv_project_invitation_theme/src/themes/every_page_is_wrapped/pages/every_page_is_wrapped_fourth_different_location_page.dart';
import 'package:iv_project_invitation_theme/src/themes/every_page_is_wrapped/pages/every_page_is_wrapped_fourth_page.dart';
import 'package:iv_project_invitation_theme/src/themes/every_page_is_wrapped/pages/every_page_is_wrapped_second_page.dart';
import 'package:iv_project_invitation_theme/src/themes/every_page_is_wrapped/pages/every_page_is_wrapped_seventh_page.dart';
import 'package:iv_project_invitation_theme/src/themes/every_page_is_wrapped/pages/every_page_is_wrapped_sixth_page.dart';
import 'package:iv_project_invitation_theme/src/themes/every_page_is_wrapped/pages/every_page_is_wrapped_third_different_location_page.dart';
import 'package:iv_project_invitation_theme/src/themes/every_page_is_wrapped/pages/every_page_is_wrapped_third_page.dart';
import 'package:iv_project_model/iv_project_model.dart';

class EveryPageIsWrapped extends StatefulWidget {
  const EveryPageIsWrapped({
    super.key,
    this.heightAdjustment = 0,
    this.initialPage = 0,
    this.viewAsImage = false,
    required this.viewType,
    required this.invitationId,
    required this.invitationData,
    this.imagesRaw,
    required this.brandProfile,
  });

  final double heightAdjustment;
  final int initialPage;
  final bool viewAsImage;
  final ViewType viewType;
  final String invitationId;
  final InvitationDataResponse invitationData;
  final ImagesRaw? imagesRaw;
  final BrandProfileResponse brandProfile;

  @override
  State<EveryPageIsWrapped> createState() => _EveryPageIsWrappedState();
}

class _EveryPageIsWrappedState extends State<EveryPageIsWrapped> with WidgetsBindingObserver {
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
      wrapper: InitializerWrapper(
        viewType: widget.viewType,
        bride: widget.invitationData.bride,
        groom: widget.invitationData.groom,
        time: widget.invitationData.contractEvent,
      ),
      pages: [
        EveryPageIsWrappedCoverPage(
          viewType: widget.viewType,
          coverImage: widget.imagesRaw?.coverImage,
          general: widget.invitationData.general,
          bride: widget.invitationData.bride,
          groom: widget.invitationData.groom,
          time: widget.invitationData.contractEvent,
        ),
        EveryPageIsWrappedFirstPage(general: widget.invitationData.general),
        EveryPageIsWrappedSecondPage(
          viewType: widget.viewType,
          brideImage: widget.imagesRaw?.brideImage,
          groomImage: widget.imagesRaw?.groomImage,
          bride: widget.invitationData.bride,
          groom: widget.invitationData.groom,
        ),
        if (widget.invitationData.contractEvent.mapsUrl == widget.invitationData.receptionEvent.mapsUrl) ...[
          EveryPageIsWrappedThirdPage(
            contractEvent: widget.invitationData.contractEvent,
            receptionEvent: widget.invitationData.receptionEvent,
          ),
          EveryPageIsWrappedFourthPage(receptionEvent: widget.invitationData.receptionEvent),
        ] else ...[
          EveryPageIsWrappedThirdDifferentLocationPage(contractEvent: widget.invitationData.contractEvent),
          EveryPageIsWrappedFourthDifferentLocationPage(receptionEvent: widget.invitationData.receptionEvent),
        ],
        if (_isGalleriesNotEmpty)
          EveryPageIsWrappedFifthPage(
            viewType: widget.viewType,
            galleries: widget.imagesRaw?.galleries,
            gallery: widget.invitationData.gallery,
          ),
        if (widget.invitationData.bankAccounts.isNotEmpty)
          EveryPageIsWrappedSixthPage(bankAccounts: widget.invitationData.bankAccounts),
        EveryPageIsWrappedSeventhPage(viewType: widget.viewType, invitationId: widget.invitationId),
        EveryPageIsWrappedEighthPage(
          general: widget.invitationData.general,
          brideName: widget.invitationData.bride.nickname,
          groomName: widget.invitationData.groom.nickname,
          brandProfile: widget.brandProfile,
        ),
      ],
      tabsBuilder: (ValueNotifier<int> tabActive) => [
        Tab(
          height: 48,
          child: _Tab(title: 'Cover', icon: Icons.image, tabIndex: 0, tabActive: tabActive),
        ),
        Tab(
          height: 48,
          child: _Tab(
            title: langCode == 'en' ? 'Intent and Purpose' : 'Maksud Dan Tujuan',
            icon: Icons.lightbulb,
            tabIndex: 1,
            tabActive: tabActive,
          ),
        ),
        Tab(
          height: 48,
          child: _Tab(title: langCode == 'en' ? 'Inviter' : 'Pengundang', icon: Icons.people, tabIndex: 2, tabActive: tabActive),
        ),
        if (widget.invitationData.contractEvent.mapsUrl != widget.invitationData.receptionEvent.mapsUrl) ...[
          Tab(
            height: 48,
            child: _Tab(
              title: langCode == 'en' ? 'Contract' : 'Akad Nikah',
              icon: Icons.volunteer_activism,
              tabIndex: 3,
              tabActive: tabActive,
            ),
          ),
          Tab(
            height: 48,
            child: _Tab(
              title: langCode == 'en' ? 'Reception' : 'Resepsi',
              icon: Icons.celebration,
              tabIndex: 4,
              tabActive: tabActive,
            ),
          ),
        ] else ...[
          Tab(
            height: 48,
            child: _Tab(title: langCode == 'en' ? 'Event' : 'Acara', icon: Icons.event, tabIndex: 3, tabActive: tabActive),
          ),
          Tab(
            height: 48,
            child: _Tab(
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
              title: langCode == 'en' ? 'Gallery' : 'Galeri',
              icon: Icons.photo_library_rounded,
              tabIndex: 5,
              tabActive: tabActive,
            ),
          ),
        Tab(
          height: 48,
          child: _Tab(title: langCode == 'en' ? 'Gift' : 'Kado', icon: Icons.card_giftcard, tabIndex: 6, tabActive: tabActive),
        ),
        Tab(
          height: 48,
          child: _Tab(title: 'RSVP', icon: Icons.event_available, tabIndex: 7, tabActive: tabActive),
        ),
        Tab(
          height: 48,
          child: _Tab(
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
  const _Tab({required this.title, required this.icon, required this.tabIndex, required this.tabActive});

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
                  Icon(icon, size: 20, color: tabIndex == tabActive ? Colors.white : Colors.grey.shade400),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: AppFonts.inter(color: tabIndex == tabActive ? Colors.white : Colors.grey.shade400, fontWeight: .w500),
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
