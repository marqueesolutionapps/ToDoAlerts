// ignore_for_file: file_names, unrelated_type_equality_checks

part of 'WidgetLibrary.dart';

class CustomTextFormField extends StatelessWidget {

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? labelText;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final String? initialValue;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final TapRegionCallback? onTapOutside;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final bool? readOnly;
  final bool? autofocus;
  final bool? isBorder;
  final double? fontSize;
  final int? minLines;
  final int? maxLines;
  final TextAlign? textAlign;
  final Color? fillColor;
  final bool? isSuffixIcon;
  final bool? isModelField;
  final String? icon;

  CustomTextFormField({
    Key? key,
    required this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.labelText,
    this.hintText,
    this.validator,
    this.initialValue,
    this.focusNode,
    this.onChanged,
    this.onTap,
    this.onTapOutside,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.readOnly,
    this.autofocus,
    this.textAlign,
    this.fontSize,
    this.isBorder,
    this.minLines,
    this.maxLines,
    this.fillColor,
    this.isSuffixIcon,
    this.isModelField,
    this.icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSuffixIconValue = isSuffixIcon ?? false;
    return TextFormField(
      textAlign: textAlign ?? TextAlign.center,
      controller: controller,
      keyboardType: keyboardType,
      cursorColor: themeTextDefaultColor,
      textInputAction: TextInputAction.next,
      inputFormatters: inputFormatters,
      validator: validator,
      initialValue: initialValue,
      focusNode: focusNode,
      minLines: minLines ?? 1,
      maxLines: maxLines ?? 1,
      style:  AppTextStyle.getTextStyle(
          color: themeTextDefaultColor,
          fontWeight: 600,
          fontSize: fontSize ?? 16
      ),
      onChanged: onChanged,
      onTap: onTap,
      onTapOutside: onTapOutside,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      readOnly: readOnly ?? false,
      autofocus: autofocus ?? false,
      decoration: isSuffixIconValue == true ? formFieldDecorationWithSuffixIcon(labelText ?? "", hintText ?? "", icon ?? "", fillColor ?? white, isModelField ?? false) : formFieldDecoration(labelText ?? "",hintText ?? "", fillColor ?? white, isModelField ?? false),
    );
  }
}
