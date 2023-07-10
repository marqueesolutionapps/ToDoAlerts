// ignore_for_file: file_names, non_constant_identifier_names

part of 'DecorationLibrary.dart';

Widget CustomColorButton(bool isSelected, Color color) {
  return Container(
    height: 50,
    width: 50,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: fillGray,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(width: isSelected ? 2 : 0, color: isSelected ? color : Colors.transparent)
    ),
    child: Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
          color: white,
      ),
      alignment: Alignment.center,
      child:  Container(
        height: 25,
        width: 25,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    ),
  );
}