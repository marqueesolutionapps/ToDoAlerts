// ignore_for_file: file_names, non_constant_identifier_names

part of 'DecorationLibrary.dart';

Widget CustomBackButton() {
  return Container(
    height: Util.backAndForwardButtonSize,
    width: Util.backAndForwardButtonSize,
    padding: EdgeInsets.all(5),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: scaffoldBackgroundColor,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: backForwardBorder,
        width: 2,
      ),
    ),
    child: Icon(Icons.arrow_back_ios_rounded, color: themeTextDefaultColor, size: 20,),
  );
}

Widget CustomForwardButton() {
  return Container(
    height: Util.backAndForwardButtonSize,
    width: Util.backAndForwardButtonSize,
    padding: EdgeInsets.all(5),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: scaffoldBackgroundColor,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: backForwardBorder,
        width: 2,
      ),
    ),
    child: Icon(Icons.arrow_forward_ios_rounded, color: themeTextDefaultColor, size: 20,),
  );
}