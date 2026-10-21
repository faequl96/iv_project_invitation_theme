import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/iv_project_invitation_theme.dart';
import 'package:iv_project_invitation_theme/src/theme_family/editorial_theme/editorial_configs.dart';
import 'package:iv_project_invitation_theme/src/widgets/fade_and_slide_transition.dart';
import 'package:iv_project_model/iv_project_model.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class const EditorialSeventhPage({
  super.key,
  required final EditorialSeventhPageConfig config,
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
        padding: const .symmetric(horizontal: 20, vertical: 32),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            FadeAndSlideTransition(
              slideFrom: .top,
              slideFromOffset: .3,
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(
                    langCode == 'en' ? 'GIFT' : 'TANDA KASIH',
                    style: TextStyle(
                      color: config.sectionHeaderColor,
                      fontSize: 11,
                      fontWeight: .bold,
                      letterSpacing: 2,
                    ),
                  ),
                  Text(
                    'WEDDING GIFT',
                    style: TextStyle(
                      color: config.descriptionColor,
                      fontSize: 10,
                      fontWeight: .w600,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: H.lg),
            Padding(
              padding: const .symmetric(horizontal: 2),
              child: FadeAndSlideTransition(
                slideFrom: .top,
                slideFromOffset: .4,
                child: Text(
                  langCode == 'en'
                      ? 'Your presence and prayers are the greatest gift. However, if you wish to give a token of love, you may send it via:'
                      : 'Doa restu Anda merupakan karunia terindah bagi kami. Namun jika ingin memberikan tanda kasih, Anda dapat mengirimkannya melalui:',
                  style: TextStyle(color: config.descriptionColor, fontSize: 14, height: 1.5),
                  textAlign: .justify,
                ),
              ),
            ),
            SizedBox(height: H.lg),
            FadeAndSlideTransition(
              slideFrom: .bottom,
              slideFromOffset: .2,
              child: Column(
                children: [
                  for (final bankAccount in bankAccounts)
                    Container(
                      padding: const .all(16),
                      margin: const .symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: config.cardBackgroundColor,
                        borderRadius: .circular(4),
                        border: .all(color: config.borderColor),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: .03),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Row(
                            mainAxisAlignment: .spaceBetween,
                            children: [
                              Text(
                                bankAccount.bankName.toUpperCase(),
                                style: TextStyle(
                                  color: config.accountHolderColor,
                                  fontSize: 15,
                                  fontWeight: .w800,
                                  letterSpacing: 1,
                                ),
                              ),
                              _EditorialCopyButton(
                                number: bankAccount.number,
                                copyButtonBgColor: config.copyButtonBgColor,
                                copyButtonTextColor: config.copyButtonTextColor,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            bankAccount.number,
                            style: TextStyle(
                              color: config.accountNumberColor,
                              fontSize: 17,
                              fontWeight: .w700,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'a.n. ${bankAccount.accountName}',
                            style: TextStyle(color: config.descriptionColor, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class const _EditorialCopyButton({
  required final String number,
  required final Color copyButtonBgColor,
  required final Color copyButtonTextColor,
}) extends StatefulWidget {
  @override
  State<_EditorialCopyButton> createState() => _EditorialCopyButtonState();
}

class _EditorialCopyButtonState() extends State<_EditorialCopyButton> {
  bool _isCopied = false;

  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    return QuickButton(
      onTap: () async {
        setState(() => _isCopied = true);
        Clipboard.setData(ClipboardData(text: widget.number));
        await Future<void>.delayed(const Duration(milliseconds: 1000));
        if (mounted) {
          setState(() => _isCopied = false);
        }
      },
      style: .new(
        padding: const .symmetric(horizontal: 10, vertical: 5),
        color: _isCopied ? const Color(0xFF2E7D32) : widget.copyButtonBgColor,
        borderRadius: .circular(2),
      ),
      child: Row(
        mainAxisSize: .min,
        children: [
          Icon(_isCopied ? Icons.check : Icons.copy, color: Colors.white, size: 11),
          const SizedBox(width: 4),
          Text(
            _isCopied
                ? (langCode == 'en' ? 'COPIED' : 'TERSALIN')
                : (langCode == 'en' ? 'COPY' : 'SALIN'),
            style: TextStyle(color: widget.copyButtonTextColor, fontSize: 10, fontWeight: .bold),
          ),
        ],
      ),
    );
  }
}
