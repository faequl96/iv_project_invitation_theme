import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:iv_project_core/iv_project_core.dart';
import 'package:quick_dev_sdk/quick_dev_sdk.dart';

class EnhancedGeneralTextField extends StatefulWidget {
  const EnhancedGeneralTextField({
    super.key,
    required this.textEditingController,
    this.labelTextBuilder,
    this.inputFormatters,
    this.enabled = true,
    this.onChanged,
    this.validator,
  });

  final TextEditingController textEditingController;
  final String Function()? labelTextBuilder;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
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
      enabled: widget.enabled,
      decoration: FieldDecoration(
        labelText: widget.labelTextBuilder?.call(),
        filled: true,
        suffixIcon: () {
          if (!widget.enabled) return null;
          if (widget.textEditingController.text.isEmpty) return SharedPersonalize.suffixMandatory;
          return SharedPersonalize.suffixClear(() => widget.textEditingController.reset());
        },
      ),
      inputFormatters: widget.inputFormatters,
      onChanged: (value) => widget.onChanged?.call(value),
      validator: (value) {
        if (widget.validator != null) {
          final validator = widget.validator!(value);
          if (validator.isSuccess == false) return validator;
        }
        if (value.isEmpty) return SharedPersonalize.fieldCanNotEmpty();
        return TextFieldValidator.success();
      },
    );
  }
}
