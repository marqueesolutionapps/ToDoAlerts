// ignore_for_file: file_names, non_constant_identifier_names

part of 'DecorationLibrary.dart';

Widget CustomRoundMarker(Color backgroundColor, double size) {
  return Container(
    height: size,
    width: size,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: backgroundColor,
    ),
    child: Container(
      height: size / 2,
      width: size / 2,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: scaffoldBackgroundColor,
      ),
    ),
  );
}