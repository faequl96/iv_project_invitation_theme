import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iv_project_invitation_theme/src/core/cubit/core_cubit.dart';
import 'package:iv_project_invitation_theme/src/core/utils/font_scale.dart';
import 'package:iv_project_invitation_theme/src/core/utils/screen_util.dart';
import 'package:iv_project_invitation_theme/src/core/utils/size_scale.dart';
import 'package:iv_project_invitation_theme/src/opener/blurry_clear_cover.dart';
import 'package:iv_project_invitation_theme/src/opener/padlock.dart';
import 'package:iv_project_invitation_theme/src/widgets/lightning_effect_box.dart';

class InitializerWrapper extends StatefulWidget {
  const InitializerWrapper({super.key});

  @override
  State<InitializerWrapper> createState() => _InitializerWrapperState();
}

class _InitializerWrapperState extends State<InitializerWrapper> {
  bool _onOpenedStarted = false;
  bool _isOpenedProcessCompleted = false;

  @override
  Widget build(BuildContext context) {
    if (_isOpenedProcessCompleted) return const SizedBox.shrink();

    final tryThemeCubit = context.read<CoreCubit>();

    return BlocSelector<CoreCubit, CoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => SizedBox(
        height: ScreenUtil.size.height,
        width: ScreenUtil.size.width,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
              left: _onOpenedStarted ? -(ScreenUtil.size.width / 2) : -1.5,
              child: const BlurryClearCover(isLeft: true),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
              right: _onOpenedStarted ? -(ScreenUtil.size.width / 2) : -1.5,
              child: const BlurryClearCover(isLeft: false),
            ),
            if (!_onOpenedStarted) ...[
              Align(
                alignment: const Alignment(0, -.8),
                child: Stack(
                  children: [
                    SizedBox(
                      width: (ScreenUtil.size.width) - SizeScale.widthX9l,
                      height: SizeScale.widthX4l,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          border: Border.all(width: .5, color: Colors.grey.shade500),
                          color: Colors.grey.shade300.withValues(alpha: .2),
                        ),
                        child: Center(
                          child: Text(
                            'Undangan Pernikahan',
                            style: GoogleFonts.pacifico(
                              fontSize: FontScale.x4l,
                              fontWeight: FontWeight.w900,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ),
                      ),
                    ),
                    LightningEffectBox(
                      width: (ScreenUtil.size.width) - SizeScale.widthX9l,
                      height: SizeScale.widthX4l,
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
                  height: SizeScale.heightX11l,
                  width: SizeScale.heightX11l,
                  child: Center(
                    child: Text(
                      'M',
                      style: GoogleFonts.parisienne(
                        fontSize: FontScale.x2l + SizeScale.heightX2l,
                        fontWeight: FontWeight.w900,
                        color: Colors.grey.shade100.withValues(alpha: .75),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(.18, -.1),
                child: SizedBox(
                  height: SizeScale.heightX11l,
                  width: SizeScale.heightX11l,
                  child: Center(
                    child: Text(
                      'D',
                      style: GoogleFonts.parisienne(
                        fontSize: FontScale.x2l + SizeScale.heightX2l,
                        fontWeight: FontWeight.w900,
                        color: Colors.grey.shade100.withValues(alpha: .75),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0, .3),
                child: Text(
                  'Minggu, 17 Agustus 2025',
                  style: TextStyle(fontSize: FontScale.md, color: Colors.grey.shade300),
                ),
              ),
              Align(
                alignment: const Alignment(0, .6),
                child: SizedBox(
                  height: SizeScale.heightX10l,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Kepada :',
                        style: TextStyle(fontSize: FontScale.xs, fontWeight: FontWeight.w900, color: Colors.grey.shade300),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Rizal (Voltras)',
                        style: TextStyle(fontSize: FontScale.md, fontWeight: FontWeight.w900, color: Colors.grey.shade300),
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

                  tryThemeCubit.state.copyWith(animationTrigger: 1).emitState();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
