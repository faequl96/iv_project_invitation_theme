import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/core/widgets/time_ago.dart';
import 'package:iv_project_invitation_theme/src/widgets/enhanced_general_text_field.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_invitation_theme/src/widgets/glass_effect_box.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:iv_project_web_data/iv_project_web_data.dart';
import 'package:iv_project_widget_core/iv_project_widget_core.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class ElegantBlackAndWhiteGlassSeventhPage extends StatelessWidget {
  const ElegantBlackAndWhiteGlassSeventhPage({super.key, required this.viewType, required this.invitationId});

  final ViewType viewType;
  final String invitationId;

  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    return BlocSelector<InvitationThemeCoreCubit, InvitationThemeCoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => Stack(
        children: [
          Positioned(
            top: 0,
            height: Screen.height / 1.4,
            width: Screen.width,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: .topCenter,
                  end: .bottomCenter,
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
              slideFrom: .top,
              child: SizedBox(
                height: H.x6l,
                width: Screen.width,
                child: Row(
                  mainAxisAlignment: .center,
                  children: [
                    Icon(Icons.event_available, size: W.xs, color: Colors.grey.shade200),
                    const SizedBox(width: 10),
                    Text(
                      langCode == 'en' ? 'RSVP and Greetings' : 'RSVP Dan Ucapan',
                      style: AppFonts.inter(color: Colors.grey.shade200, fontSize: FontSize.x3l, fontWeight: .w700),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            height: Screen.height,
            width: Screen.width,
            child: Padding(
              padding: .only(top: H.x6l, left: W.x6s, right: W.x6s, bottom: 76),
              child: ClipRRect(
                borderRadius: .circular(20),
                child: BackdropFilter(
                  filter: .blur(sigmaX: 3, sigmaY: 3),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: .topCenter,
                        end: .bottomCenter,
                        colors: [Colors.black.withValues(alpha: .6), Colors.black.withValues(alpha: .6)],
                        stops: const [0, 1],
                      ),
                      borderRadius: .circular(20),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            height: Screen.height,
            width: Screen.width,
            child: Padding(
              padding: .only(top: H.x6l, left: W.x6s, right: W.x6s, bottom: 76),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: .circular(20),
                  border: .all(width: .5, color: Colors.grey.shade500),
                ),
                child: ClipRect(
                  child: Column(
                    children: [
                      SizedBox(height: W.x5s),
                      RSVPForm(viewType: viewType, invitationId: invitationId),
                      SizedBox(height: H.x8s),
                      Expanded(
                        child: FadeAndSlideTransition(
                          slideFromOffset: .5,
                          slideFrom: .bottom,
                          delayBeforeStart: const Duration(milliseconds: 2000),
                          child: SizedBox(
                            width: .maxFinite,
                            child: Padding(
                              padding: .symmetric(horizontal: W.x6s),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade500.withValues(alpha: .3),
                                  border: .all(color: Colors.grey.shade500, width: .5),
                                  borderRadius: .only(
                                    topLeft: const .circular(10),
                                    topRight: const .circular(10),
                                    bottomLeft: .circular((W.lg + H.x10s) / 2),
                                    bottomRight: .circular((W.lg + H.x10s) / 2),
                                  ),
                                ),
                                child: Stack(
                                  alignment: .bottomCenter,
                                  children: [
                                    _RSVPsWidget(invitationId: invitationId, viewType: viewType, isShowMore: false),
                                    GeneralEffectsButton(
                                      onTap: () {
                                        ShowModal.bottomSheet(
                                          context,
                                          barrierColor: Colors.grey.shade700.withValues(alpha: .5),
                                          header: BottomSheetHeader(
                                            title: const HeaderTitle.handleBar(),
                                            action: HeaderAction(
                                              actionIcon: Icons.close_rounded,
                                              iconColor: Colors.grey.shade400,
                                              onTap: () => NavigationService.pop(),
                                            ),
                                          ),
                                          decoration: BottomSheetDecoration(
                                            color: Colors.black.withValues(alpha: .85),
                                            borderRadius: const .only(topLeft: .circular(20), topRight: .circular(20)),
                                          ),
                                          contentBuilder: (_) {
                                            return SizedBox(
                                              height: Screen.height - H.x15l,
                                              child: Padding(
                                                padding: .only(left: W.x6s, right: W.x6s, bottom: W.x6s),
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey.shade700.withValues(alpha: .5),
                                                    borderRadius: .circular(16),
                                                  ),
                                                  child: _RSVPsWidget(
                                                    invitationId: invitationId,
                                                    viewType: viewType,
                                                    isShowMore: true,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      width: .maxFinite,
                                      height: W.lg + H.x10s,
                                      borderRadius: .circular(30),
                                      border: .all(width: .5, color: Colors.grey.shade500),
                                      color: Colors.grey.shade900.withValues(alpha: .8),
                                      child: Stack(
                                        alignment: .center,
                                        children: [
                                          Text(
                                            langCode == 'en' ? 'See More' : 'Selengkapnya',
                                            style: AppFonts.inter(
                                              color: Colors.grey.shade100,
                                              fontSize: FontSize.md,
                                              fontWeight: .w600,
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
                      SizedBox(height: W.x5s),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            height: Screen.height,
            width: Screen.width,
            child: Padding(
              padding: .only(top: H.x6l, left: W.x6s, right: W.x6s, bottom: 76),
              child: GlassEffectBox(
                width: Screen.width - 32,
                height: Screen.height - (76 + H.x6l),
                borderRadius: 20,
                sliderWidth: 90,
                color: Colors.grey.shade300.withValues(alpha: .4),
                animationSpeed: const Duration(milliseconds: 600),
                delayBeforeStart: const Duration(milliseconds: 3600),
                animationInterval: const Duration(milliseconds: 3500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RSVPForm extends StatefulWidget {
  const RSVPForm({super.key, required this.viewType, required this.invitationId});

  final ViewType viewType;
  final String invitationId;

  @override
  State<RSVPForm> createState() => _RSVPFormState();
}

class _RSVPFormState extends State<RSVPForm> {
  final _nameController = TextEditingController();
  final _greetingController = TextEditingController();

  final _avatar = ValueNotifier<String?>(null);
  final _possiblePresence = ValueNotifier<String?>(null);

  late final RSVPCubit _rsvpCubit;
  late final InvitedGuestCubit _invitedGuestCubit;

  Future<void> _submit() async {
    if (widget.viewType != ViewType.live) return;

    if (_possiblePresence.value == null) {
      GeneralDialog.showValidateStateError('Tolong isi kemungkinan kehadiran yaa', durationInSeconds: 5);
      return;
    }

    if (_greetingController.text.isEmpty) {
      GeneralDialog.showValidateStateError('Tolong kasih ucapan yaa. Dikit aja gapapa', durationInSeconds: 5);
      return;
    }

    final invitedGuest = _invitedGuestCubit.state.invitedGuest;
    if (invitedGuest == null) return;

    _rsvpCubit.state.copyWith(isLoadingCreate: true).emitState();
    await _invitedGuestCubit.updateById(
      invitedGuest.id,
      UpdateInvitedGuestRequest(
        nickname: _nameController.text,
        avatar: _avatar.value,
        possiblePresence: _possiblePresence.value!,
      ),
    );

    final success = await _rsvpCubit.create(
      RSVPRequest(invitationId: widget.invitationId, invitedGuestId: invitedGuest.id, message: _greetingController.text),
    );

    if (success) _greetingController.clear();
  }

  @override
  void initState() {
    super.initState();

    if (widget.viewType != ViewType.live) return;

    _rsvpCubit = context.read<RSVPCubit>();
    _invitedGuestCubit = context.read<InvitedGuestCubit>();

    final invitedGuest = _invitedGuestCubit.state.invitedGuest;
    if (invitedGuest != null) {
      _nameController.text = invitedGuest.nickname ?? invitedGuest.name;
      _avatar.value = invitedGuest.avatar;
      _possiblePresence.value = invitedGuest.possiblePresence;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _greetingController.dispose();

    _avatar.dispose();
    _possiblePresence.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    return Column(
      children: [
        Padding(
          padding: .symmetric(horizontal: W.x6s),
          child: FadeAndSlideTransition(
            slideFromOffset: .4,
            slideFrom: .left,
            delayBeforeStart: const Duration(milliseconds: 800),
            child: EnhancedGeneralTextField(
              textEditingController: _nameController,
              labelTextBuilder: () => langCode == 'id' ? 'Nama' : 'Name',
              maxLength: 18,
            ),
          ),
        ),
        SizedBox(height: H.x8s),
        Padding(
          padding: .symmetric(horizontal: W.x6s),
          child: FadeAndSlideTransition(
            slideFromOffset: .4,
            slideFrom: .left,
            delayBeforeStart: const Duration(milliseconds: 700),
            child: ValueListenableBuilder(
              valueListenable: _avatar,
              builder: (_, _, _) {
                return OverlayDropdownField(
                  height: H.x3l,
                  style: AppFonts.inter(color: Colors.grey.shade100, fontSize: FontSize.md),
                  decoration: FieldDecoration(
                    labelText: 'Avatar',
                    labelStyle: AppFonts.inter(color: Colors.grey.shade300, fontSize: FontSize.md),
                    filled: true,
                    fillColor: Colors.grey.shade500.withValues(alpha: .3),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade600, width: 1),
                      borderRadius: const .all(.circular(8)),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade600, width: 1),
                      borderRadius: const .all(.circular(8)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade600, width: 1),
                      borderRadius: const .all(.circular(8)),
                    ),
                    suffixIcons: () {
                      return [
                        PreSufFixIcon(
                          onTap: () {},
                          child: Image.asset(
                            'assets/avatars/${_avatar.value ?? 'avatars'}.png',
                            package: 'iv_project_invitation_theme',
                            height: 24,
                            width: 24,
                          ),
                        ),
                      ];
                    },
                  ),
                  overlayYOffset: 6,
                  overlayBarrier: const ModalBarrier(),
                  overlaydecoration: OverlayDecoration(
                    height: H.x15l,
                    color: Colors.grey.shade700.withValues(alpha: .95),
                    padding: const .symmetric(vertical: 10),
                    border: .all(color: Colors.grey.shade500),
                  ),
                  dropdownItemDecoration: DropdownItemDecoration(
                    padding: const .symmetric(vertical: 10, horizontal: 14),
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
                          style: AppFonts.inter(color: Colors.grey.shade100, fontSize: FontSize.md),
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
        SizedBox(height: H.x8s),
        Padding(
          padding: .symmetric(horizontal: W.x6s),
          child: FadeAndSlideTransition(
            slideFromOffset: .4,
            slideFrom: .left,
            delayBeforeStart: const Duration(milliseconds: 600),
            child: ValueListenableBuilder(
              valueListenable: _possiblePresence,
              builder: (_, _, _) {
                return OverlayDropdownField(
                  height: H.x3l,
                  style: AppFonts.inter(color: Colors.grey.shade100, fontSize: FontSize.md),
                  decoration: FieldDecoration(
                    labelText: langCode == 'id' ? 'Kemungkinan Kehadiran' : 'Possible Presence',
                    labelStyle: AppFonts.inter(color: Colors.grey.shade300, fontSize: FontSize.md),
                    filled: true,
                    fillColor: Colors.grey.shade500.withValues(alpha: .3),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade600, width: 1),
                      borderRadius: const .all(.circular(8)),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade600, width: 1),
                      borderRadius: const .all(.circular(8)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade600, width: 1),
                      borderRadius: const .all(.circular(8)),
                    ),
                    suffixIcons: () {
                      return [
                        PreSufFixIcon(
                          onTap: () {},
                          child: Icon(Icons.arrow_drop_down, color: Colors.grey.shade100),
                        ),
                      ];
                    },
                  ),
                  overlayYOffset: 6,
                  overlayBarrier: const ModalBarrier(),
                  overlaydecoration: OverlayDecoration(
                    color: Colors.grey.shade700.withValues(alpha: .95),
                    padding: const .symmetric(vertical: 10),
                    border: .all(color: Colors.grey.shade500),
                  ),
                  dropdownItemDecoration: DropdownItemDecoration(
                    padding: const .symmetric(vertical: 12, horizontal: 14),
                    selectedColor: Colors.grey.shade500,
                    hoveredColor: Colors.grey.shade400,
                    splashColor: Colors.grey.shade400,
                  ),
                  value: _possiblePresence.value,
                  dropdownItems: Attendance.values.map((item) => item.description).toList(),
                  dropdownItemBuilder: (value) {
                    return Text(
                      value,
                      style: AppFonts.inter(color: Colors.grey.shade100, fontSize: FontSize.md),
                    );
                  },
                  onSelected: (value) => _possiblePresence.value = value,
                );
              },
            ),
          ),
        ),
        SizedBox(height: H.x8s),
        Padding(
          padding: .symmetric(horizontal: W.x6s),
          child: FadeAndSlideTransition(
            slideFromOffset: .4,
            slideFrom: .left,
            delayBeforeStart: const Duration(milliseconds: 500),
            child: EnhancedGeneralTextField(
              textEditingController: _greetingController,
              labelTextBuilder: () => langCode == 'id' ? 'Ucapan' : 'Greetings',
              maxLines: 2,
              isMandatory: false,
            ),
          ),
        ),
        SizedBox(height: H.x8s),
        Padding(
          padding: .symmetric(horizontal: W.x6s),
          child: FadeAndSlideTransition(
            slideFromOffset: .8,
            slideFrom: .bottom,
            animationSpeed: const Duration(milliseconds: 300),
            delayBeforeStart: const Duration(milliseconds: 1200),
            child: widget.viewType != ViewType.live
                ? GeneralEffectsButton(
                    onTap: () {},
                    width: .maxFinite,
                    height: W.lg + H.x10s,
                    borderRadius: .circular(30),
                    border: .all(width: .5, color: Colors.grey.shade500),
                    color: Colors.black.withValues(alpha: .3),
                    child: Row(
                      mainAxisAlignment: .center,
                      children: [
                        Text(
                          'Submit',
                          style: AppFonts.inter(color: Colors.grey.shade100, fontSize: FontSize.md, fontWeight: .w600),
                        ),
                      ],
                    ),
                  )
                : BlocSelector<RSVPCubit, RSVPState, bool>(
                    selector: (state) => state.isLoadingCreate,
                    builder: (context, isLoadingCreate) => GeneralEffectsButton(
                      onTap: _submit,
                      width: .maxFinite,
                      height: W.lg + H.x10s,
                      borderRadius: .circular(30),
                      border: .all(width: .5, color: Colors.grey.shade500),
                      color: Colors.black.withValues(alpha: .3),
                      child: Row(
                        mainAxisAlignment: .center,
                        children: [
                          if (isLoadingCreate) ...[
                            SharedPersonalize.loadingWidget(size: 22, color: Colors.white),
                            const SizedBox(width: 10),
                          ],
                          Text(
                            'Submit',
                            style: AppFonts.inter(color: Colors.grey.shade100, fontSize: FontSize.md, fontWeight: .w600),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}

class _RSVPsWidget extends StatefulWidget {
  const _RSVPsWidget({required this.invitationId, required this.viewType, required this.isShowMore});

  final String invitationId;
  final ViewType viewType;
  final bool isShowMore;

  @override
  State<_RSVPsWidget> createState() => _RSVPsWidgetState();
}

class _RSVPsWidgetState extends State<_RSVPsWidget> {
  late final RSVPCubit _rsvpCubit;

  final List<RSVPResponse> _rsvps = [
    RSVPResponse(
      id: 1,
      invitedGuest: const InvitedGuestResponse(
        id: 'guest_1',
        phone: '085640960660',
        name: 'Ancika',
        nickname: 'Ancika',
        nameInstance: 'ancika-dilan_1995',
        invited: true,
        avatar: 'love',
        possiblePresence: 'Mungkin Tidak Hadir',
        // attendance: false,
      ),
      message: 'Happy wedding Milea dan Dilan.. Samawa yaa. So happy for u guys!!! Maafkan belum bisa hadir.',
      createdAt: DateTime.now().subtract(const Duration(minutes: 324)),
    ),
    RSVPResponse(
      id: 2,
      invitedGuest: const InvitedGuestResponse(
        id: 'guest_2',
        phone: '085640960666',
        name: 'Zee',
        nickname: 'Zee',
        nameInstance: 'ancika-dilan_1995',
        invited: true,
        avatar: 'calm',
        possiblePresence: 'Mungkin Hadir',
        // attendance: true,
      ),
      message: 'Happy wedding Milea dan Dilan. Semoga samawa selamanya.',
      createdAt: DateTime.now().subtract(const Duration(minutes: 370)),
    ),
  ];

  bool _isInitial = true;

  void _init() async {
    if (!widget.isShowMore) await Future.delayed(const Duration(milliseconds: 3000));
    _isInitial = false;

    _rsvpCubit.state.copyWith(isLoadingGetsByInvitationId: true).emitState();
    await Future.delayed(const Duration(seconds: 2));
    _rsvpCubit.state.copyWith(isLoadingGetsByInvitationId: false).emitState();
  }

  @override
  void initState() {
    super.initState();

    if (widget.viewType != ViewType.live) return;

    _rsvpCubit = context.read<RSVPCubit>();

    _init();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.viewType != ViewType.live) return _content(_rsvps);
    return BlocSelector<RSVPCubit, RSVPState, bool>(
      selector: (state) => state.isLoadingGetsByInvitationId || state.isLoadingCreate,
      builder: (context, isLoading) {
        if (_isInitial) return const SizedBox.shrink();

        final rsvps = (_rsvpCubit.state.rsvps ?? []);
        return _content(rsvps, isLoading: isLoading);
      },
    );
  }

  Widget _content(List<RSVPResponse> rsvps, {bool isLoading = false}) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    final content = ListView(
      padding: const .only(top: 14, bottom: 8),
      physics: widget.isShowMore ? null : const NeverScrollableScrollPhysics(),
      children: [
        if (isLoading) ...[
          for (int i = 0; i < 3; i++) ...[
            if (i == 2)
              const _RSVPItemSkeleton()
            else ...[
              const _RSVPItemSkeleton(),
              Padding(
                padding: const .symmetric(horizontal: 16, vertical: 8),
                child: SizedBox(
                  height: .5,
                  width: .maxFinite,
                  child: ColoredBox(color: Colors.grey.shade500),
                ),
              ),
            ],
          ],
        ] else if (rsvps.isNotEmpty) ...[
          if (rsvps.length > 3 && widget.isShowMore == false)
            for (int i = 0; i < 3; i++) ...[
              if (i == 2)
                _RSVPItem(invitationId: widget.invitationId, rsvp: rsvps[i])
              else ...[
                _RSVPItem(invitationId: widget.invitationId, rsvp: rsvps[i]),
                Padding(
                  padding: const .symmetric(horizontal: 16, vertical: 8),
                  child: SizedBox(
                    height: .5,
                    width: .maxFinite,
                    child: ColoredBox(color: Colors.grey.shade500),
                  ),
                ),
              ],
            ]
          else
            for (int i = 0; i < rsvps.length; i++) ...[
              if (i == rsvps.length - 1)
                _RSVPItem(invitationId: widget.invitationId, rsvp: rsvps[i])
              else ...[
                _RSVPItem(invitationId: widget.invitationId, rsvp: rsvps[i]),
                Padding(
                  padding: const .symmetric(horizontal: 16, vertical: 8),
                  child: SizedBox(
                    height: .5,
                    width: .maxFinite,
                    child: ColoredBox(color: Colors.grey.shade500),
                  ),
                ),
              ],
            ],
        ] else ...[
          Padding(
            padding: const .symmetric(horizontal: 16, vertical: 8),
            child: Text(
              langCode == 'id' ? 'RSVP dan Ucapan Belum ada.' : 'RSVP and Greetings Not available yet.',
              style: AppFonts.inter(color: Colors.grey.shade100, fontSize: FontSize.md, fontWeight: .w600),
            ),
          ),
        ],
      ],
    );

    if (!widget.isShowMore) return content;

    return FadeAndSlideTransition(
      slideFromOffset: 0,
      slideFrom: .bottom,
      animationSpeed: const Duration(milliseconds: 500),
      isNoNeedTrigger: true,
      child: content,
    );
  }
}

class _RSVPItem extends StatelessWidget {
  const _RSVPItem({required this.invitationId, required this.rsvp});

  final String invitationId;
  final RSVPResponse rsvp;

  @override
  Widget build(BuildContext context) {
    final invitedGuest = rsvp.invitedGuest;
    final langCode = context.read<LocaleCubit>().state.languageCode;

    return Padding(
      padding: const .symmetric(horizontal: 16, vertical: 6),
      child: Row(
        crossAxisAlignment: .start,
        children: [
          SizedBox(
            height: 32,
            width: 32,
            child: Image(
              image: AssetImage(
                'assets/avatars/${(invitedGuest.avatar ?? 'avatars')}.png',
                package: 'iv_project_invitation_theme',
              ),
              fit: .fitWidth,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Row(
                  children: [
                    Text(
                      invitedGuest.nickname ?? invitedGuest.name,
                      style: AppFonts.inter(color: Colors.grey.shade100, fontSize: FontSize.sm, fontWeight: .w700, height: 1.16),
                    ),
                    SizedBox(width: W.x10s),
                    SizedBox(
                      height: FontSize.sm,
                      width: 1,
                      child: ColoredBox(color: Colors.grey.shade50),
                    ),
                    SizedBox(width: W.x12s),
                    TimeAgo(
                      dateTime: rsvp.createdAt,
                      textStyle: AppFonts.inter(fontSize: FontSize.xs, color: Colors.grey.shade400),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  '@${invitedGuest.nameInstance}',
                  style: AppFonts.inter(color: Colors.grey.shade400, fontSize: FontSize.xs, height: 1.16),
                ),
                const SizedBox(height: 4),
                if (invitedGuest.attendance != null)
                  Text(
                    invitedGuest.attendance == true
                        ? langCode == 'id'
                              ? 'Hadir'
                              : 'Attend'
                        : langCode == 'id'
                        ? 'Tidak Hadir'
                        : 'Did not Attend',
                    style: AppFonts.inter(
                      color: invitedGuest.attendance == true
                          ? ColorConverter.lighten(Colors.green, 50)
                          : ColorConverter.lighten(Colors.red, 50),
                      fontWeight: .w400,
                      fontSize: FontSize.xs,
                    ),
                  )
                else
                  Text(
                    invitedGuest.possiblePresence ?? '-',
                    style: AppFonts.inter(
                      color: invitedGuest.possiblePresence == 'Mungkin Hadir'
                          ? ColorConverter.lighten(Colors.green, 50)
                          : ColorConverter.lighten(Colors.red, 50),
                      fontWeight: .w400,
                      fontSize: FontSize.xs,
                    ),
                  ),
                Text(
                  rsvp.message,
                  style: AppFonts.inter(color: Colors.grey.shade200, fontSize: FontSize.sm),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RSVPItemSkeleton extends StatelessWidget {
  const _RSVPItemSkeleton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(horizontal: 16, vertical: 6),
      child: Row(
        crossAxisAlignment: .start,
        children: [
          const SkeletonBox(height: 32, width: 32, borderRadius: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Row(
                  children: [
                    Text(
                      '',
                      style: AppFonts.inter(fontSize: FontSize.sm, fontWeight: .w700, height: 1.16),
                    ),
                    SkeletonBox(width: Random().nextInt(50) + 70, height: FontSize.sm),
                    SizedBox(width: W.x10s),
                    SizedBox(
                      height: FontSize.sm,
                      width: 1,
                      child: ColoredBox(color: Colors.grey.shade50),
                    ),
                    SizedBox(width: W.x10s),
                    SkeletonBox(width: 70, height: FontSize.xs),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text('', style: AppFonts.inter(fontSize: FontSize.xs, height: 1.16)),
                    SkeletonBox(width: 180, height: FontSize.x2s),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '',
                      style: AppFonts.inter(fontWeight: .w400, fontSize: FontSize.xs),
                    ),
                    SkeletonBox(width: 70, height: FontSize.xs),
                  ],
                ),
                Row(
                  children: [
                    Text('', style: AppFonts.inter(fontSize: FontSize.sm)),
                    Expanded(
                      child: SkeletonBox(width: .maxFinite, height: FontSize.sm),
                    ),
                    SizedBox(width: W.x4s),
                  ],
                ),
                Row(
                  children: [
                    Text('', style: AppFonts.inter(fontSize: FontSize.sm)),
                    Expanded(
                      child: SkeletonBox(width: .maxFinite, height: FontSize.sm),
                    ),
                    SizedBox(width: W.x6s),
                  ],
                ),
                Row(
                  children: [
                    Text('', style: AppFonts.inter(fontSize: FontSize.sm)),
                    Expanded(
                      child: SkeletonBox(width: .maxFinite, height: FontSize.sm),
                    ),
                    SizedBox(width: W.x6l),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
