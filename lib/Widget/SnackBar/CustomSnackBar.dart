// ignore_for_file: library_private_types_in_public_api, file_names

part of '../WidgetLibrary.dart';

class CustomSnackBar{

  static Widget success(String snackBarMessage) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: primary,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          // boxShadow: [
          //   BoxShadow(
          //     color: primary,
          //     offset: Offset(0.0, 4.0),
          //     spreadRadius: 0.2,
          //     blurRadius: 10,
          //   ),
          // ],
        ),
        child: Row(
          children: [
            Icon(
              Icons.check,
              color: white,
              size: 25,
            ),
            const SizedBox(width: 10,),
            Flexible(
              child: CustomText(
                value: snackBarMessage,
                textAlign: TextAlign.start,
                fontWeight: 600,
                fontSize: 16,
                maxLines: 2,
                color: white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget error(String snackBarMessage) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: errorColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          // boxShadow: [
          //   BoxShadow(
          //     color: errorColor,
          //     offset: Offset(0.0, 4.0),
          //     spreadRadius: 0.2,
          //     blurRadius: 10,
          //   ),
          // ],
        ),
        child: Row(
          children: [
            Icon(
              Icons.error_outline,
              color: white,
              size: 25,
            ),
            const SizedBox(width: 10,),
            Flexible(
              child: CustomText(
                value: snackBarMessage,
                textAlign: TextAlign.start,
                fontWeight: 600,
                fontSize: 16,
                maxLines: 2,
                color: white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}