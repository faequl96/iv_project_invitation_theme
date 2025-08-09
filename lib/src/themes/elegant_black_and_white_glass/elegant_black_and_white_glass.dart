import 'package:flutter/material.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/src/core/utils/audio.dart';
import 'package:iv_project_invitation_theme/src/core/utils/font_scale.dart';
import 'package:iv_project_invitation_theme/src/core/utils/screen_util.dart';
import 'package:iv_project_invitation_theme/src/core/utils/size_scale.dart';
import 'package:iv_project_invitation_theme/src/models/invitation.dart';
import 'package:iv_project_invitation_theme/src/opener/initializer_wrapper.dart';
import 'package:iv_project_invitation_theme/src/page_types/page_view_with_bottom_tab_bar.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_black_and_white_glass/pages/elegant_black_and_white_glass_cover_page.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_black_and_white_glass/pages/elegant_black_and_white_glass_first_page.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_black_and_white_glass/pages/elegant_black_and_white_glass_fourth_page.dart';
import 'package:iv_project_invitation_theme/src/themes/elegant_black_and_white_glass/pages/elegant_black_and_white_glass_second_page.dart';
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
      if (_size.height < 812) {
        size = Size(375, _size.height - (_padding.top + _padding.bottom));
      } else {
        size = const Size(375, 812);
      }
    } else {
      if (_size.height < 812) {
        size = Size(_size.width, _size.height - (_padding.top + _padding.bottom));
      } else {
        size = Size(_size.width, 812);
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
                ],
                tabsBuilder: (int tabActive) => [
                  Tab(
                    height: 48,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 6),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Row(
                            children: [
                              Icon(Icons.drafts, color: tabActive == 0 ? Colors.grey.shade50 : Colors.grey.shade400),
                              const SizedBox(width: 8),
                              Text('Cover', style: TextStyle(color: tabActive == 0 ? Colors.grey.shade50 : Colors.grey.shade400)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    height: 48,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 6),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Row(
                            children: [
                              Icon(Icons.drafts, color: tabActive == 1 ? Colors.grey.shade50 : Colors.grey.shade400),
                              const SizedBox(width: 8),
                              Text(
                                'Maksud Dan Tujuan',
                                style: TextStyle(color: tabActive == 1 ? Colors.grey.shade50 : Colors.grey.shade400),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    height: 48,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 6),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Row(
                            children: [
                              Icon(Icons.drafts, color: tabActive == 2 ? Colors.grey.shade50 : Colors.grey.shade400),
                              const SizedBox(width: 8),
                              Text(
                                'Mengundang',
                                style: TextStyle(color: tabActive == 2 ? Colors.grey.shade50 : Colors.grey.shade400),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    height: 48,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 6),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Row(
                            children: [
                              Icon(Icons.drafts, color: tabActive == 3 ? Colors.grey.shade50 : Colors.grey.shade400),
                              const SizedBox(width: 8),
                              Text('Waktu', style: TextStyle(color: tabActive == 3 ? Colors.grey.shade50 : Colors.grey.shade400)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    height: 48,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 6),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Row(
                            children: [
                              Icon(Icons.drafts, color: tabActive == 4 ? Colors.grey.shade50 : Colors.grey.shade400),
                              const SizedBox(width: 8),
                              Text(
                                'Lokasi',
                                style: TextStyle(color: tabActive == 4 ? Colors.grey.shade50 : Colors.grey.shade400),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
