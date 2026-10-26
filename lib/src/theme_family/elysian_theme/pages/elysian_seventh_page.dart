import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/elysian_configs.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/widgets/elysian_glass_card.dart';
import 'package:iv_project_invitation_theme/src/theme_family/elysian_theme/widgets/elysian_reveal.dart';
import 'package:iv_project_model/iv_project_model.dart';

class const ElysianSeventhPage({
  super.key,
  required final ElysianSeventhPageConfig config,
  required final List<BankAccountResponse> bankAccounts,
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
        padding: const .symmetric(horizontal: 22, vertical: 28),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: .center,
              children: [
                ElysianReveal(
                  delay: const Duration(milliseconds: 100),
                  child: Text(
                    langCode == 'en' ? 'WEDDING GIFT' : 'TANDA KASIH',
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
                  child: Padding(
                    padding: const .symmetric(horizontal: 16),
                    child: Text(
                      langCode == 'en'
                          ? 'Your presence and prayers are the greatest gift. However, if you wish to give a token of love, you may send it via:'
                          : 'Doa restu Anda merupakan karunia terindah bagi kami. Namun jika ingin memberikan tanda kasih, Anda dapat mengirimkannya melalui:',
                      style: TextStyle(
                        color: config.subtitleColor,
                        fontSize: 12,
                        height: 1.5,
                      ),
                      textAlign: .center,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                for (var i = 0; i < bankAccounts.length; i++)
                  ElysianReveal(
                    delay: Duration(milliseconds: 300 + (i * 120)),
                    child: Padding(
                      padding: const .only(bottom: 16),
                      child: ElysianGlassCard(
                        backgroundColor: config.cardColor,
                        borderColor: config.cardBorderColor,
                        padding: const .all(20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: .spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.credit_card_rounded, color: config.titleColor, size: 20),
                                    const SizedBox(width: 8),
                                    Text(
                                      bankAccounts[i].bankName.toUpperCase(),
                                      style: TextStyle(
                                        color: config.bankNameColor,
                                        fontSize: 14,
                                        fontWeight: .bold,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                                _ElysianCopyButton(
                                  number: bankAccounts[i].number,
                                  buttonColor: config.copyButtonColor,
                                  textColor: config.copyButtonTextColor,
                                  langCode: langCode,
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            Text(
                              bankAccounts[i].number,
                              style: TextStyle(
                                color: config.accountNumberColor,
                                fontSize: 18,
                                fontWeight: .w700,
                                letterSpacing: 2,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'a.n. ${bankAccounts[i].accountName}',
                              style: TextStyle(
                                color: config.ownerNameColor,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class const _ElysianCopyButton({
  required final String number,
  required final Color buttonColor,
  required final Color textColor,
  required final String langCode,
}) extends StatefulWidget {
  @override
  State<_ElysianCopyButton> createState() => _ElysianCopyButtonState();
}

class _ElysianCopyButtonState() extends State<_ElysianCopyButton> {
  bool _isCopied = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() => _isCopied = true);
        Clipboard.setData(ClipboardData(text: widget.number));
        await Future<void>.delayed(const Duration(milliseconds: 1200));
        if (mounted) {
          setState(() => _isCopied = false);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const .symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: _isCopied ? const Color(0xFF388E3C) : widget.buttonColor,
          borderRadius: .circular(20),
        ),
        child: Row(
          mainAxisSize: .min,
          children: [
            Icon(
              _isCopied ? Icons.check_rounded : Icons.copy_rounded,
              color: widget.textColor,
              size: 13,
            ),
            const SizedBox(width: 4),
            Text(
              _isCopied
                  ? (widget.langCode == 'en' ? 'COPIED' : 'TERSALIN')
                  : (widget.langCode == 'en' ? 'COPY' : 'SALIN'),
              style: TextStyle(
                color: widget.textColor,
                fontSize: 10,
                fontWeight: .bold,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
