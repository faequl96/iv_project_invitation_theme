import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/src/themes/page_view_based_theme/page_view_based_configs.dart';
import 'package:iv_project_invitation_theme/src/widgets/glass_effect_box.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class PageViewBasedSixthPageAsImage extends StatelessWidget {
  const PageViewBasedSixthPageAsImage({super.key, required this.config, this.bankAccounts = const []});

  final PageViewBasedSixthPageConfig config;
  final List<BankAccountResponse> bankAccounts;

  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    return Stack(
      children: [
        if (config.firstGradientBackgroundColor != null && config.secondGradientBackgroundColor != null)
          Positioned(
            bottom: 0,
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
                    const Spacer(),
                    Padding(
                      padding: .symmetric(horizontal: W.x6s),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: .all(width: config.introductionBorderWidth, color: config.introductionBorderColor),
                          borderRadius: .circular(10),
                          color: config.introductionColor,
                        ),
                        child: Padding(
                          padding: .only(top: H.sm, left: 24, right: 24, bottom: H.sm),
                          child: _introduction(langCode),
                        ),
                      ),
                    ),
                    Column(
                      children: [
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
                    const Spacer(),
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
                delayBeforeStart: const Duration(milliseconds: 2800),
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
        Icon(Icons.card_giftcard_rounded, size: W.xs, color: config.titlePageColor),
        const SizedBox(width: 10),
        Text(
          langCode == 'en' ? 'Wedding Gift' : 'Kado Pernikahan',
          style: AppFonts.inter(color: config.titlePageColor, fontSize: FontSize.x3l, fontWeight: .w700),
        ),
      ],
    ),
  );

  Widget _introduction(String langCode) => Text(
    langCode == 'en'
        ? 'Your prayers and blessings are a truly meaningful gift to us. And if giving is an expression of your love, you can give a cashless gift.'
        : 'Doa restu Anda merupakan karunia yang sangat berarti bagi kami. Dan jika memberi adalah ungkapan tanda kasih Anda, Anda dapat memberi kado secara cashless.',
    style: AppFonts.inter(color: config.introductionTextColor, fontSize: FontSize.md, fontWeight: .w400),
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
        _bankLogo(),
        _bankInfo(),
        SizedBox(width: W.x6s),
      ],
    );
  }

  Widget _bankLogo() => SizedBox(
    width: W.x7l,
    height: W.x7l,
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: .circular(10),
        border: .all(width: borderWidth, color: borderColor),
      ),
      child: Padding(
        padding: const .all(6),
        child: DecoratedBox(
          decoration: BoxDecoration(color: Colors.white.withValues(alpha: .4), borderRadius: .circular(6)),
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
                      style: TextStyle(fontSize: FontSize.xl, color: Colors.grey.shade800, fontWeight: .w700),
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
    width: Screen.width - (W.x7l + (W.x6s * 4)),
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
                  style: AppFonts.inter(color: textColor, fontSize: FontSize.md, fontWeight: .w500, height: 1.3),
                ),
                Text(
                  'a.n ${bankAccount.accountName}',
                  style: AppFonts.inter(color: textColor, fontSize: FontSize.x2s, fontWeight: .w400, height: 1.3),
                ),
              ],
            ),
            const Spacer(),
            _CopyBankAccountNumberButton(baseColor: copyBaseColor, bankAccountNumber: bankAccount.number),
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
  final bool _isCopied = false;

  @override
  Widget build(BuildContext context) {
    return GeneralEffectsButton(
      onTap: () {},
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _isCopied ? ColorConverter.lighten(AppColor.primaryColor, 90) : widget.baseColor.withValues(alpha: .1),
          borderRadius: .circular(5),
          border: .all(width: .5, color: _isCopied ? AppColor.primaryColor : widget.baseColor),
        ),
        child: Padding(
          padding: const .only(top: 5, bottom: 5, left: 4, right: 3),
          child: Icon(Icons.content_copy_rounded, color: _isCopied ? AppColor.primaryColor : widget.baseColor),
        ),
      ),
    );
  }
}
