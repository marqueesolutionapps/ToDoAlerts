// ignore_for_file: file_names, unrelated_type_equality_checks

part of 'WidgetLibrary.dart';

class CustomText extends StatelessWidget {

  final String? value;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final int? fontWeight;
  final double? letterSpacing;
  final double? height;
  final double? wordSpacing;
  final double? fontSize;
  final Color? color;

  const CustomText({
    Key? key,
    required this.value,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.fontWeight,
    this.letterSpacing,
    this.height,
    this.wordSpacing,
    this.fontSize,
    this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Text(
      value!,
      textAlign: textAlign ?? TextAlign.center,
      maxLines: maxLines ?? 20,
      overflow: overflow ?? TextOverflow.ellipsis,
      style: AppTextStyle.getTextStyle(
        color: color ?? themeTextDefaultColor,
        fontWeight: fontWeight ?? 400,
        fontSize : fontSize ?? 18,
        height: height ?? 1.35,
        wordSpacing: wordSpacing ?? 0,
        letterSpacing: letterSpacing ?? 0.5,
      ),
    );
  }
}