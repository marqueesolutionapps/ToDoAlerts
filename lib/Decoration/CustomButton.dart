// ignore_for_file: file_names, non_constant_identifier_names

part of 'DecorationLibrary.dart';

Widget CustomButton(Color backgroundColor, String buttonText) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: CustomText(value: buttonText, maxLines: 1, color: white, fontWeight: 700, fontSize: 20,),
  );
}