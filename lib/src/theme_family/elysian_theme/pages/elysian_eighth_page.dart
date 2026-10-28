import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/elysian_configs.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/widgets/elysian_glass_card.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/widgets/elysian_reveal.dart';
import 'package:iv_project_invitation_theme/src/widgets/general_text_field.dart';
import 'package:iv_project_invitation_theme/src/widgets/time_ago.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:iv_project_web_data/iv_project_web_data.dart';
import 'package:iv_project_widget_core/iv_project_widget_core.dart';

class const ElysianEighthPage({
  super.key,
  required final ElysianEighthPageConfig config,
  required final ViewType viewType,
  required final String invitationId,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    return BlocSelector<InvitationThemeCoreCubit, InvitationThemeCoreState, Size>(
      selector: (state) => state.size,
      builder: (_, size) => Container(
        height: size.height,
        width: size.width,
        color: config.backgroundColor,
        padding: const .symmetric(horizontal: 20, vertical: 24),
        child: Column(
          children: [
            ElysianReveal(
              delay: const Duration(milliseconds: 100),
              child: Text(
                langCode == 'en' ? 'GREETINGS & RSVP' : 'UCAPAN & RSVP',
                style: TextStyle(
                  color: config.titleColor,
                  fontSize: 12,
                  letterSpacing: 4,
                  fontWeight: .w600,
                ),
              ),
            ),
            const SizedBox(height: 12),
            ElysianReveal(
              delay: const Duration(milliseconds: 200),
              child: _ElysianRSVPForm(
                config: config,
                viewType: viewType,
                invitationId: invitationId,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ElysianReveal(
                delay: const Duration(milliseconds: 350),
                child: ElysianGlassCard(
                  backgroundColor: config.cardColor,
                  borderColor: config.cardBorderColor,
                  padding: const .all(14),
                  child: _ElysianRSVPList(
                    config: config,
                    viewType: viewType,
                    invitationId: invitationId,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class const _ElysianRSVPForm({
  required final ElysianEighthPageConfig config,
  required final ViewType viewType,
  required final String invitationId,
}) extends StatefulWidget {
  @override
  State<_ElysianRSVPForm> createState() => _ElysianRSVPFormState();
}

class _ElysianRSVPFormState() extends State<_ElysianRSVPForm> {
  final _nameController = TextEditingController();
  final _greetingController = TextEditingController();
  final _possiblePresence = ValueNotifier<String?>(null);

  late final RSVPCubit _rsvpCubit;
  late final InvitedGuestCubit _invitedGuestCubit;

  @override
  void initState() {
    super.initState();
    if (widget.viewType != .live) return;
    _rsvpCubit = context.read<RSVPCubit>();
    _invitedGuestCubit = context.read<InvitedGuestCubit>();
    final guest = _invitedGuestCubit.state.invitedGuest;
    if (guest != null) {
      _nameController.text = guest.nickname ?? '';
      _possiblePresence.value = guest.possiblePresence;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _greetingController.dispose();
    _possiblePresence.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (widget.viewType != .live) return;

    if (_possiblePresence.value == null) {
      GeneralDialog.showValidateStateError('Mohon konfirmasi kehadiran Anda', durationInSeconds: 4);
      return;
    }
    if (_greetingController.text.trim().isEmpty) {
      GeneralDialog.showValidateStateError('Mohon berikan doa & ucapan selamat', durationInSeconds: 4);
      return;
    }

    final invitedGuest = _invitedGuestCubit.state.invitedGuest;
    if (invitedGuest == null) return;

    _rsvpCubit.state.copyWith(isLoadingCreate: true).emitState();
    await _invitedGuestCubit.updateById(
      invitedGuest.id,
      UpdateInvitedGuestRequest(
        nickname: _nameController.text,
        avatar: null,
        possiblePresence: _possiblePresence.value!,
      ),
    );

    final success = await _rsvpCubit.create(
      RSVPRequest(
        invitationId: widget.invitationId,
        invitedGuestId: invitedGuest.id,
        message: _greetingController.text,
      ),
    );

    if (success) _greetingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    return ElysianGlassCard(
      backgroundColor: widget.config.cardColor,
      borderColor: widget.config.cardBorderColor,
      padding: const .all(16),
      child: Column(
        children: [
          GeneralTextField(
            textEditingController: _nameController,
            labelTextBuilder: () => langCode == 'en' ? 'Your Name' : 'Nama Anda',
            fieldTextColor: widget.config.inputTextColor,
            fieldLabelColor: widget.config.subtitleColor,
            fieldFillColor: widget.config.inputFillColor,
            fieldBorderColor: widget.config.inputBorderColor,
          ),
          const SizedBox(height: 10),
          ValueListenableBuilder<String?>(
            valueListenable: _possiblePresence,
            builder: (_, presence, _) => Row(
              children: [
                _buildPresenceOption(
                  title: langCode == 'en' ? 'Will Attend' : 'Hadir',
                  value: 'Hadir',
                  selected: presence == 'Hadir',
                ),
                const SizedBox(width: 8),
                _buildPresenceOption(
                  title: langCode == 'en' ? 'Cannot Attend' : 'Tidak Hadir',
                  value: 'Tidak Hadir',
                  selected: presence == 'Tidak Hadir',
                ),
                const SizedBox(width: 8),
                _buildPresenceOption(
                  title: langCode == 'en' ? 'Uncertain' : 'Ragu-ragu',
                  value: 'Ragu-ragu',
                  selected: presence == 'Ragu-ragu',
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          GeneralTextField(
            textEditingController: _greetingController,
            labelTextBuilder: () => langCode == 'en' ? 'Write your warm wishes...' : 'Tuliskan ucapan & doa restu...',
            fieldTextColor: widget.config.inputTextColor,
            fieldLabelColor: widget.config.subtitleColor,
            fieldFillColor: widget.config.inputFillColor,
            fieldBorderColor: widget.config.inputBorderColor,
            maxLines: 2,
            isMandatory: false,
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: _submit,
            child: Container(
              width: .infinity,
              padding: const .symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: widget.config.buttonColor,
                borderRadius: .circular(20),
                boxShadow: [
                  BoxShadow(
                    color: widget.config.buttonColor.withValues(alpha: .35),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  langCode == 'en' ? 'SEND WISHES' : 'KIRIM UCAPAN',
                  style: TextStyle(
                    color: widget.config.buttonTextColor,
                    fontSize: 12,
                    fontWeight: .bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPresenceOption({
    required String title,
    required String value,
    required bool selected,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _possiblePresence.value = value,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const .symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: selected ? widget.config.buttonColor : widget.config.inputFillColor,
            borderRadius: .circular(16),
            border: Border.all(
              color: selected ? widget.config.buttonColor : widget.config.inputBorderColor,
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: selected ? widget.config.buttonTextColor : widget.config.inputTextColor,
                fontSize: 11,
                fontWeight: selected ? .bold : .normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class const _ElysianRSVPList({
  required final ElysianEighthPageConfig config,
  required final ViewType viewType,
  required final String invitationId,
}) extends StatefulWidget {
  @override
  State<_ElysianRSVPList> createState() => _ElysianRSVPListState();
}

class _ElysianRSVPListState() extends State<_ElysianRSVPList> {
  static final List<RSVPResponse> _dummyRsvps = [
    RSVPResponse(
      id: 1,
      message: 'Selamat menempuh hidup baru! Semoga menjadi keluarga yang sakinah, mawaddah, warahmah.',
      createdAt: .now().subtract(const Duration(hours: 2)),
      invitedGuest: const InvitedGuestResponse(
        id: '1',
        nickname: 'Dimas & Anisa',
        name: 'Dimas & Anisa',
        nameInstance: 'Keluarga Besar',
        invited: true,
        possiblePresence: 'Hadir',
      ),
    ),
    RSVPResponse(
      id: 2,
      message: 'Barakallah lakuma! Bahagia selalu sampai akhir hayat yaa.',
      createdAt: .now().subtract(const Duration(hours: 5)),
      invitedGuest: const InvitedGuestResponse(
        id: '2',
        nickname: 'Sarah Wijaya',
        name: 'Sarah Wijaya',
        nameInstance: 'Sahabat SMA',
        invited: true,
        possiblePresence: 'Hadir',
      ),
    ),
  ];

  late final RSVPCubit _rsvpCubit;

  @override
  void initState() {
    super.initState();
    if (widget.viewType == .live) {
      _rsvpCubit = context.read<RSVPCubit>();
      _rsvpCubit.state.copyWith(isLoadingGetsByInvitationId: true).emitState();
      Future<void>.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          _rsvpCubit.state.copyWith(isLoadingGetsByInvitationId: false).emitState();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.viewType != .live) return _buildList(_dummyRsvps);

    return BlocSelector<RSVPCubit, RSVPState, List<RSVPResponse>>(
      selector: (state) => state.rsvps ?? [],
      builder: (_, rsvps) => _buildList(rsvps.isEmpty ? _dummyRsvps : rsvps),
    );
  }

  Widget _buildList(List<RSVPResponse> rsvps) {
    return ListView.separated(
      padding: .zero,
      itemCount: rsvps.length,
      separatorBuilder: (_, _) => Divider(
        color: widget.config.cardBorderColor.withValues(alpha: .3),
        height: 16,
      ),
      itemBuilder: (_, index) {
        final item = rsvps[index];
        return Column(
          crossAxisAlignment: .start,
          children: [
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  item.invitedGuest.nickname ?? item.invitedGuest.name,
                  style: TextStyle(
                    color: widget.config.wishNameColor,
                    fontSize: 13,
                    fontWeight: .bold,
                  ),
                ),
                TimeAgo(
                  dateTime: item.createdAt,
                  textStyle: TextStyle(
                    color: widget.config.wishDateColor,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              item.message,
              style: TextStyle(
                color: widget.config.wishMessageColor,
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ],
        );
      },
    );
  }
}
