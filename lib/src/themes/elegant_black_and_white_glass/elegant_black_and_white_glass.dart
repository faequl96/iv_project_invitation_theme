import 'package:flutter/material.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/src/core/app_fonts.dart';
import 'package:iv_project_invitation_theme/src/core/utils/audio.dart';
import 'package:iv_project_invitation_theme/src/core/utils/font_scale.dart';
import 'package:iv_project_invitation_theme/src/core/utils/screen_util.dart';
import 'package:iv_project_invitation_theme/src/core/utils/size_scale.dart';
import 'package:iv_project_invitation_theme/src/models/invitation.dart';
import 'package:iv_project_invitation_theme/src/opener/initializer_wrapper.dart';
import 'package:iv_project_invitation_theme/src/page_types/page_view_with_bottom_tab_bar.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_black_and_white_glass/pages/elegant_black_and_white_glass_cover_page.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_black_and_white_glass/pages/elegant_black_and_white_glass_eighth_page.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_black_and_white_glass/pages/elegant_black_and_white_glass_fifth_page.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_black_and_white_glass/pages/elegant_black_and_white_glass_first_page.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_black_and_white_glass/pages/elegant_black_and_white_glass_fourth_page.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_black_and_white_glass/pages/elegant_black_and_white_glass_second_page.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_black_and_white_glass/pages/elegant_black_and_white_glass_seventh_page.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_black_and_white_glass/pages/elegant_black_and_white_glass_sixth_page.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_black_and_white_glass/pages/elegant_black_and_white_glass_third_page.dart';

class ElegantBlackAndWhiteGlass extends StatefulWidget {
  const ElegantBlackAndWhiteGlass({super.key, required this.invitation});

  final Invitation invitation;

  @override
  State<ElegantBlackAndWhiteGlass> createState() => _ElegantBlackAndWhiteGlassState();
}

class _ElegantBlackAndWhiteGlassState extends State<ElegantBlackAndWhiteGlass> {
  late final Size _size;
  late final EdgeInsets _padding;

  @override
  void initState() {
    super.initState();

    Audio.initPlayer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _size = MediaQuery.of(GlobalContextService.value).size;
    _padding = MediaQuery.of(GlobalContextService.value).padding;

    late final Size size;
    if (_size.width > 440) {
      if (_size.height < 915) {
        size = Size(412, _size.height - (_padding.top + _padding.bottom));
      } else {
        size = const Size(412, 915);
      }
    } else {
      if (_size.height < 915) {
        size = Size(_size.width, _size.height - (_padding.top + _padding.bottom));
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
    return Column(
      children: [
        SizedBox(height: _padding.top),
        Expanded(
          child: Stack(
            children: [
              PageViewWithBottomTabBar(
                pages: const [
                  ElegantBlackAndWhiteGlassCoverPage(),
                  ElegantBlackAndWhiteGlassFirstPage(),
                  ElegantBlackAndWhiteGlassSecondPage(),
                  ElegantBlackAndWhiteGlassThirdPage(),
                  ElegantBlackAndWhiteGlassFourthPage(),
                  ElegantBlackAndWhiteGlassFifthPage(),
                  ElegantBlackAndWhiteGlassSixthPage(),
                  ElegantBlackAndWhiteGlassSeventhPage(),
                  ElegantBlackAndWhiteGlassEighthPage(),
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
                  Tab(
                    height: 48,
                    child: _Tab(title: 'Acara', icon: Icons.event, tabIndex: 3, tabActive: tabActive),
                  ),
                  Tab(
                    height: 48,
                    child: _Tab(title: 'Lokasi', icon: Icons.location_pin, tabIndex: 4, tabActive: tabActive),
                  ),
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
              const InitializerWrapper(),
            ],
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
