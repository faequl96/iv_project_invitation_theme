import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:iv_project_widget_core/iv_project_widget_core.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class const GeneralTextField({
  super.key,
  required final Color fieldTextColor,
  required final Color fieldLabelColor,
  required final Color fieldFillColor,
  required final Color fieldBorderColor,
  final BorderRadius fieldBorderRadius = const .all(.circular(8)),
  required final TextEditingController textEditingController,
  final String Function()? labelTextBuilder,
  final List<TextInputFormatter>? inputFormatters,
  final int? maxLines,
  final int? maxLength,
  final bool enabled = true,
  final bool isMandatory = true,
  final void Function(String value)? onChanged,
  final TextFieldValidator Function(String)? validator,
}) extends StatefulWidget {
  @override
  State<GeneralTextField> createState() => _GeneralTextFieldState();
}

class _GeneralTextFieldState() extends State<GeneralTextField> {
  @override
  Widget build(BuildContext context) {
    final lang = context.read<LocaleCubit>().state.languageCode;

    return QuickTextField(
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
          borderRadius: widget.fieldBorderRadius,
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.fieldBorderColor, width: 1),
          borderRadius: widget.fieldBorderRadius,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.fieldBorderColor, width: 1),
          borderRadius: widget.fieldBorderRadius,
        ),
        suffixIcons: (controller) {
          if (!widget.enabled) return [];
          if (!widget.isMandatory) {
            if (controller.text.isEmpty) return [];
            return [SharedPersonalize.suffixClear(() => controller.reset())];
          }
          if (controller.text.isEmpty) return [SharedPersonalize.suffixMandatory()];
          return [SharedPersonalize.suffixClear(() => controller.reset())];
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
