import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/core/utils/font_scale.dart';
import 'package:iv_project_invitation_theme/src/core/utils/screen_util.dart';
import 'package:iv_project_invitation_theme/src/core/utils/shape_scale.dart';
import 'package:iv_project_invitation_theme/src/opener/blurry_clear_cover.dart';
import 'package:iv_project_invitation_theme/src/opener/padlock.dart';

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
    return BlocSelector<TryThemeCubit, TryThemeState, Size>(
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
              left: _onOpenedStarted ? -(ScreenUtil.size.width / 2) : -1,
              child: const BlurryClearCover(isLeft: true),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
              right: _onOpenedStarted ? -(ScreenUtil.size.width / 2) : -1,
              child: const BlurryClearCover(isLeft: false),
            ),
            if (!_onOpenedStarted) ...[
              Align(
                alignment: const Alignment(0, -.85),
                child: Text(
                  'Undangan Pernikahan',
                  style: GoogleFonts.pacifico(
                    fontSize: FontScale.x6l,
                    fontWeight: FontWeight.w900,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1
                      ..color = Colors.grey.shade300,
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0, -.85),
                child: Text(
                  'Undangan Pernikahan',
                  style: GoogleFonts.pacifico(fontSize: FontScale.x6l, fontWeight: FontWeight.w900, color: Colors.grey.shade800),
                ),
              ),
            ],
            if (!_onOpenedStarted)
              Align(
                alignment: const Alignment(0, -.2),
                child: SizedBox(
                  height: ShapeScale.heightX14l,
                  child: Center(
                    child: Text(
                      '&',
                      style: GoogleFonts.pacifico(
                        fontSize: FontScale.x5s + ShapeScale.heightX4s,
                        fontWeight: FontWeight.w900,
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                ),
              ),
            if (!_onOpenedStarted) ...[
              Align(
                alignment: const Alignment(0, .3),
                child: Text(
                  'Minggu, 17 Agustus 2025',
                  style: TextStyle(
                    fontSize: FontScale.md,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1
                      ..color = Colors.grey.shade700,
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
            ],
            if (!_onOpenedStarted)
              Align(
                alignment: const Alignment(0, .6),
                child: SizedBox(
                  height: ShapeScale.heightX10l,
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
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              bottom: _onOpenedStarted ? -50 : 40,
              child: Padlock(
                onOpened: () async {
                  setState(() => _onOpenedStarted = true);

                  await Future.delayed(const Duration(milliseconds: 500));
                  setState(() => _isOpenedProcessCompleted = true);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
