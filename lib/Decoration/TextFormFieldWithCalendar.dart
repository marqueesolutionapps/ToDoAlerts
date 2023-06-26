// ignore_for_file: file_names, non_constant_identifier_names

part of 'DecorationLibrary.dart';

Widget TextFormFieldWithCalendar(TextEditingController controller, double width, String dateValue) {
  return IntrinsicHeight(
    child: Stack(
      children: [
        CustomTextFormField(
            controller: controller,
            readOnly: true,
            isSuffixIcon: true,
        ),
        Container(width: width, color: Colors.transparent,),
        Positioned(
            top: 20,
            right: 20,
            child: CustomText(value: dateValue,fontSize: 18, fontWeight: 600, color: white,)
        ),
      ],
    ),
  );
}