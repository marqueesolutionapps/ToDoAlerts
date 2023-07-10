// ignore_for_file: file_names, non_constant_identifier_names

part of 'DecorationLibrary.dart';

Future<DateTime?> CustomDatePicker(BuildContext context, DateTime initialDate) {
  return showDatePicker(
    initialEntryMode: DatePickerEntryMode.calendarOnly,
      context: context,
      initialDate: initialDate,
      firstDate: Util.calendarFirstDate!,
      lastDate: Util.calendarLastInfinite!,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
                primary: primary,
                onPrimary: white,
                onSurface: primary
            ),
            dialogBackgroundColor: white,
          ),
          child: child!,
        );
      }
  );
}

Future<TimeOfDay?> CustomTimePicker(BuildContext context, TimeOfDay initialTime) {
  return showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
                primary: primary,
                onPrimary: white,
                onSurface: primary
            ),
            dialogBackgroundColor: white,
          ),
          child: child!,
        );
      }
  );
}