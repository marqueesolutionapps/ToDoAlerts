// ignore_for_file: file_names

part of 'UtilityLibrary.dart';

class AppTextStyle {

  static FontWeight _getFontWeight(int weight) {
    switch (weight) {
      case 100:
        return FontWeight.w100;
      case 200:
        return FontWeight.w200;
      case 300:
        return FontWeight.w300;
      case 400:
        return FontWeight.w400;
      case 500:
        return FontWeight.w500;
      case 600:
        return FontWeight.w600;
      case 700:
        return FontWeight.w700;
      case 800:
        return FontWeight.w800;
      case 900:
        return FontWeight.w900;
    }
    return FontWeight.w400;
  }

  static TextStyle getTextStyle(
      {int fontWeight = 500,
        double letterSpacing = 0.5,
        color,
        TextDecoration decoration = TextDecoration.none,
        double height = 1.35,
        double wordSpacing = 0,
        double fontSize = 18}) {

    Color finalColor;
    if (color == null) {
      finalColor = themeTextDefaultColor;
    } else {
      finalColor = color;
    }

    return GoogleFonts.poppins(fontSize: fontSize, fontWeight: _getFontWeight(fontWeight), letterSpacing: letterSpacing, color: finalColor, decoration: decoration, height: height, wordSpacing: wordSpacing,);
  }

}