import 'package:flutter/material.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/core/app_fonts.dart';
// import 'package:iv_project_invitation_theme/src/core/utils/audio.dart';
import 'package:iv_project_invitation_theme/src/opener/initializer_wrapper.dart';
import 'package:iv_project_invitation_theme/src/page_types/page_view_with_bottom_tab_bar.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_black_and_white_glass/pages/elegant_black_and_white_glass_cover_page.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_black_and_white_glass/pages/elegant_black_and_white_glass_eighth_page.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_black_and_white_glass/pages/elegant_black_and_white_glass_fifth_page.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_black_and_white_glass/pages/elegant_black_and_white_glass_first_page.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_black_and_white_glass/pages/elegant_black_and_white_glass_fourth_different_location_page.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_black_and_white_glass/pages/elegant_black_and_white_glass_fourth_page.dart';
// import 'package:iv_project_invitation_theme/src/themes/elegant_black_and_white_glass/pages/elegant_black_and_white_glass_fourth_page.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_black_and_white_glass/pages/elegant_black_and_white_glass_second_page.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_black_and_white_glass/pages/elegant_black_and_white_glass_seventh_page.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_black_and_white_glass/pages/elegant_black_and_white_glass_sixth_page.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_black_and_white_glass/pages/elegant_black_and_white_glass_third_different_location_page.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_black_and_white_glass/pages/elegant_black_and_white_glass_third_page.dart';
import 'package:iv_project_model/iv_project_model.dart';

class ElegantBlackAndWhiteGlass extends StatefulWidget {
  const ElegantBlackAndWhiteGlass({
    super.key,
    this.heightAdjustment = 0,
    required this.previewType,
    required this.invitationData,
    this.imagesRaw,
  });

  final double heightAdjustment;
  final ThemePreviewType previewType;
  final InvitationDataResponse invitationData;
  final ImagesRaw? imagesRaw;

  @override
  State<ElegantBlackAndWhiteGlass> createState() => _ElegantBlackAndWhiteGlassState();
}

class _ElegantBlackAndWhiteGlassState extends State<ElegantBlackAndWhiteGlass> {
  late final Size _size;
  late final EdgeInsets _padding;

  @override
  void initState() {
    super.initState();

    // Audio.initPlayer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _size = MediaQuery.of(GlobalContextService.value).size;
    _padding = MediaQuery.of(GlobalContextService.value).padding;

    late final Size size;
    if (_size.width > 440) {
      if (_size.height < 915) {
        size = Size(412, _size.height - (_padding.top + widget.heightAdjustment + _padding.bottom));
      } else {
        size = const Size(412, 915);
      }
    } else {
      if (_size.height < 915) {
        size = Size(_size.width, _size.height - (_padding.top + widget.heightAdjustment + _padding.bottom));
      } else {
        size = Size(_size.width, 915);
      }
    }

    ScreenUtil.set(size);
    FontScale.set(size.width);
    SizeScale.set(size);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageViewWithBottomTabBar(
          heightAdjustment: widget.heightAdjustment,
          pages: [
            ElegantBlackAndWhiteGlassCoverPage(
              previewType: widget.previewType,
              coverImage: widget.imagesRaw?.coverImage,
              general: widget.invitationData.general,
              bride: widget.invitationData.bride,
              groom: widget.invitationData.groom,
              time: widget.invitationData.contractEvent,
            ),
            ElegantBlackAndWhiteGlassFirstPage(general: widget.invitationData.general),
            ElegantBlackAndWhiteGlassSecondPage(
              previewType: widget.previewType,
              brideImage: widget.imagesRaw?.brideImage,
              groomImage: widget.imagesRaw?.groomImage,
              bride: widget.invitationData.bride,
              groom: widget.invitationData.groom,
            ),
            if (widget.invitationData.contractEvent.mapsUrl == widget.invitationData.receptionEvent.mapsUrl) ...[
              ElegantBlackAndWhiteGlassThirdPage(
                contractEvent: widget.invitationData.contractEvent,
                receptionEvent: widget.invitationData.receptionEvent,
              ),
              ElegantBlackAndWhiteGlassFourthPage(receptionEvent: widget.invitationData.receptionEvent),
            ] else ...[
              ElegantBlackAndWhiteGlassThirdDifferentLocationPage(contractEvent: widget.invitationData.contractEvent),
              ElegantBlackAndWhiteGlassFourthDifferentLocationPage(receptionEvent: widget.invitationData.receptionEvent),
            ],
            ElegantBlackAndWhiteGlassFifthPage(
              previewType: widget.previewType,
              galleries: widget.imagesRaw?.galleries,
              gallery: widget.invitationData.gallery,
            ),
            ElegantBlackAndWhiteGlassSixthPage(bankAccounts: widget.invitationData.bankAccounts),
            const ElegantBlackAndWhiteGlassSeventhPage(),
            ElegantBlackAndWhiteGlassEighthPage(general: widget.invitationData.general),
          ],
          tabsBuilder: (int tabActive) => [
            Tab(
              height: 48,
              child: _Tab(title: 'Cover', icon: Icons.image, tabIndex: 0, tabActive: tabActive),
            ),
            Tab(
              height: 48,
              child: _Tab(title: 'Maksud Dan Tujuan', icon: Icons.lightbulb, tabIndex: 1, tabActive: tabActive),
            ),
            Tab(
              height: 48,
              child: _Tab(title: 'Pengundang', icon: Icons.people, tabIndex: 2, tabActive: tabActive),
            ),
            if (widget.invitationData.contractEvent.mapsUrl == widget.invitationData.receptionEvent.mapsUrl) ...[
              Tab(
                height: 48,
                child: _Tab(title: 'Akad Nikah', icon: Icons.volunteer_activism, tabIndex: 3, tabActive: tabActive),
              ),
              Tab(
                height: 48,
                child: _Tab(title: 'Resepsi', icon: Icons.celebration, tabIndex: 4, tabActive: tabActive),
              ),
            ] else ...[
              Tab(
                height: 48,
                child: _Tab(title: 'Acara', icon: Icons.event, tabIndex: 3, tabActive: tabActive),
              ),
              Tab(
                height: 48,
                child: _Tab(title: 'Lokasi', icon: Icons.location_pin, tabIndex: 4, tabActive: tabActive),
              ),
            ],
            Tab(
              height: 48,
              child: _Tab(title: 'Galeri', icon: Icons.photo_library_rounded, tabIndex: 5, tabActive: tabActive),
            ),
            Tab(
              height: 48,
              child: _Tab(title: 'Kado', icon: Icons.card_giftcard, tabIndex: 6, tabActive: tabActive),
            ),
            Tab(
              height: 48,
              child: _Tab(title: 'RSVP', icon: Icons.event_available, tabIndex: 7, tabActive: tabActive),
            ),
            Tab(
              height: 48,
              child: _Tab(title: 'Terima Kasih', icon: Icons.emoji_emotions, tabIndex: 7, tabActive: tabActive),
            ),
          ],
        ),
        InitializerWrapper(
          bride: widget.invitationData.bride,
          groom: widget.invitationData.groom,
          time: widget.invitationData.contractEvent,
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
  final int tabActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Row(
            children: [
              Icon(icon, size: 20, color: tabIndex == tabActive ? Colors.white : Colors.grey.shade400),
              const SizedBox(width: 8),
              Text(
                title,
                style: AppFonts.inter(
                  color: tabIndex == tabActive ? Colors.white : Colors.grey.shade400,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
