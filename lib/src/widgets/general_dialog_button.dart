import 'package:flutter/material.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_widget_core/iv_project_widget_core.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class GeneralDialogButton extends StatelessWidget {
  const GeneralDialogButton({
    super.key,
    required this.title,
    required this.color,
    this.isDisabled = false,
    this.isBusy = false,
    this.isLoading = false,
    required this.onTap,
  });

  final String title;
  final Color color;
  final bool isDisabled;
  final bool isBusy;
  final bool isLoading;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .only(top: 14, left: 14, right: 14, bottom: 20),
      child: GeneralEffectsButton(
        onTap: onTap,
        isDisabled: isBusy || isDisabled,
        height: 52,
        color: color,
        splashColor: Colors.grey.shade300,
        borderRadius: .circular(40),
        useInitialElevation: true,
        child: Row(
          mainAxisAlignment: .center,
          children: [
            if (isLoading) ...[SharedPersonalize.loadingWidget(size: 16, color: Colors.white), const SizedBox(width: 10)],
            Text(
              title,
              style: AppFonts.inter(fontWeight: .w700, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
