import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/core/app_fonts.dart';
import 'package:iv_project_invitation_theme/src/core/utils/font_scale.dart';
import 'package:iv_project_invitation_theme/src/core/utils/screen_util.dart';
import 'package:iv_project_invitation_theme/src/core/utils/size_scale.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_invitation_theme/src/widgets/glass_effect_box.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class ElegantBlackAndWhiteGlassSixthPage extends StatelessWidget {
  const ElegantBlackAndWhiteGlassSixthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CoreCubit, CoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => Stack(
        children: [
          Positioned(
            bottom: 0,
            height: ScreenUtil.size.height / 1.4,
            width: ScreenUtil.size.width,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.grey.shade900],
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
                    Icon(Icons.card_giftcard_rounded, size: SizeScale.widthXs, color: Colors.grey.shade900),
                    const SizedBox(width: 10),
                    Text(
                      'Kado Pernikahan',
                      style: AppFonts.inter(color: Colors.grey.shade900, fontSize: FontScale.x3l, fontWeight: FontWeight.w700),
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
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: .1), borderRadius: BorderRadius.circular(20)),
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
                      const Spacer(),
                      FadeAndSlideTransition(
                        slideFromOffset: .4,
                        slideFrom: SlideFrom.left,
                        delayBeforeStart: const Duration(milliseconds: 500),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: SizeScale.widthX6s),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(width: .5, color: Colors.grey.shade500),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black.withValues(alpha: .6),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: SizeScale.heightSm, left: 24, right: 24, bottom: SizeScale.heightSm),
                              child: FadeAndSlideTransition(
                                slideFromOffset: .3,
                                slideFrom: SlideFrom.top,
                                delayBeforeStart: const Duration(milliseconds: 1000),
                                child: Text(
                                  'Doa restu Anda merupakan karunia yang sangat berarti bagi kami. Dan jika memberi adalah ungkapan tanda kasih Anda, Anda dapat memberi kado secara cashless.',
                                  style: AppFonts.inter(
                                    color: Colors.grey.shade100,
                                    fontSize: FontScale.md,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(height: SizeScale.heightX4s),
                          const _BankAccount(),
                          SizedBox(height: SizeScale.heightX4s),
                          const _BankAccount(),
                          SizedBox(height: SizeScale.heightX4s),
                          const _BankAccount(),
                        ],
                      ),
                      const Spacer(),
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

class _BankAccount extends StatelessWidget {
  const _BankAccount();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: SizeScale.widthX6s),
        FadeAndSlideTransition(
          slideFromOffset: .0,
          slideFrom: SlideFrom.top,
          delayBeforeStart: const Duration(milliseconds: 1500),
          child: SizedBox(
            width: SizeScale.widthX5l,
            height: SizeScale.widthX5l,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: .6),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: .5, color: Colors.grey.shade500),
              ),
            ),
          ),
        ),
        ClipRect(
          child: FadeAndSlideTransition(
            slideFromOffset: 1,
            slideFrom: SlideFrom.left,
            delayBeforeStart: const Duration(milliseconds: 1800),
            child: SizedBox(
              height: SizeScale.widthX4l - 6,
              width: ScreenUtil.size.width - (SizeScale.widthX5l + (SizeScale.widthX6s * 4)),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: .5, color: Colors.grey.shade500),
                    right: BorderSide(width: .5, color: Colors.grey.shade500),
                    bottom: BorderSide(width: .5, color: Colors.grey.shade500),
                  ),
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                  color: Colors.black.withValues(alpha: .6),
                ),
                child: Row(
                  children: [
                    SizedBox(width: SizeScale.widthX6s),
                    Text(
                      '085640933136',
                      style: AppFonts.inter(color: Colors.grey.shade100, fontSize: FontScale.md, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    GeneralEffectsButton(
                      onTap: () {},
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400.withValues(alpha: .2),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: .5, color: Colors.grey.shade400),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5, left: 4, right: 3),
                          child: Icon(Icons.content_copy_rounded, color: Colors.grey.shade200),
                        ),
                      ),
                    ),
                    SizedBox(width: SizeScale.widthX6s),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: SizeScale.widthX6s),
      ],
    );
  }
}
