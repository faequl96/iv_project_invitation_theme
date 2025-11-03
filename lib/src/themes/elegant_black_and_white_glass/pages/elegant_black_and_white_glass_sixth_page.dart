import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/core/app_fonts.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_invitation_theme/src/widgets/glass_effect_box.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class ElegantBlackAndWhiteGlassSixthPage extends StatelessWidget {
  const ElegantBlackAndWhiteGlassSixthPage({super.key, this.bankAccounts = const []});

  final List<BankAccountResponse> bankAccounts;

  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    return BlocSelector<InvitationThemeCoreCubit, InvitationThemeCoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => Stack(
        children: [
          Positioned(
            bottom: 0,
            height: ScreenUtil.size.height / 1.2,
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
                      langCode == 'en' ? 'Wedding Gift' : 'Kado Pernikahan',
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
                    decoration: BoxDecoration(
                      // color: Colors.white.withValues(alpha: .1),
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
                              color: Colors.white.withValues(alpha: .05),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: SizeScale.heightSm, left: 24, right: 24, bottom: SizeScale.heightSm),
                              child: FadeAndSlideTransition(
                                slideFromOffset: .3,
                                slideFrom: SlideFrom.top,
                                delayBeforeStart: const Duration(milliseconds: 1000),
                                child: Text(
                                  langCode == 'en'
                                      ? 'Your prayers and blessings are a truly meaningful gift to us. And if giving is an expression of your love, you can give a cashless gift.'
                                      : 'Doa restu Anda merupakan karunia yang sangat berarti bagi kami. Dan jika memberi adalah ungkapan tanda kasih Anda, Anda dapat memberi kado secara cashless.',
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
                          for (final bankAccount in bankAccounts) ...[
                            SizedBox(height: SizeScale.heightX4s),
                            _BankAccount(bankAccount: bankAccount),
                          ],
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
  const _BankAccount({required this.bankAccount});

  final BankAccountResponse bankAccount;

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
            width: SizeScale.widthX7l,
            height: SizeScale.widthX7l,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: .05),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: .5, color: Colors.grey.shade500),
              ),
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: .4), borderRadius: BorderRadius.circular(6)),
                  child: Image.asset(
                    'assets/banks/${bankAccount.bankName}.png',
                    package: 'iv_project_invitation_theme',
                    fit: BoxFit.fitWidth,
                    errorBuilder: (_, _, _) {
                      final bankNames = bankAccount.bankName.split(' ');
                      final bankName = bankNames.length > 1
                          ? bankNames.map((e) => e[0]).join().replaceAll(RegExp(r'[^a-zA-Z]'), '')
                          : bankNames[0];
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: SizeScale.widthX4s),
                        child: ColoredBox(
                          color: Colors.white,
                          child: Center(
                            child: Text(
                              bankName,
                              style: TextStyle(fontSize: FontScale.xl, color: Colors.grey.shade800, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
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
              height: SizeScale.widthX5l,
              width: ScreenUtil.size.width - (SizeScale.widthX7l + 2 + (SizeScale.widthX6s * 4) + 4),
              child: Padding(
                padding: const EdgeInsets.only(left: 2),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(width: .5, color: Colors.grey.shade500),
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                    color: Colors.white.withValues(alpha: .05),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: SizeScale.widthX9s),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bankAccount.bankName,
                            style: AppFonts.inter(
                              color: Colors.grey.shade100,
                              fontSize: FontScale.xs,
                              fontWeight: FontWeight.w500,
                              // height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            bankAccount.number,
                            style: AppFonts.inter(
                              color: Colors.grey.shade100,
                              fontSize: FontScale.md,
                              fontWeight: FontWeight.w500,
                              height: 1.3,
                            ),
                          ),
                          Text(
                            'a.n ${bankAccount.accountName}',
                            style: AppFonts.inter(
                              color: Colors.grey.shade100,
                              fontSize: FontScale.x2s,
                              fontWeight: FontWeight.w400,
                              height: 1.3,
                            ),
                          ),
                        ],
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
                      SizedBox(width: SizeScale.widthX7s),
                    ],
                  ),
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
