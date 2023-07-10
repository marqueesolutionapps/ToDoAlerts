// ignore_for_file: file_names

part of 'UtilityLibrary.dart';

class Util {
  static String token = "AsdfadasdaaasdasdakjdajjdahuihnasdiuhBC";

  static double maxScreenWidth = 800;
  static double? screenWidth;
  static double? screenHeight;
  static double? statusBarHeight;
  static double? appBarHeight;
  static double? bottomBarHeight = 80;
  static double? bottomBarMenuSize = bottomBarHeight! / 4;

  static double? backAndForwardButtonSize = 45;

  static double calendarBorderRadiusValue = 10;
  static List<String> weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  static List<String> monthNames = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

  static double paddingValue = 20;

  static EdgeInsets paddingAll = EdgeInsets.all(paddingValue);
  static EdgeInsets leftRightPadding = EdgeInsets.symmetric(horizontal: paddingValue);
  static EdgeInsets onlyLeftPadding = EdgeInsets.only(left: paddingValue);
  static EdgeInsets onlyRightPadding = EdgeInsets.only(right: paddingValue);
  static EdgeInsets topBottomPadding = EdgeInsets.symmetric(vertical: paddingValue);
  static EdgeInsets onlyBottomPadding = EdgeInsets.only(bottom: paddingValue);
  static EdgeInsets onlyTopPadding = EdgeInsets.only(top: paddingValue);

  static BorderRadius customBorderRadiusFormField = BorderRadius.circular(10);

  static DateTime? calendarFirstDate = DateTime(2001, 1, 1);
  static DateTime? calendarLastInfinite = DateTime.now().add(const Duration(days: 365*50));

  static void consoleLog(String s) => log(s);

  static void focusOut(context){  FocusScope.of(context).requestFocus(FocusNode()); }

  static RegExp emailregExp = RegExp(
    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    caseSensitive: true,
    multiLine: false,
  );

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

  static Color colorValue(String colorName){
    Color? finalColor;
    for(var i = 0; i < themeColorList.length; i++) {
      if(themeColorList[i].colorName == colorName) {
        finalColor = themeColorList[i].color;
      }
    }
    return finalColor!;
  }

  static int remainTimeToLive(String fromAPI) {
    int hours = 0;
    String dataDate = DateTime.now().toString();
    if(fromAPI.indexOf('/') > -1){
      dataDate = DateFormat("yyyy-MM-dd kk:mm:ss").format(new DateFormat("MM/dd/yyyy hh:mm:ss").parse(fromAPI));
    }else{
      dataDate = DateFormat("yyyy-MM-dd kk:mm:ss").format(new DateFormat("yyyy-MM-ddTkk:mm:ss").parse(fromAPI));
    }
    final difference = DateTime.now().difference(DateTime.parse(dataDate)).inSeconds;
    if (difference > 0) {
      hours = (difference / 3600).floor();
    }
    return hours;
  }

  static String remainTimeToday(String fromAPI) {
    String remainingTime = "";
    String dataDate = DateTime.now().toString();
    if(fromAPI.indexOf('/') > -1){
      dataDate = DateFormat("yyyy-MM-dd kk:mm:ss").format(new DateFormat("MM/dd/yyyy hh:mm:ss").parse(fromAPI));
    }else{
      dataDate = DateFormat("yyyy-MM-dd kk:mm:ss").format(new DateFormat("yyyy-MM-dd hh:mm:ss").parse(fromAPI.replaceAll('T', ' ').replaceAll('Z', '')));
    }
    final difference = DateTime.now().difference(DateTime.parse(dataDate)).inSeconds;
    if (difference > 0) {
      int days = (difference / 86400).floor();
      int hours = ((difference % 86400).floor() / 3600).floor();
      int mins = (((difference % 86400).floor() % 3600).floor() / 60).floor();
      int rs = (((difference % 86400).floor() % 3600).floor() % 60).floor();

      if (days != 0) {
        remainingTime = "$days days ago";
      } else {
        if (hours != 0)
          remainingTime = "$hours hours ago";
        else if (mins != 0)
          remainingTime = "$mins min ago";
        else
          remainingTime = "$rs sec ago";
      }
    }

    return remainingTime;
  }

}