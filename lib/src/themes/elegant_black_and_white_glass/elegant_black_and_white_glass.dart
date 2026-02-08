import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
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
    required this.viewType,
    required this.invitationId,
    required this.invitationData,
    this.imagesRaw,
    required this.brandProfile,
    this.useWrapper = true,
    this.initialPage = 0,
    this.isSinglePageView = false,
  });

  final double heightAdjustment;
  final ViewType viewType;
  final String invitationId;
  final InvitationDataResponse invitationData;
  final ImagesRaw? imagesRaw;
  final BrandProfileResponse brandProfile;
  final bool useWrapper;
  final int initialPage;
  final bool isSinglePageView;

  @override
  State<ElegantBlackAndWhiteGlass> createState() => _ElegantBlackAndWhiteGlassState();
}

class _ElegantBlackAndWhiteGlassState extends State<ElegantBlackAndWhiteGlass> with WidgetsBindingObserver {
  late final InvitationThemeCoreCubit _coreCubit;

  bool _isGalleriesNotEmpty = false;

  void _setSize() {
    final size = MediaQuery.of(GlobalContextService.value).size;
    final padding = MediaQuery.of(GlobalContextService.value).padding;

    late final Size finalSize;
    if (size.width > 440) {
      if (size.height < 915) {
        finalSize = Size(412, size.height - (padding.top + widget.heightAdjustment + padding.bottom));
      } else {
        finalSize = const Size(412, 915);
      }
    } else {
      if (size.height < 915) {
        finalSize = Size(size.width, size.height - (padding.top + widget.heightAdjustment + padding.bottom));
      } else {
        finalSize = Size(size.width, 915);
      }
    }

    Screen.set(finalSize);
    H.set(finalSize.height);
    W.set(finalSize.width);
    FontSize.set(finalSize.width);

    _coreCubit.state.copyWith(size: finalSize).emitState();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    _coreCubit = context.read<InvitationThemeCoreCubit>();

    if (widget.viewType == ViewType.preview) {
      if (widget.imagesRaw != null) {
        for (final file in widget.imagesRaw!.galleries) {
          if (file != null) {
            _isGalleriesNotEmpty = true;
            break;
          }
        }
      }
    } else {
      final gallery = widget.invitationData.gallery;
      if (gallery != null) {
        if (gallery.imageURL1 != null ||
            gallery.imageURL2 != null ||
            gallery.imageURL3 != null ||
            gallery.imageURL4 != null ||
            gallery.imageURL5 != null ||
            gallery.imageURL6 != null ||
            gallery.imageURL7 != null ||
            gallery.imageURL8 != null ||
            gallery.imageURL9 != null ||
            gallery.imageURL10 != null ||
            gallery.imageURL11 != null ||
            gallery.imageURL12 != null) {
          _isGalleriesNotEmpty = true;
        }
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _setSize();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();

    _setSize();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    return Stack(
      children: [
        PageViewWithBottomTabBar(
          heightAdjustment: widget.heightAdjustment,
          useWrapper: widget.useWrapper,
          initialPage: widget.initialPage,
          pages: [
            ElegantBlackAndWhiteGlassCoverPage(
              viewType: widget.viewType,
              coverImage: widget.imagesRaw?.coverImage,
              general: widget.invitationData.general,
              bride: widget.invitationData.bride,
              groom: widget.invitationData.groom,
              time: widget.invitationData.contractEvent,
            ),
            ElegantBlackAndWhiteGlassFirstPage(general: widget.invitationData.general),
            ElegantBlackAndWhiteGlassSecondPage(
              viewType: widget.viewType,
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
            if (_isGalleriesNotEmpty)
              ElegantBlackAndWhiteGlassFifthPage(
                viewType: widget.viewType,
                galleries: widget.imagesRaw?.galleries,
                gallery: widget.invitationData.gallery,
              ),
            ElegantBlackAndWhiteGlassSixthPage(bankAccounts: widget.invitationData.bankAccounts),
            ElegantBlackAndWhiteGlassSeventhPage(viewType: widget.viewType, invitationId: widget.invitationId),
            ElegantBlackAndWhiteGlassEighthPage(
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
              child: _Tab(
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
              child: _Tab(
                title: langCode == 'en' ? 'Gift' : 'Kado',
                icon: Icons.card_giftcard,
                tabIndex: 6,
                tabActive: tabActive,
              ),
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
        ),
        if (widget.useWrapper)
          InitializerWrapper(
            viewType: widget.viewType,
            bride: widget.invitationData.bride,
            groom: widget.invitationData.groom,
            time: widget.invitationData.contractEvent,
          ),
        if (widget.isSinglePageView)
          const SizedBox(
            height: double.maxFinite,
            width: double.maxFinite,
            child: ColoredBox(color: Colors.transparent),
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
