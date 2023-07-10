// ignore_for_file: file_names, non_constant_identifier_names

part of 'DecorationLibrary.dart';

Future<void> eventModel(BuildContext _context, Widget child) async {
  return await showModalBottomSheet<void>(
    context: _context,
    isScrollControlled: true,
    backgroundColor: cardAndDialogBackgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    builder: (context) => SafeArea(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: Util.screenHeight! * 0.85,
        ),
        child: child,
      ),
    ),
  );
}