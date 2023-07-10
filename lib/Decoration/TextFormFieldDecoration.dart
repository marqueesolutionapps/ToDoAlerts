// ignore_for_file: file_names, non_constant_identifier_names, deprecated_member_use

part of 'DecorationLibrary.dart';

InputDecoration formFieldDecoration(String labelText, String hintText, Color fillColor, bool isModelField) {
  return InputDecoration(
    filled: true,
    fillColor: fillColor,
    isDense: false,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    disabledBorder: borderDesign,
    enabledBorder: borderDesign,
    focusedBorder: borderDesign,
    errorBorder: borderDesign,
    focusedErrorBorder: borderDesign,
    hintText: hintText,
    labelText: labelText,
    hintStyle: textStyle(isModelField ? bottomBarItemAndDayNameColor : hintGrey, isModelField ? 700 : 400, 18),
    labelStyle: textStyle(black, 400, 18),
    errorStyle: textStyle(errorColor, 500, 14),
    errorMaxLines: 1,
  );
}

InputDecoration formFieldDecorationWithSuffixIcon(String labelText, String hintText, String icon, Color fillColor, bool isModelField) {
  return InputDecoration(
    filled: true,
    fillColor: fillColor,
    isDense: false,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    disabledBorder: borderDesign,
    enabledBorder: borderDesign,
    focusedBorder: borderDesign,
    errorBorder: borderDesign,
    focusedErrorBorder: borderDesign,
    suffixIcon: Padding(
      padding: const EdgeInsets.only(top: 10.0, right: 10.0, bottom: 10.0),
      child: SvgPicture.asset(
        icon,
        color: primary,
        fit: BoxFit.contain,
      ),
    ),
    hintText: hintText,
    labelText: labelText,
    hintStyle: textStyle(isModelField ?  bottomBarItemAndDayNameColor : hintGrey, isModelField ? 700 : 400, 18),
    labelStyle: textStyle(black, 400, 18),
    errorStyle: textStyle(errorColor, 500, 14),
    errorMaxLines: 1,
  );
}

InputBorder borderDesign = OutlineInputBorder(
  borderRadius: customBorderRadius,
  borderSide: BorderSide(
      width: 2,
      color: fillGray,
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