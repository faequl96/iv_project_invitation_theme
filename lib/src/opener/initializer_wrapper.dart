import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/src/core/cubit/invitation_theme_core_cubit.dart';
import 'package:iv_project_invitation_theme/src/core/widgets/check_in_qr.dart';
import 'package:iv_project_invitation_theme/src/opener/blurry_clear_cover.dart';
import 'package:iv_project_invitation_theme/src/opener/padlock.dart';
import 'package:iv_project_invitation_theme/src/widgets/lightning_effect_box.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:iv_project_web_data/iv_project_web_data.dart';

class InitializerWrapper extends StatefulWidget {
  const InitializerWrapper({super.key, required this.bride, required this.groom, required this.time});

  final BridegroomResponse bride;
  final BridegroomResponse groom;
  final EventResponse time;

  @override
  State<InitializerWrapper> createState() => _InitializerWrapperState();
}

class _InitializerWrapperState extends State<InitializerWrapper> {
  bool _onOpenedStarted = false;
  bool _isOpenedProcessCompleted = false;

  late final InvitationThemeCoreCubit _invitationThemeCoreCubit;
  late final InvitedGuestCubit _invitedGuestCubit;

  @override
  void initState() {
    super.initState();

    _invitationThemeCoreCubit = context.read<InvitationThemeCoreCubit>();
    _invitedGuestCubit = context.read<InvitedGuestCubit>();
  }

  @override
  Widget build(BuildContext context) {
    if (_isOpenedProcessCompleted) return const SizedBox.shrink();

    final langCode = context.read<LocaleCubit>().state.languageCode;

    final invitedGuest = _invitedGuestCubit.state.invitedGuest;

    return BlocSelector<InvitationThemeCoreCubit, InvitationThemeCoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => SizedBox(
        height: Screen.height,
        width: Screen.width,
        child: Stack(
          alignment: .center,
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
              left: _onOpenedStarted ? -(Screen.width / 2) : -1.5,
              child: const BlurryClearCover(isLeft: true),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
              right: _onOpenedStarted ? -(Screen.width / 2) : -1.5,
              child: const BlurryClearCover(isLeft: false),
            ),
            if (!_onOpenedStarted) ...[
              Align(
                alignment: const Alignment(0, -.8),
                child: Stack(
                  children: [
                    SizedBox(
                      width: (Screen.width) - W.x9l,
                      height: W.x4l,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: .circular(60),
                          border: .all(width: .5, color: Colors.grey.shade500),
                          color: Colors.grey.shade300.withValues(alpha: .2),
                        ),
                        child: Center(
                          child: Text(
                            langCode == 'en' ? 'Wedding Invitation' : 'Undangan Pernikahan',
                            style: AppFonts.pacifico(fontSize: FontSize.x4l, fontWeight: .w700, color: Colors.grey.shade900),
                          ),
                        ),
                      ),
                    ),
                    LightningEffectBox(
                      width: (Screen.width) - W.x9l,
                      height: W.x4l,
                      borderRadius: 60,
                      animationSpeed: const Duration(seconds: 2),
                      ligthningColor: Colors.black,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: const Alignment(-.18, -.3),
                child: SizedBox(
                  height: H.x11l,
                  width: H.x11l,
                  child: Center(
                    child: Text(
                      widget.bride.nickname.isNotEmpty ? widget.bride.nickname[0] : '',
                      style: AppFonts.pacifico(fontSize: FontSize.xl + H.xl, fontWeight: .w500, color: Colors.grey.shade300),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(.18, -.1),
                child: SizedBox(
                  height: H.x11l,
                  width: H.x11l,
                  child: Center(
                    child: Text(
                      widget.groom.nickname.isNotEmpty ? widget.groom.nickname[0] : '',
                      style: AppFonts.pacifico(fontSize: FontSize.xl + H.xl, fontWeight: .w500, color: Colors.grey.shade300),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0, .3),
                child: Text(
                  DateUtil.format(widget.time.startTime, .EEEEddMMMMyyyy),
                  style: AppFonts.inter(fontSize: FontSize.md, color: Colors.grey.shade300, fontWeight: .w300),
                ),
              ),
              Align(
                alignment: const Alignment(0, .6),
                child: SizedBox(
                  height: H.x10l,
                  child: Column(
                    mainAxisAlignment: .center,
                    children: [
                      Text(
                        langCode == 'en' ? 'To :' : 'Kepada :',
                        style: AppFonts.inter(fontSize: FontSize.sm, fontWeight: .w300, color: Colors.grey.shade300),
                      ),
                      const SizedBox(height: 6),
                      if (invitedGuest != null)
                        Text(
                          '${invitedGuest.nickname} - ${invitedGuest.nameInstance.split('_').last.replaceAll('-', ' ')}',
                          style: AppFonts.inter(fontSize: FontSize.md, fontWeight: .w500, color: Colors.grey.shade300),
                        )
                      else
                        Text(
                          '-',
                          style: AppFonts.inter(fontSize: FontSize.md, fontWeight: .w500, color: Colors.grey.shade300),
                        ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
              ),
            ],
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              bottom: _onOpenedStarted ? -50 : 40,
              child: Padlock(
                onOpened: () async {
                  setState(() => _onOpenedStarted = true);

                  await Future.delayed(const Duration(milliseconds: 500));
                  setState(() => _isOpenedProcessCompleted = true);

                  _invitationThemeCoreCubit.state.copyWith(animationTrigger: 1).emitState();

                  await Future.delayed(const Duration(milliseconds: 500));
                  if (invitedGuest != null && context.mounted) CheckInQr.show(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
