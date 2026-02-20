import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/src/widgets/glass_effect_box.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class Padlock extends StatelessWidget {
  const Padlock({super.key, required this.onOpened});

  final Function() onOpened;

  @override
  Widget build(BuildContext context) {
    final langCode = context.read<LocaleCubit>().state.languageCode;

    return GeneralEffectsButton(
      onTap: () async {
        onOpened();
        await Future<void>.delayed(const Duration(seconds: 2));
      },
      height: W.lg + H.x10s,
      width: W.x12l,
      borderRadius: .circular(30),
      color: Colors.grey.shade900.withValues(alpha: .2),
      border: .all(width: .5, color: Colors.grey.shade500),
      child: Stack(
        alignment: .center,
        children: [
          GlassEffectBox(
            height: W.lg + H.x10s,
            width: W.x12l,
            borderRadius: 40,
            color: Colors.grey.shade200.withValues(alpha: .5),
          ),
          Text(
            langCode == 'en' ? 'Open Invitation' : 'Buka Undangan',
            style: AppFonts.inter(color: Colors.grey.shade300, fontSize: FontSize.sm, fontWeight: .w600),
          ),
        ],
      ),
    );
  }
}
