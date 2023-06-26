// ignore_for_file: file_names

part of 'UtilityLibrary.dart';

class Util {

  static String deviceId = "";

  static String appTheme = lightTheme;

  static double maxScreenWidth = 800;
  static double? screenWidth;
  static double? screenHeight;
  static double? statusBarHeight;
  static double? appBarHeight;


  static double paddingValue = 20;

  static EdgeInsets paddingAll = EdgeInsets.all(paddingValue);

  static void consoleLog(String s) => log(s);

  static capitalizeAllWord(String value) {
    if(value.isEmpty) return value;

    var result = value[0].toUpperCase();
    for (int i = 1; i < value.length; i++) {
      if (value[i - 1] == " ") {
        result = result + value[i].toUpperCase();
      } else {
        result = result + value[i];
      }
    }
    return result;
  }
}