// ignore_for_file: file_names, non_constant_identifier_names

part of 'DecorationLibrary.dart';

Widget CategoryButton(Color borderColor, Color backgroundColor, Color markerColor, String buttonText, double fontSize) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(width: 2, color: borderColor)
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomRoundMarker(markerColor, 15),
        SizedBox(width: 7.5,),
        CustomText(value: buttonText, maxLines: 1, fontWeight: 700, fontSize: fontSize, height: 1,),
      ],
    ),
  );
}