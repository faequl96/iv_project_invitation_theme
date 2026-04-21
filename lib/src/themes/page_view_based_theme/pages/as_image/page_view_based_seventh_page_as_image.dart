import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/page_view_based_configs.dart';
import 'package:iv_project_invitation_theme/src/widgets/time_ago.dart';
import 'package:iv_project_invitation_theme/src/widgets/enhanced_general_text_field.dart';
import 'package:iv_project_invitation_theme/src/widgets/glass_effect_box.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class PageViewBasedSeventhPageAsImage extends StatelessWidget {
  const PageViewBasedSeventhPageAsImage({super.key, required this.config});

  final PageViewBasedSeventhPageConfig config;

  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    return Stack(
      children: [
        if (config.firstGradientBackgroundColor != null && config.secondGradientBackgroundColor != null)
          Positioned(
            top: 0,
            height: Screen.height / 1.2,
            width: Screen.width,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: .topCenter,
                  end: .bottomCenter,
                  colors: [config.firstGradientBackgroundColor!, config.secondGradientBackgroundColor!],
                  stops: const [.2, .8],
                ),
              ),
            ),
          ),

        config.background ?? const SizedBox.shrink(),

        Positioned(top: 0, child: _title(langCode)),

        if (config.useBackdropBlurOnScaffold)
          Positioned(
            bottom: 0,
            height: Screen.height,
            width: Screen.width,
            child: Padding(
              padding: .only(top: H.x6l, left: W.x6s, right: W.x6s, bottom: 76),
              child: RepaintBoundary(
                child: ClipRRect(
                  borderRadius: .circular(20),
                  child: BackdropFilter(
                    filter: .blur(sigmaX: 3, sigmaY: 3),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: .circular(20),
                        gradient: LinearGradient(
                          begin: .topCenter,
                          end: .bottomCenter,
                          colors: [config.firstGradientScaffoldColor, config.secondGradientScaffoldColor],
                          stops: config.stopsGradientScaffoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        else
          Positioned(
            bottom: 0,
            height: Screen.height,
            width: Screen.width,
            child: Padding(
              padding: .only(top: H.x6l, left: W.x6s, right: W.x6s, bottom: 76),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: .circular(20),
                  gradient: LinearGradient(
                    begin: .topCenter,
                    end: .bottomCenter,
                    colors: [config.firstGradientScaffoldColor, config.secondGradientScaffoldColor],
                    stops: config.stopsGradientScaffoldColor,
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
              decoration: BoxDecoration(borderRadius: .circular(20), border: config.scaffoldBorder),
              child: ClipRect(
                child: Column(
                  children: [
                    SizedBox(height: W.x5s),
                    RSVPForm(
                      fieldTextColor: config.fieldTextColor,
                      fieldLabelColor: config.fieldLabelColor,
                      fieldFillColor: config.fieldFillColor,
                      fieldBorderColor: config.fieldBorderColor,
                      fieldSplashColor: config.fieldSplashColor,
                      overlayColor: config.overlayColor,
                      overlayBorderColor: config.overlayBorderColor,
                      dropdownItemSelectedColor: config.dropdownItemSelectedColor,
                      dropdownItemTextColor: config.dropdownItemTextColor,
                      dropdownItemSelectedTextColor: config.dropdownItemSelectedTextColor,
                      dropdownItemHoveredColor: config.dropdownItemHoveredColor,
                      dropdownItemSplashColor: config.dropdownItemSplashColor,
                      submitButtonColor: config.submitButtonColor,
                      submitButtonLabelColor: config.submitButtonLabelColor,
                      submitButtonBorderWidth: config.submitButtonBorderWidth,
                      submitButtonBorderColor: config.submitButtonBorderColor,
                    ),
                    SizedBox(height: H.x8s),
                    Expanded(child: _rsvpList(context, langCode)),
                    SizedBox(height: W.x5s),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (config.useGlassEffectOnScaffold)
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
                color: Colors.white.withValues(alpha: config.glassEffectOpacity),
                animationSpeed: const Duration(milliseconds: 600),
                delayBeforeStart: const Duration(milliseconds: 3600),
                animationInterval: const Duration(milliseconds: 3500),
                staticValue: .67,
              ),
            ),
          ),

        config.foreground ?? const SizedBox.shrink(),
      ],
    );
  }

  Widget _title(String langCode) => SizedBox(
    height: H.x6l,
    width: Screen.width,
    child: Row(
      mainAxisAlignment: .center,
      children: [
        Icon(Icons.event_available, size: W.xs, color: config.titlePageColor),
        const SizedBox(width: 10),
        Text(
          langCode == 'en' ? 'RSVP and Greetings' : 'RSVP Dan Ucapan',
          style: AppFonts.inter(color: config.titlePageColor, fontSize: FontSize.x3l, fontWeight: .w700),
        ),
      ],
    ),
  );

  Widget _rsvpList(BuildContext context, String langCode) => SizedBox(
    width: .maxFinite,
    child: Padding(
      padding: .symmetric(horizontal: W.x6s),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: config.rsvpBackgroundColor,
          border: .all(color: config.rsvpBorderColor, width: config.rsvpBorderWidth),
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
            _RSVPsWidget(
              rsvpNameTextColor: config.rsvpNameTextColor,
              rsvpTimeAgoTextColor: config.rsvpTimeAgoTextColor,
              rsvpNameInstanceTextColor: config.rsvpNameInstanceTextColor,
              rsvpAttendanceTextColorLighten: config.rsvpAttendanceTextColorLighten,
              rsvpMessageTextColor: config.rsvpMessageTextColor,
            ),
            GeneralEffectsButton(
              onTap: () {},
              width: .maxFinite,
              height: W.lg + H.x10s,
              borderRadius: .circular(30),
              border: .all(width: config.seeMoreButtonBorderWidth, color: config.seeMoreButtonBorderColor),
              color: config.seeMoreButtonColor,
              child: Stack(
                alignment: .center,
                children: [
                  Text(
                    langCode == 'en' ? 'See More' : 'Selengkapnya',
                    style: AppFonts.inter(color: config.seeMoreButtonLabelColor, fontSize: FontSize.md, fontWeight: .w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class RSVPForm extends StatefulWidget {
  const RSVPForm({
    super.key,
    required this.fieldTextColor,
    required this.fieldLabelColor,
    required this.fieldFillColor,
    required this.fieldBorderColor,
    required this.fieldSplashColor,
    required this.overlayColor,
    required this.overlayBorderColor,
    required this.dropdownItemSelectedColor,
    required this.dropdownItemTextColor,
    required this.dropdownItemSelectedTextColor,
    required this.dropdownItemHoveredColor,
    required this.dropdownItemSplashColor,
    required this.submitButtonColor,
    required this.submitButtonLabelColor,
    required this.submitButtonBorderWidth,
    required this.submitButtonBorderColor,
  });

  final Color fieldTextColor;
  final Color fieldLabelColor;
  final Color fieldFillColor;
  final Color fieldBorderColor;
  final Color fieldSplashColor;
  final Color overlayColor;
  final Color overlayBorderColor;
  final Color dropdownItemSelectedColor;
  final Color dropdownItemTextColor;
  final Color dropdownItemSelectedTextColor;
  final Color dropdownItemHoveredColor;
  final Color dropdownItemSplashColor;
  final Color submitButtonColor;
  final Color submitButtonLabelColor;
  final double submitButtonBorderWidth;
  final Color submitButtonBorderColor;

  @override
  State<RSVPForm> createState() => _RSVPFormState();
}

class _RSVPFormState extends State<RSVPForm> {
  final _nameController = TextEditingController();
  final _greetingController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _greetingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    return Column(
      children: [
        Padding(
          padding: .symmetric(horizontal: W.x6s),
          child: _nameField(langCode),
        ),
        SizedBox(height: H.x8s),
        Padding(
          padding: .symmetric(horizontal: W.x6s),
          child: _avatarField(),
        ),
        SizedBox(height: H.x8s),
        Padding(
          padding: .symmetric(horizontal: W.x6s),
          child: _possiblePresenceField(langCode),
        ),
        SizedBox(height: H.x8s),
        Padding(
          padding: .symmetric(horizontal: W.x6s),
          child: _greetingsField(langCode),
        ),
        SizedBox(height: H.x8s),
        Padding(
          padding: .symmetric(horizontal: W.x6s),
          child: _submitButton(),
        ),
      ],
    );
  }

  Widget _nameField(String langCode) => EnhancedGeneralTextField(
    fieldTextColor: widget.fieldTextColor,
    fieldLabelColor: widget.fieldLabelColor,
    fieldFillColor: widget.fieldFillColor,
    fieldBorderColor: widget.fieldBorderColor,
    textEditingController: _nameController,
    labelTextBuilder: () => langCode == 'id' ? 'Nama' : 'Name',
    maxLength: 18,
  );

  Widget _avatarField() => OverlayDropdownField(
    height: H.x3l,
    style: AppFonts.inter(color: widget.fieldTextColor, fontSize: FontSize.md),
    decoration: FieldDecoration(
      labelText: 'Avatar',
      labelStyle: AppFonts.inter(color: widget.fieldLabelColor, fontSize: FontSize.md),
      filled: true,
      fillColor: widget.fieldFillColor,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: widget.fieldBorderColor, width: 1),
        borderRadius: const .all(.circular(8)),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: widget.fieldBorderColor, width: 1),
        borderRadius: const .all(.circular(8)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: widget.fieldBorderColor, width: 1),
        borderRadius: const .all(.circular(8)),
      ),
    ),
    splashColor: widget.fieldSplashColor,
    overlayYOffset: 6,
    overlayBarrier: const ModalBarrier(),
    overlaydecoration: OverlayDecoration(
      height: H.x15l,
      color: widget.overlayColor,
      padding: const .symmetric(vertical: 10),
      border: .all(color: widget.overlayBorderColor),
    ),
    dropdownItemDecoration: DropdownItemDecoration(
      padding: const .symmetric(vertical: 10, horizontal: 14),
      selectedColor: widget.dropdownItemSelectedColor,
      hoveredColor: widget.dropdownItemHoveredColor,
      splashColor: widget.dropdownItemSplashColor,
    ),
    value: null,
    dropdownItems: Avatars.values.map((item) => item.name).toList(),
    dropdownItemBuilder: (value) {
      return const SizedBox.shrink();
    },
    onSelected: (value) {},
  );

  Widget _possiblePresenceField(String langCode) => OverlayDropdownField(
    height: H.x3l,
    style: AppFonts.inter(color: widget.fieldTextColor, fontSize: FontSize.md),
    decoration: FieldDecoration(
      labelText: langCode == 'id' ? 'Kemungkinan Kehadiran' : 'Possible Presence',
      labelStyle: AppFonts.inter(color: widget.fieldLabelColor, fontSize: FontSize.md),
      filled: true,
      fillColor: widget.fieldFillColor,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: widget.fieldBorderColor, width: 1),
        borderRadius: const .all(.circular(8)),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: widget.fieldBorderColor, width: 1),
        borderRadius: const .all(.circular(8)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: widget.fieldBorderColor, width: 1),
        borderRadius: const .all(.circular(8)),
      ),
    ),
    splashColor: widget.fieldSplashColor,
    overlayYOffset: 6,
    overlayBarrier: const ModalBarrier(),
    overlaydecoration: OverlayDecoration(
      color: widget.overlayColor,
      padding: const .symmetric(vertical: 10),
      border: .all(color: widget.overlayBorderColor),
    ),
    dropdownItemDecoration: DropdownItemDecoration(
      padding: const .symmetric(vertical: 12, horizontal: 14),
      selectedColor: widget.dropdownItemSelectedColor,
      hoveredColor: widget.dropdownItemHoveredColor,
      splashColor: widget.dropdownItemSplashColor,
    ),
    value: null,
    dropdownItems: Attendance.values.map((item) => item.description).toList(),
    dropdownItemBuilder: (value) {
      return const SizedBox.shrink();
    },
    onSelected: (value) {},
  );

  Widget _greetingsField(String langCode) => EnhancedGeneralTextField(
    fieldTextColor: widget.fieldTextColor,
    fieldLabelColor: widget.fieldLabelColor,
    fieldFillColor: widget.fieldFillColor,
    fieldBorderColor: widget.fieldBorderColor,
    textEditingController: _greetingController,
    labelTextBuilder: () => langCode == 'id' ? 'Ucapan' : 'Greetings',
    maxLines: 2,
    isMandatory: false,
  );

  Widget _submitButton() => GeneralEffectsButton(
    onTap: () {},
    width: .maxFinite,
    height: W.lg + H.x10s,
    borderRadius: .circular(30),
    border: .all(width: widget.submitButtonBorderWidth, color: widget.submitButtonBorderColor),
    color: widget.submitButtonColor,
    child: Row(
      mainAxisAlignment: .center,
      children: [
        Text(
          'Submit',
          style: AppFonts.inter(color: widget.submitButtonLabelColor, fontSize: FontSize.md, fontWeight: .w600),
        ),
      ],
    ),
  );
}

class _RSVPsWidget extends StatefulWidget {
  const _RSVPsWidget({
    required this.rsvpNameTextColor,
    required this.rsvpTimeAgoTextColor,
    required this.rsvpNameInstanceTextColor,
    required this.rsvpAttendanceTextColorLighten,
    required this.rsvpMessageTextColor,
  });

  final Color rsvpNameTextColor;
  final Color rsvpTimeAgoTextColor;
  final Color rsvpNameInstanceTextColor;
  final int rsvpAttendanceTextColorLighten;
  final Color rsvpMessageTextColor;

  @override
  State<_RSVPsWidget> createState() => _RSVPsWidgetState();
}

class _RSVPsWidgetState extends State<_RSVPsWidget> {
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
      createdAt: .now().subtract(const Duration(minutes: 324)),
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
      createdAt: .now().subtract(const Duration(minutes: 370)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _content(_rsvps);
  }

  Widget _content(List<RSVPResponse> rsvps) {
    final content = ListView(
      padding: const .only(top: 14, bottom: 8),
      physics: const NeverScrollableScrollPhysics(),
      children: [
        for (int i = 0; i < rsvps.length; i++) ...[
          if (i == rsvps.length - 1)
            _RSVPItem(
              nameTextColor: widget.rsvpNameTextColor,
              timeAgoTextColor: widget.rsvpTimeAgoTextColor,
              nameInstanceTextColor: widget.rsvpNameInstanceTextColor,
              attendanceTextColorLighten: widget.rsvpAttendanceTextColorLighten,
              messageTextColor: widget.rsvpMessageTextColor,
              rsvp: rsvps[i],
            )
          else ...[
            _RSVPItem(
              nameTextColor: widget.rsvpNameTextColor,
              timeAgoTextColor: widget.rsvpTimeAgoTextColor,
              nameInstanceTextColor: widget.rsvpNameInstanceTextColor,
              attendanceTextColorLighten: widget.rsvpAttendanceTextColorLighten,
              messageTextColor: widget.rsvpMessageTextColor,
              rsvp: rsvps[i],
            ),
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
      ],
    );

    return content;
  }
}

class _RSVPItem extends StatelessWidget {
  const _RSVPItem({
    required this.nameTextColor,
    required this.timeAgoTextColor,
    required this.nameInstanceTextColor,
    required this.attendanceTextColorLighten,
    required this.messageTextColor,
    required this.rsvp,
  });

  final Color nameTextColor;
  final Color timeAgoTextColor;
  final Color nameInstanceTextColor;
  final int attendanceTextColorLighten;
  final Color messageTextColor;
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
                      style: AppFonts.inter(color: nameTextColor, fontSize: FontSize.sm, fontWeight: .w700, height: 1.16),
                    ),
                    SizedBox(width: W.x10s),
                    SizedBox(
                      height: FontSize.sm,
                      width: 1,
                      child: ColoredBox(color: nameTextColor),
                    ),
                    SizedBox(width: W.x12s),
                    TimeAgo(
                      dateTime: rsvp.createdAt,
                      textStyle: AppFonts.inter(fontSize: FontSize.xs, color: timeAgoTextColor),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  '@${invitedGuest.nameInstance}',
                  style: AppFonts.inter(color: nameInstanceTextColor, fontSize: FontSize.xs, height: 1.16),
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
                          ? ColorConverter.lighten(Colors.green, attendanceTextColorLighten)
                          : ColorConverter.lighten(Colors.red, attendanceTextColorLighten),
                      fontWeight: .w400,
                      fontSize: FontSize.xs,
                    ),
                  )
                else
                  Text(
                    invitedGuest.possiblePresence ?? '-',
                    style: AppFonts.inter(
                      color: invitedGuest.possiblePresence == 'Mungkin Hadir'
                          ? ColorConverter.lighten(Colors.green, attendanceTextColorLighten)
                          : ColorConverter.lighten(Colors.red, attendanceTextColorLighten),
                      fontWeight: .w400,
                      fontSize: FontSize.xs,
                    ),
                  ),
                Text(
                  rsvp.message,
                  style: AppFonts.inter(color: messageTextColor, fontSize: FontSize.sm),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
