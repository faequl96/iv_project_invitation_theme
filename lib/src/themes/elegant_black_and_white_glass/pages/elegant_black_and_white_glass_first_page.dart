import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/core/utils/font_scale.dart';
import 'package:iv_project_invitation_theme/src/core/utils/screen_util.dart';
import 'package:iv_project_invitation_theme/src/core/utils/size_scale.dart';
import 'package:iv_project_invitation_theme/src/widgets/glass_effect_box.dart';

class ElegantBlackAndWhiteGlassFirstPage extends StatelessWidget {
  const ElegantBlackAndWhiteGlassFirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CoreCubit, CoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => Stack(
        children: [
          Positioned(
            top: 0,
            child: SizedBox(
              height: ScreenUtil.size.height / 1.2,
              width: ScreenUtil.size.width,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.grey.shade900, Colors.transparent],
                    stops: const [.1, .8],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: ScreenUtil.size.height,
              width: ScreenUtil.size.width,
              child: Padding(
                padding: EdgeInsets.only(top: SizeScale.heightX7l, left: 14, right: 14, bottom: 76),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .08),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: ScreenUtil.size.height,
              width: ScreenUtil.size.width,
              child: Padding(
                padding: EdgeInsets.only(top: SizeScale.heightX7l, left: 14, right: 14, bottom: 76),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: .5, color: Colors.grey.shade500),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: ScreenUtil.size.height,
              width: ScreenUtil.size.width,
              child: Padding(
                padding: EdgeInsets.only(top: SizeScale.heightX7l, left: 14, right: 14, bottom: 76),
                child: GlassEffectBox(
                  width: ScreenUtil.size.width - 28,
                  height: ScreenUtil.size.height - (76 + SizeScale.heightX7l),
                  borderRadius: 20,
                  sliderWidth: 160,
                  color: Colors.grey.shade50.withValues(alpha: .2),
                  animationEnd: 1.3,
                  animationSpeed: const Duration(milliseconds: 600),
                  animationInterval: const Duration(seconds: 2),
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, -.94),
            child: Text(
              'Maksud dan Tujuan',
              style: TextStyle(color: Colors.grey.shade200, fontSize: FontScale.x2l),
            ),
          ),
          Align(
            alignment: const Alignment(0, -.6),
            child: Text(
              'بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ',
              style: GoogleFonts.arefRuqaa(color: Colors.grey.shade100, fontSize: FontScale.x7l),
            ),
          ),
          Align(
            alignment: const Alignment(0, -.25),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '"Dan di antara tanda-tanda (kebesaran)-Nya adalah Dia menciptakan pasangan-pasangan untukmu dari jenismu sendiri, agar kamu cenderung dan merasa tenteram kepadanya".',
                    style: TextStyle(color: Colors.grey.shade100, fontSize: FontScale.md),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '(Ar-Ruum Ayat 21)',
                    style: TextStyle(color: Colors.grey.shade100, fontSize: FontScale.lg, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, .4),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Assalamu\'alaikum Wr. Wb.',
                    style: TextStyle(color: Colors.grey.shade100, fontSize: FontScale.x2l, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: SizeScale.heightX3s),
                  Text(
                    'Dengan memohon rahmat dan ridho Allah Subhanahu Wa Ta\'ala. Kami mengundang Bapak/Ibu/Saudara/I, untuk menghadiri resepsi pernikahan kami.',
                    style: TextStyle(color: Colors.grey.shade100, fontSize: FontScale.md),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
