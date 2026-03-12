import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_widget_core/iv_project_widget_core.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class EnhancedGeneralTextField extends StatefulWidget {
  const EnhancedGeneralTextField({
    super.key,
    required this.fieldTextColor,
    required this.fieldLabelColor,
    required this.fieldFillColor,
    required this.fieldBorderColor,
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

  final Color fieldTextColor;
  final Color fieldLabelColor;
  final Color fieldFillColor;
  final Color fieldBorderColor;
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
    final lang = context.read<LocaleCubit>().state.languageCode;

    return GeneralTextField(
      controller: widget.textEditingController,
      height: (widget.maxLines ?? 1) > 1 ? null : H.x3l,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      enabled: widget.enabled,
      style: AppFonts.inter(color: widget.fieldTextColor, fontSize: FontSize.md),
      decoration: FieldDecoration(
        labelText: widget.labelTextBuilder?.call(),
        labelStyle: AppFonts.inter(color: widget.fieldLabelColor, fontSize: FontSize.md),
        filled: true,
        fillColor: widget.fieldFillColor,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.fieldBorderColor, width: 1),
          borderRadius: const .all(.circular(8)),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.fieldBorderColor, width: 1),
          borderRadius: const .all(.circular(8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.fieldBorderColor, width: 1),
          borderRadius: const .all(.circular(8)),
        ),
        suffixIcons: () {
          if (!widget.enabled) return [];
          if (!widget.isMandatory) {
            if (widget.textEditingController.text.isEmpty) return [];
            return [SharedPersonalize.suffixClear(() => widget.textEditingController.reset())];
          }
          if (widget.textEditingController.text.isEmpty) return [SharedPersonalize.suffixMandatory()];
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
        if (value.isEmpty && widget.isMandatory) {
          return SharedPersonalize.fieldCanNotEmpty(
            message: lang == 'id' ? 'Tidak boleh kosong' : 'Cannot be empty',
            textStyle: TextStyle(color: Colors.red.shade400),
          );
        }
        return .success();
      },
    );
  }
}
