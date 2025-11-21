import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_widget_core/iv_project_widget_core.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class EnhancedGeneralTextField extends StatefulWidget {
  const EnhancedGeneralTextField({
    super.key,
    required this.textEditingController,
    this.labelTextBuilder,
    this.inputFormatters,
    this.maxLines,
    this.maxLength,
    this.enabled = true,
    this.isMandatory = true,
    this.onChanged,
    this.validator,
  });

  final TextEditingController textEditingController;
  final String Function()? labelTextBuilder;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? maxLength;
  final bool enabled;
  final bool isMandatory;
  final void Function(String value)? onChanged;
  final TextFieldValidator Function(String)? validator;

  @override
  State<EnhancedGeneralTextField> createState() => _EnhancedGeneralTextFieldState();
}

class _EnhancedGeneralTextFieldState extends State<EnhancedGeneralTextField> {
  @override
  Widget build(BuildContext context) {
    return GeneralTextField(
      controller: widget.textEditingController,
      height: (widget.maxLines ?? 1) > 1 ? null : H.x3l,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      enabled: widget.enabled,
      style: AppFonts.inter(color: Colors.grey.shade100, fontSize: FS.md),
      decoration: FieldDecoration(
        labelText: widget.labelTextBuilder?.call(),
        labelStyle: AppFonts.inter(color: Colors.grey.shade300, fontSize: FS.md),
        filled: true,
        fillColor: Colors.grey.shade500.withValues(alpha: .3),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade600, width: 1),
          borderRadius: const .all(Radius.circular(8)),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade600, width: 1),
          borderRadius: const .all(Radius.circular(8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade600, width: 1),
          borderRadius: const .all(Radius.circular(8)),
        ),
        suffixIcons: () {
          if (!widget.enabled) return [];
          if (!widget.isMandatory) {
            if (widget.textEditingController.text.isEmpty) return [];
            return [SharedPersonalize.suffixClear(() => widget.textEditingController.reset())];
          }
          if (widget.textEditingController.text.isEmpty) return [SharedPersonalize.suffixMandatory];
          return [SharedPersonalize.suffixClear(() => widget.textEditingController.reset())];
        },
      ),
      inputFormatters: widget.inputFormatters,
      onChanged: (value) => widget.onChanged?.call(value),
      validator: (value) {
        if (widget.validator != null) {
          final validator = widget.validator!(value);
          if (validator.isSuccess == false) return validator;
        }
        if (value.isEmpty && widget.isMandatory) return SharedPersonalize.fieldCanNotEmpty();
        return TextFieldValidator.success();
      },
    );
  }
}
