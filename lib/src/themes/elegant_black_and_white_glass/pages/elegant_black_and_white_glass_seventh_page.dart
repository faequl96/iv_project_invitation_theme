import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/core/app_fonts.dart';
import 'package:iv_project_invitation_theme/src/core/utils/font_scale.dart';
import 'package:iv_project_invitation_theme/src/core/utils/screen_util.dart';
import 'package:iv_project_invitation_theme/src/core/utils/size_scale.dart';
import 'package:iv_project_invitation_theme/src/enums/enums.dart';
import 'package:iv_project_invitation_theme/src/models/invited_guest.dart';
import 'package:iv_project_invitation_theme/src/models/rsvp.dart';
import 'package:iv_project_invitation_theme/src/widgets/enhanced_general_text_field.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_invitation_theme/src/widgets/glass_effect_box.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class ElegantBlackAndWhiteGlassSeventhPage extends StatelessWidget {
  const ElegantBlackAndWhiteGlassSeventhPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CoreCubit, CoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => Stack(
        children: [
          Positioned(
            top: 0,
            height: ScreenUtil.size.height / 1.4,
            width: ScreenUtil.size.width,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.grey.shade900, Colors.transparent],
                  stops: const [.2, .8],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: FadeAndSlideTransition(
              slideFromOffset: .5,
              slideFrom: SlideFrom.top,
              child: SizedBox(
                height: SizeScale.heightX6l,
                width: ScreenUtil.size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.event_available, size: SizeScale.widthXs, color: Colors.grey.shade200),
                    const SizedBox(width: 10),
                    Text(
                      'RSVP Dan Ucapan',
                      style: AppFonts.inter(color: Colors.grey.shade200, fontSize: FontScale.x3l, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            height: ScreenUtil.size.height,
            width: ScreenUtil.size.width,
            child: Padding(
              padding: EdgeInsets.only(top: SizeScale.heightX6l, left: SizeScale.widthX6s, right: SizeScale.widthX6s, bottom: 76),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black.withValues(alpha: .6), Colors.black.withValues(alpha: .6)],
                        stops: const [0, 1],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            height: ScreenUtil.size.height,
            width: ScreenUtil.size.width,
            child: Padding(
              padding: EdgeInsets.only(top: SizeScale.heightX6l, left: SizeScale.widthX6s, right: SizeScale.widthX6s, bottom: 76),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: .5, color: Colors.grey.shade500),
                ),
                child: ClipRect(
                  child: Column(
                    children: [
                      SizedBox(height: SizeScale.widthX5s),
                      const RSVPForm(),
                      SizedBox(height: SizeScale.heightX8s),
                      Expanded(
                        child: FadeAndSlideTransition(
                          slideFromOffset: .5,
                          slideFrom: SlideFrom.bottom,
                          delayBeforeStart: const Duration(milliseconds: 2000),
                          child: SizedBox(
                            width: double.maxFinite,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: SizeScale.widthX6s),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade500.withValues(alpha: .3),
                                  border: Border.all(color: Colors.grey.shade500, width: .5),
                                  borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(10),
                                    topRight: const Radius.circular(10),
                                    bottomLeft: Radius.circular((SizeScale.widthLg + SizeScale.heightX10s) / 2),
                                    bottomRight: Radius.circular((SizeScale.widthLg + SizeScale.heightX10s) / 2),
                                  ),
                                ),
                                child: Stack(
                                  alignment: AlignmentGeometry.bottomCenter,
                                  children: [
                                    const _RSVPsWidget(isShowMore: false),
                                    GeneralEffectsButton(
                                      onTap: () {
                                        ShowModal.bottomSheet(
                                          context,
                                          barrierColor: Colors.grey.shade700.withValues(alpha: .5),
                                          header: BottomSheetHeader(
                                            useHandleBar: true,
                                            handleColor: Colors.grey.shade500,
                                            action: HeaderAction(
                                              actionIcon: Icons.close_rounded,
                                              iconColor: Colors.grey.shade400,
                                              onTap: () => NavigationService.pop(),
                                            ),
                                          ),
                                          decoration: BottomSheetDecoration(
                                            color: Colors.black.withValues(alpha: .85),
                                            borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            ),
                                          ),
                                          contentBuilder: (_) {
                                            return SizedBox(
                                              height: ScreenUtil.size.height - SizeScale.heightX15l,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  left: SizeScale.widthX6s,
                                                  right: SizeScale.widthX6s,
                                                  bottom: SizeScale.widthX6s,
                                                ),
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey.shade700.withValues(alpha: .5),
                                                    borderRadius: BorderRadius.circular(16),
                                                  ),
                                                  child: const _RSVPsWidget(isShowMore: true),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      width: double.maxFinite,
                                      height: SizeScale.widthLg + SizeScale.heightX10s,
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(width: .5, color: Colors.grey.shade500),
                                      color: Colors.grey.shade900.withValues(alpha: .8),
                                      child: Stack(
                                        alignment: AlignmentDirectional.center,
                                        children: [
                                          Text(
                                            'Selengkapnya',
                                            style: AppFonts.inter(
                                              color: Colors.grey.shade100,
                                              fontSize: FontScale.md,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: SizeScale.widthX5s),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            height: ScreenUtil.size.height,
            width: ScreenUtil.size.width,
            child: Padding(
              padding: EdgeInsets.only(top: SizeScale.heightX6l, left: SizeScale.widthX6s, right: SizeScale.widthX6s, bottom: 76),
              child: GlassEffectBox(
                width: ScreenUtil.size.width - 32,
                height: ScreenUtil.size.height - (76 + SizeScale.heightX6l),
                borderRadius: 20,
                sliderWidth: 90,
                color: Colors.grey.shade300.withValues(alpha: .3),
                animationSpeed: const Duration(milliseconds: 600),
                delayBeforeStart: const Duration(milliseconds: 3500),
                animationInterval: const Duration(seconds: 4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RSVPForm extends StatefulWidget {
  const RSVPForm({super.key});

  @override
  State<RSVPForm> createState() => _RSVPFormState();
}

class _RSVPFormState extends State<RSVPForm> {
  final _nameController = TextEditingController();
  final _greetingController = TextEditingController();

  final _avatar = ValueNotifier<String?>(null);
  final _attendance = ValueNotifier<String?>(null);

  @override
  void dispose() {
    _nameController.dispose();
    _greetingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeScale.widthX6s),
          child: FadeAndSlideTransition(
            slideFromOffset: .4,
            slideFrom: SlideFrom.left,
            delayBeforeStart: const Duration(milliseconds: 800),
            child: EnhancedGeneralTextField(textEditingController: _nameController, labelTextBuilder: () => 'Nama'),
          ),
        ),
        SizedBox(height: SizeScale.heightX8s),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeScale.widthX6s),
          child: FadeAndSlideTransition(
            slideFromOffset: .4,
            slideFrom: SlideFrom.left,
            delayBeforeStart: const Duration(milliseconds: 700),
            child: ValueListenableBuilder(
              valueListenable: _avatar,
              builder: (_, _, _) {
                return OverlayDropdownField(
                  height: SizeScale.heightX3l,
                  style: AppFonts.inter(color: Colors.grey.shade100, fontSize: FontScale.md),
                  decoration: FieldDecoration(
                    labelText: 'Avatar',
                    labelStyle: AppFonts.inter(color: Colors.grey.shade300, fontSize: FontScale.md),
                    filled: true,
                    fillColor: Colors.grey.shade500.withValues(alpha: .3),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade600, width: 1),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade600, width: 1),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade600, width: 1),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    suffixIcon: () {
                      return PreSufFixIcon(
                        onTap: () {},
                        child: Image.asset(
                          'assets/avatars/${_avatar.value ?? 'avatars'}.png',
                          package: 'iv_project_invitation_theme',
                          height: 24,
                          width: 24,
                        ),
                      );
                    },
                  ),
                  overlayYOffset: 6,
                  overlayBarrier: const ModalBarrier(),
                  overlaydecoration: OverlayDecoration(
                    height: SizeScale.heightX15l,
                    color: Colors.grey.shade700.withValues(alpha: .95),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    border: Border.all(color: Colors.grey.shade500),
                  ),
                  dropdownItemDecoration: DropdownItemDecoration(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                    selectedColor: Colors.grey.shade500,
                    hoveredColor: Colors.grey.shade400,
                    splashColor: Colors.grey.shade400,
                  ),
                  value: _avatar.value,
                  dropdownItems: Avatars.values.map((item) => item.name).toList(),
                  dropdownItemBuilder: (value) {
                    return Row(
                      children: [
                        Image.asset('assets/avatars/$value.png', package: 'iv_project_invitation_theme', height: 28, width: 28),
                        const SizedBox(width: 6),
                        Text(
                          value,
                          style: AppFonts.inter(color: Colors.grey.shade100, fontSize: FontScale.md),
                        ),
                      ],
                    );
                  },
                  onSelected: (value) => _avatar.value = value,
                );
              },
            ),
          ),
        ),
        SizedBox(height: SizeScale.heightX8s),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeScale.widthX6s),
          child: FadeAndSlideTransition(
            slideFromOffset: .4,
            slideFrom: SlideFrom.left,
            delayBeforeStart: const Duration(milliseconds: 600),
            child: ValueListenableBuilder(
              valueListenable: _attendance,
              builder: (_, _, _) {
                return OverlayDropdownField(
                  height: SizeScale.heightX3l,
                  style: AppFonts.inter(color: Colors.grey.shade100, fontSize: FontScale.md),
                  decoration: FieldDecoration(
                    labelText: 'Kehadiran',
                    labelStyle: AppFonts.inter(color: Colors.grey.shade300, fontSize: FontScale.md),
                    filled: true,
                    fillColor: Colors.grey.shade500.withValues(alpha: .3),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade600, width: 1),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade600, width: 1),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade600, width: 1),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    suffixIcon: () {
                      return PreSufFixIcon(
                        onTap: () {},
                        child: Icon(Icons.arrow_drop_down, color: Colors.grey.shade100),
                      );
                    },
                  ),
                  overlayYOffset: 6,
                  overlayBarrier: const ModalBarrier(),
                  overlaydecoration: OverlayDecoration(
                    color: Colors.grey.shade700.withValues(alpha: .95),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    border: Border.all(color: Colors.grey.shade500),
                  ),
                  dropdownItemDecoration: DropdownItemDecoration(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                    selectedColor: Colors.grey.shade500,
                    hoveredColor: Colors.grey.shade400,
                    splashColor: Colors.grey.shade400,
                  ),
                  value: _attendance.value,
                  dropdownItems: Attendance.values.map((item) => item.description).toList(),
                  dropdownItemBuilder: (value) {
                    return Text(
                      value,
                      style: AppFonts.inter(color: Colors.grey.shade100, fontSize: FontScale.md),
                    );
                  },
                  onSelected: (value) => _attendance.value = value,
                );
              },
            ),
          ),
        ),
        SizedBox(height: SizeScale.heightX8s),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeScale.widthX6s),
          child: FadeAndSlideTransition(
            slideFromOffset: .4,
            slideFrom: SlideFrom.left,
            delayBeforeStart: const Duration(milliseconds: 500),
            child: EnhancedGeneralTextField(
              textEditingController: _greetingController,
              labelTextBuilder: () => 'Ucapan',
              maxLines: 2,
              isMandatory: false,
            ),
          ),
        ),
        SizedBox(height: SizeScale.heightX8s),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeScale.widthX6s),
          child: FadeAndSlideTransition(
            slideFromOffset: .8,
            slideFrom: SlideFrom.bottom,
            animationSpeed: const Duration(milliseconds: 300),
            delayBeforeStart: const Duration(milliseconds: 1200),
            child: GeneralEffectsButton(
              onTap: () {},
              width: double.maxFinite,
              height: SizeScale.widthLg + SizeScale.heightX10s,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(width: .5, color: Colors.grey.shade500),
              color: Colors.black.withValues(alpha: .3),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Text(
                    'Submit',
                    style: AppFonts.inter(color: Colors.grey.shade100, fontSize: FontScale.md, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _RSVPsWidget extends StatefulWidget {
  const _RSVPsWidget({required this.isShowMore});

  final bool isShowMore;

  @override
  State<_RSVPsWidget> createState() => _RSVPsWidgetState();
}

class _RSVPsWidgetState extends State<_RSVPsWidget> {
  final bool _isLoading = false;
  final List<RSVP> _rsvps = [
    RSVP(
      invitedGuestId: 'guest_1',
      avatar: 'angry',
      invited: false,
      attendance: 'Tidak Hadir',
      remark:
          'Happy wedding Rahma dan FAeq. Semoga samawa dan bahagia terus yaa. So happy for u guys!!! Maafkan belum bisa hadir.',
      dateTime: 1756004674463,
    ),
    RSVP(
      invitedGuestId: 'guest_2',
      avatar: 'happy',
      invited: false,
      attendance: 'Hadir',
      remark:
          'Happy wedding Rahma dan FAeq. Semoga samawa dan bahagia terus yaa. So happy for u guys!!! Maafkan belum bisa hadir.',
      dateTime: 1756004674463,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: widget.isShowMore ? null : const NeverScrollableScrollPhysics(),
      children: [
        if (_isLoading) ...[
          const SizedBox(height: 8),
          for (int i = 0; i < 4; i++) ...[
            if (i == 3)
              const Column(children: [Text('Skeleton'), SizedBox(height: 4)])
            else ...[
              const Text('Skeleton'),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  height: .5,
                  width: double.maxFinite,
                  child: ColoredBox(color: Colors.grey.shade500),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ],
          const SizedBox(height: 8),
        ] else if (_rsvps.isNotEmpty) ...[
          const SizedBox(height: 8),
          if (_rsvps.length > 3 && widget.isShowMore == false)
            for (int i = 0; i < 3; i++) ...[
              if (i == 2)
                _RSVPItem(rsvp: _rsvps[i])
              else ...[
                _RSVPItem(rsvp: _rsvps[i]),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    height: .5,
                    width: double.maxFinite,
                    child: ColoredBox(color: Colors.grey.shade500),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ]
          else
            for (int i = 0; i < _rsvps.length; i++) ...[
              if (i == _rsvps.length - 1)
                _RSVPItem(rsvp: _rsvps[i])
              else ...[
                _RSVPItem(rsvp: _rsvps[i]),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    height: .5,
                    width: double.maxFinite,
                    child: ColoredBox(color: Colors.grey.shade500),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ],
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}

class _RSVPItem extends StatefulWidget {
  const _RSVPItem({required this.rsvp});

  final RSVP rsvp;

  @override
  State<_RSVPItem> createState() => _RSVPItemState();
}

class _RSVPItemState extends State<_RSVPItem> {
  InvitedGuest? invitedGuest;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.rsvp.invited == false)
            SizedBox(
              height: 32,
              width: 32,
              child: Image(
                image: AssetImage('assets/avatars/${widget.rsvp.avatar}.png', package: 'iv_project_invitation_theme'),
                fit: BoxFit.fitWidth,
              ),
            )
          else if (invitedGuest != null)
            SizedBox(
              height: 32,
              width: 32,
              child: Image(
                image: AssetImage('assets/avatars/${invitedGuest!.avatar}.png', package: 'iv_project_invitation_theme'),
                fit: BoxFit.fitWidth,
              ),
            )
          else
            SizedBox(
              height: 32,
              width: 32,
              child: DecoratedBox(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10))),
            ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (widget.rsvp.invited == false)
                      Text(
                        'Guest_${widget.rsvp.guestName}',
                        style: AppFonts.inter(
                          color: Colors.grey.shade100,
                          fontSize: FontScale.sm,
                          fontWeight: FontWeight.bold,
                          height: 1.16,
                        ),
                      )
                    else if (invitedGuest != null)
                      Text(
                        invitedGuest?.nickName ?? '',
                        style: AppFonts.inter(fontSize: FontScale.sm, fontWeight: FontWeight.w500, height: 1.16),
                      )
                    else
                      SizedBox(
                        height: 12,
                        width: 50 + Random().nextInt(20).toDouble(),
                        child: DecoratedBox(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10))),
                      ),
                    const SizedBox(width: 8),
                    _TimeLapse(dateTimeEpoch: widget.rsvp.dateTime),
                  ],
                ),
                if (widget.rsvp.invited == false)
                  Text(
                    '@__Guest',
                    style: AppFonts.inter(color: Colors.grey.shade400, fontSize: FontScale.xs, height: 1.16),
                  )
                else if (invitedGuest != null)
                  Text(
                    '@${invitedGuest!.nameInstance}',
                    style: AppFonts.inter(color: Colors.grey.shade400, fontSize: FontScale.xs, height: 1.16),
                  )
                else ...[
                  const SizedBox(height: 4),
                  SizedBox(
                    height: 10,
                    width: 100 + Random().nextInt(60).toDouble(),
                    child: DecoratedBox(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10))),
                  ),
                ],
                const SizedBox(height: 4),
                Text(
                  widget.rsvp.attendance,
                  style: AppFonts.inter(
                    color: widget.rsvp.attendance == 'Hadir'
                        ? ColorConverter.lighten(Colors.green, 50)
                        : widget.rsvp.attendance == 'Tidak Hadir'
                        ? ColorConverter.lighten(Colors.red, 50)
                        : Colors.grey.shade700,
                    fontWeight: FontWeight.w400,
                    fontSize: FontScale.xs,
                  ),
                ),
                Text(
                  widget.rsvp.remark,
                  style: AppFonts.inter(color: Colors.grey.shade200, fontSize: FontScale.sm),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TimeLapse extends StatefulWidget {
  const _TimeLapse({required this.dateTimeEpoch});

  final int dateTimeEpoch;

  @override
  State<_TimeLapse> createState() => _TimeLapseState();
}

class _TimeLapseState extends State<_TimeLapse> {
  late final Timer _timer;

  int diffOfMillisecondsSinceEpoch(int value) {
    late int returnValue;
    final int nowMillisecondsSinceEpoch = DateTime.now().millisecondsSinceEpoch;
    returnValue = nowMillisecondsSinceEpoch - value;

    return returnValue;
  }

  String getTime(int value) {
    final Duration duration = Duration(milliseconds: value);

    if (duration.inDays != 0) return '${duration.inDays} hari';
    if (duration.inHours != 0) return '${duration.inHours} jam';
    if (duration.inMinutes != 0) return '${duration.inMinutes} menit';
    return '${duration.inSeconds} detik';
  }

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(minutes: 1), (_) => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      getTime(diffOfMillisecondsSinceEpoch(widget.dateTimeEpoch)),
      style: AppFonts.inter(color: ColorConverter.lighten(Colors.grey, 50)),
    );
  }
}
