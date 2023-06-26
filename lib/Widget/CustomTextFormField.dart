// ignore_for_file: file_names, unrelated_type_equality_checks

part of 'WidgetLibrary.dart';

class CustomTextFormField extends StatefulWidget {

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
  final bool? isSuffixIcon;
  final String? icon;

  const CustomTextFormField({
    Key? key,
    this.controller,
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
    this.isSuffixIcon,
    this.icon,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {

  String? hintText, labelText, icon;
  bool? readOnly, autofocus, isSuffixIcon;


  @override
  void initState() {
    labelText = widget.labelText != null && widget.labelText != "null" && widget.labelText != "" ? widget.labelText : "";
    hintText = widget.hintText != null && widget.hintText != "null" && widget.hintText != "" ? widget.hintText : "";
    readOnly = widget.readOnly != null && widget.readOnly != "null" && widget.readOnly != "" ? widget.readOnly! : false;
    autofocus = widget.autofocus != null && widget.autofocus != "null" && widget.autofocus != "" ? widget.autofocus : false;
    isSuffixIcon = widget.isSuffixIcon != null && widget.isSuffixIcon != "null" && widget.isSuffixIcon != "" ? widget.isSuffixIcon : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      cursorColor: primary,
      textInputAction: TextInputAction.next,
      inputFormatters: widget.inputFormatters,
      validator: widget.validator,
      initialValue: widget.initialValue,
      focusNode: widget.focusNode,
      style:  AppTextStyle.getTextStyle(
        color: black,
        fontWeight: 500,
      ),
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      onTapOutside: widget.onTapOutside,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      readOnly: readOnly!,
      autofocus: autofocus!,
      decoration: isSuffixIcon == true ? formFieldDecorationWithSuffixIcon(labelText!,hintText!, icon!) : formFieldDecoration(labelText!,hintText!),
    );
  }
}