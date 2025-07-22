import 'package:flutter/material.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class FieldView<T> extends StatelessWidget {
  const FieldView({super.key, required this.sheetContentBuilder, required this.onCompleted, required this.child});

  final Widget Function(BuildContext context, void Function(T value) onSelected) sheetContentBuilder;
  final void Function(T value) onCompleted;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GeneralEffectsButton(
      onTap: () async {
        final value = await ShowModal.bottomSheet<T>(
          context,
          decoration: BottomSheetDecoration(
            color: ColorConverter.lighten(AppColor.primaryColor, 94),
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          ),
          header: const BottomSheetHeader(useHandleBar: true),
          contentBuilder: (_) {
            return sheetContentBuilder(context, (value) => Navigator.of(context).pop<T>(value));
          },
        );
        onCompleted.call(value);
      },
      splashColor: Colors.white,
      child: child,
    );
  }
}
