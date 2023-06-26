// ignore_for_file: file_names, non_constant_identifier_names, deprecated_member_use

part of 'DecorationLibrary.dart';

InputDecoration formFieldDecoration(String labelText, String hintText) {
  return InputDecoration(
    filled: true,
    fillColor: white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    floatingLabelBehavior: FloatingLabelBehavior.never,
    disabledBorder: borderDesign,
    enabledBorder: borderDesign,
    focusedBorder: borderDesign,
    errorBorder: borderDesign,
    focusedErrorBorder: borderDesign,
    hintText: hintText,
    labelText: labelText,
    hintStyle: textStyle(grey, 500, 18),
    labelStyle: textStyle(black, 500, 18),
    errorStyle: textStyle(errorColor, 500, 14),
    errorMaxLines: 1,
  );
}

InputDecoration formFieldDecorationWithSuffixIcon(String labelText, String hintText, String icon) {
  return InputDecoration(
    fillColor: white,
    filled: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    floatingLabelBehavior: FloatingLabelBehavior.never,
    disabledBorder: borderDesign,
    enabledBorder: borderDesign,
    focusedBorder: borderDesign,
    errorBorder: borderDesign,
    focusedErrorBorder: borderDesign,
    suffixIcon: Padding(
      padding: const EdgeInsets.only(top: 5.0, right: 8.0, bottom: 5.0),
      child: SvgPicture.asset(
        icon,
        fit: BoxFit.contain,
      ),
    ),
    hintText: hintText,
    labelText: labelText,
    hintStyle: textStyle(grey, 500, 18),
    labelStyle: textStyle(black, 500, 18),
    errorStyle: textStyle(errorColor, 500, 14),
    errorMaxLines: 1,
  );
}

InputBorder borderDesign = OutlineInputBorder(
  borderRadius: customBorderRadius,
  borderSide: BorderSide(
      width: 2,
      color: greyBorder,
  ),
);

BorderRadius customBorderRadius = BorderRadius.circular(10);
double customBorderWidth = 1.5;

TextStyle? textStyle(Color color, int fontWeight, double fontSize) {
  return AppTextStyle.getTextStyle(
    color: color,
    fontWeight: fontWeight,
    fontSize: fontSize,
  );
}