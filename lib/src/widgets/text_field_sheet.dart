import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_invitation_theme/src/widgets/enhanced_general_text_field.dart';
import 'package:iv_project_invitation_theme/src/widgets/general_dialog_button.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class TextFieldSheet extends StatefulWidget {
  const TextFieldSheet({
    super.key,
    required this.value,
    this.labelTextBuilder,
    this.inputFormatters,
    this.onChanged,
    this.validator,
    required this.onCompleted,
  });

  final String value;
  final String Function()? labelTextBuilder;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String value)? onChanged;
  final TextFieldValidator Function(String)? validator;
  final void Function(String) onCompleted;

  @override
  State<TextFieldSheet> createState() => _TextFieldSheetState();
}

class _TextFieldSheetState extends State<TextFieldSheet> {
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _textEditingController.text = widget.value;
  }

  @override
  void dispose() {
    _textEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 30),
        Row(
          children: [
            const SizedBox(width: 14),
            Icon(Icons.edit, size: 32, color: ColorConverter.lighten(AppColor.primaryColor)),
            const SizedBox(width: 8),
            Text(
              '${AppLocalization.translate('common.edit')} text',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: EnhancedGeneralTextField(
            textEditingController: _textEditingController,
            labelTextBuilder: widget.labelTextBuilder,
            inputFormatters: widget.inputFormatters,
            onChanged: widget.onChanged,
            validator: widget.validator,
          ),
        ),
        const SizedBox(height: 120),
        GeneralDialogButton(
          onTap: () => widget.onCompleted(_textEditingController.text),
          title: AppLocalization.translate('common.confirm'),
          color: ColorConverter.lighten(AppColor.primaryColor),
        ),
      ],
    );
  }
}
