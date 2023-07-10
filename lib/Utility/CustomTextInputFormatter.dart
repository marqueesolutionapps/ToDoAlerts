// ignore_for_file: file_names

part of 'UtilityLibrary.dart';

class CustomTextInputFormat {

  static List<TextInputFormatter> acceptEmail = <TextInputFormatter>[
    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9@.]")),
  ];

  static List<TextInputFormatter> acceptUserName = <TextInputFormatter>[
    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9_]")),
  ];

  static List<TextInputFormatter> acceptPhoneNumber = <TextInputFormatter>[
    FilteringTextInputFormatter.digitsOnly,
    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
    LengthLimitingTextInputFormatter(10),
  ];
}