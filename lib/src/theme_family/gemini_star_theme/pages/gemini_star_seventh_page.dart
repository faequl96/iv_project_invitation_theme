import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/gemini_star_theme/gemini_star_configs.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class GeminiStarSeventhPage extends StatelessWidget {
  const GeminiStarSeventhPage({super.key, required this.config, this.bankAccounts = const []});

  final GeminiStarSeventhPageConfig config;
  final List<BankAccountResponse> bankAccounts;

  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    return BlocSelector<InvitationThemeCoreCubit, InvitationThemeCoreState, Size>(
      selector: (state) => state.size,
      builder: (_, _) => Stack(
        alignment: .center,
        children: [
          if (config.firstGradientBackgroundColor != null &&
              config.secondGradientBackgroundColor != null)
            Positioned(
              bottom: 0,
              height: Screen.height,
              width: Screen.width,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: .topCenter,
                    end: .bottomCenter,
                    colors: [
                      config.firstGradientBackgroundColor!,
                      config.secondGradientBackgroundColor!,
                    ],
                    stops: const [.2, .8],
                  ),
                ),
              ),
            ),

          Positioned(
            left: (-Screen.height / 2) + W.sm / 2,
            child: Transform.rotate(angle: -(pi / 2), child: _buildTitle(langCode)),
          ),

          Positioned(
            right: (-Screen.height / 2) + W.sm / 2,
            child: Transform.rotate(angle: (pi / 2), child: _buildTitle(langCode, isRight: true)),
          ),

          Positioned(
            bottom: 0,
            height: Screen.height,
            width: Screen.width,
            child: Padding(
              padding: .symmetric(horizontal: W.sm),
              child: Column(
                children: [
                  SizedBox(
                    height: (Screen.height / 2) - H.x6l,
                    child: Column(
                      mainAxisAlignment: .end,
                      children: [
                        FadeAndSlideTransition(
                          slideFromOffset: .4,
                          slideFrom: .top,
                          delayBeforeStart: const Duration(milliseconds: 500),
                          child: Padding(
                            padding: .symmetric(horizontal: W.x6s),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                border: .all(
                                  width: config.introductionBorderWidth,
                                  color: config.introductionBorderColor,
                                ),
                                borderRadius: .circular(10),
                                color: config.introductionColor,
                              ),
                              child: Padding(
                                padding: .only(top: H.sm, left: 24, right: 24, bottom: H.sm),
                                child: _buildIntroduction(langCode),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: H.xs),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(height: H.x10s),
                        for (final bankAccount in bankAccounts) ...[
                          SizedBox(height: H.x4s),
                          _BankAccount(
                            color: config.bankColor,
                            borderWidth: config.bankBorderWidth,
                            borderColor: config.bankBorderColor,
                            textColor: config.bankTextColor,
                            copyBaseColor: config.bankCopyBaseColor,
                            bankAccount: bankAccount,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (config.decorationBuilder != null)
            SizedBox(
              height: Screen.height,
              width: Screen.width,
              child: config.decorationBuilder!(),
            ),
        ],
      ),
    );
  }

  Widget _buildTitle(String langCode, {bool isRight = false}) => SizedBox(
    height: W.sm,
    width: Screen.height,
    child: ColoredBox(
      color: Colors.black54,
      child: Row(
        children: [
          if (!isRight) ...[
            const Spacer(),
            SizedBox(
              width: (Screen.height / 2) - H.x6l,
              child: Row(
                children: [
                  SizedBox(width: H.x2s),
                  Column(
                    mainAxisAlignment: .center,
                    children: [
                      FadeAndSlideTransition(
                        slideFromOffset: 1.5,
                        slideFrom: .right,
                        child: Text(
                          langCode == 'en' ? 'Wedding Gift' : 'Kado Pernikahan',
                          style: AppFonts.inter(
                            color: config.titlePageColor,
                            fontSize: FontSize.x3l,
                            fontWeight: .w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ] else ...[
            SizedBox(width: (Screen.height / 2) - H.x6l),
            Expanded(
              child: Row(
                children: [
                  SizedBox(width: H.x2s),
                  FadeAndSlideTransition(
                    slideFromOffset: 1.5,
                    slideFrom: .right,
                    child: Text(
                      langCode == 'en' ? 'Wedding Gift' : 'Kado Pernikahan',
                      style: AppFonts.inter(
                        color: config.titlePageColor,
                        fontSize: FontSize.x3l,
                        fontWeight: .w700,
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ],
      ),
    ),
  );

  Widget _buildIntroduction(String langCode) => Text(
    langCode == 'en'
        ? 'Your prayers and blessings are a truly meaningful gift to us. And if giving is an expression of your love, you can give a cashless gift.'
        : 'Doa restu Anda merupakan karunia yang sangat berarti bagi kami. Dan jika memberi adalah ungkapan tanda kasih Anda, Anda dapat memberi kado secara cashless.',
    style: AppFonts.inter(
      color: config.introductionTextColor,
      fontSize: FontSize.md,
      fontWeight: .w400,
    ),
    textAlign: .center,
  );
}

class _BankAccount extends StatelessWidget {
  const _BankAccount({
    required this.color,
    required this.borderColor,
    required this.borderWidth,
    required this.textColor,
    required this.copyBaseColor,
    required this.bankAccount,
  });

  final Color color;
  final Color borderColor;
  final double borderWidth;
  final Color textColor;
  final Color copyBaseColor;
  final BankAccountResponse bankAccount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: W.x6s),
        FadeAndSlideTransition(
          slideFromOffset: .0,
          slideFrom: .top,
          delayBeforeStart: const Duration(milliseconds: 500),
          child: _bankLogo(),
        ),
        ClipRect(
          child: FadeAndSlideTransition(
            slideFromOffset: 1,
            slideFrom: .left,
            delayBeforeStart: const Duration(milliseconds: 800),
            child: _bankInfo(),
          ),
        ),
        SizedBox(width: W.x6s),
      ],
    );
  }

  Widget _bankLogo() => SizedBox(
    width: W.x5l,
    height: W.x5l,
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: const .only(topLeft: .circular(10), bottomLeft: .circular(10)),
        border: .all(width: borderWidth, color: borderColor),
      ),
      child: Padding(
        padding: const .all(0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: .4),
            borderRadius: const .only(topLeft: .circular(10), bottomLeft: .circular(10)),
          ),
          child: Image.asset(
            'assets/banks/${bankAccount.bankName}.png',
            package: 'iv_project_invitation_theme',
            fit: .fitWidth,
            errorBuilder: (_, _, _) {
              final bankNames = bankAccount.bankName.split(' ');
              final bankName = bankNames.length > 1
                  ? bankNames.map((e) => e[0]).join().replaceAll(RegExp(r'[^a-zA-Z]'), '')
                  : bankNames[0];
              return Padding(
                padding: .symmetric(vertical: W.x4s),
                child: ColoredBox(
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      bankName,
                      style: TextStyle(
                        fontSize: FontSize.xl,
                        color: Colors.grey.shade800,
                        fontWeight: .w700,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    ),
  );

  Widget _bankInfo() => SizedBox(
    height: W.x5l,
    width: Screen.width - (W.x5l + (W.sm * 2) + (W.x6s * 2)),
    child: Padding(
      padding: const .only(left: 2),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: .all(width: borderWidth, color: borderColor),
          borderRadius: const .only(topRight: .circular(10), bottomRight: .circular(10)),
          color: color,
        ),
        child: Row(
          children: [
            SizedBox(width: W.x9s),
            Column(
              mainAxisAlignment: .center,
              crossAxisAlignment: .start,
              children: [
                Text(
                  bankAccount.bankName,
                  style: AppFonts.inter(
                    color: textColor,
                    fontSize: FontSize.xs,
                    fontWeight: .w500,
                    // height: 1.2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  bankAccount.number,
                  style: AppFonts.inter(
                    color: textColor,
                    fontSize: FontSize.md,
                    fontWeight: .w500,
                    height: 1.3,
                  ),
                ),
                Text(
                  'a.n ${bankAccount.accountName}',
                  style: AppFonts.inter(
                    color: textColor,
                    fontSize: FontSize.x2s,
                    fontWeight: .w400,
                    height: 1.3,
                  ),
                ),
              ],
            ),
            const Spacer(),
            _CopyBankAccountNumberButton(
              baseColor: copyBaseColor,
              bankAccountNumber: bankAccount.number,
            ),
            SizedBox(width: W.x7s),
          ],
        ),
      ),
    ),
  );
}

class _CopyBankAccountNumberButton extends StatefulWidget {
  const _CopyBankAccountNumberButton({required this.baseColor, required this.bankAccountNumber});

  final Color baseColor;
  final String bankAccountNumber;

  @override
  State<_CopyBankAccountNumberButton> createState() => _CopyBankAccountNumberButtonState();
}

class _CopyBankAccountNumberButtonState extends State<_CopyBankAccountNumberButton> {
  bool _isCopied = false;

  @override
  Widget build(BuildContext context) {
    return QuickButton(
      onTap: () async {
        _isCopied = true;
        setState(() {});
        Clipboard.setData(ClipboardData(text: widget.bankAccountNumber));
        await Future<void>.delayed(const Duration(milliseconds: 800));
        _isCopied = false;
        setState(() {});
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _isCopied
              ? ColorUtil.lighten(AppColor.primaryColor, 90)
              : widget.baseColor.withValues(alpha: .1),
          borderRadius: .circular(5),
          border: .all(width: .5, color: _isCopied ? AppColor.primaryColor : widget.baseColor),
        ),
        child: Padding(
          padding: const .only(top: 5, bottom: 5, left: 4, right: 3),
          child: Icon(
            Icons.content_copy_rounded,
            color: _isCopied ? AppColor.primaryColor : widget.baseColor,
          ),
        ),
      ),
    );
  }
}
