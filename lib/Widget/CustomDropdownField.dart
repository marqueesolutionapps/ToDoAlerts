// ignore_for_file: non_constant_identifier_names

part of 'WidgetLibrary.dart';

bool isDropdownOpened = false;
OverlayEntry? floatingDropdown;

class CustomDropDownField extends StatefulWidget {

  final String? selectedCategoryLabel;
  final Widget? dropDownItemValue;

  const CustomDropDownField({
    Key? key,
    required this.selectedCategoryLabel,
    required this.dropDownItemValue,
  }) : super(key: key);

  @override
  State<CustomDropDownField> createState() => _CustomDropDownFieldState();
}

class _CustomDropDownFieldState extends State<CustomDropDownField> {

  GlobalKey? actionKey;
  double? height, width, xPosition, yPosition;


  void findDropdownData() {
    RenderBox? renderBox = actionKey!.currentContext!.findRenderObject() as RenderBox?;
    height = renderBox!.size.height;
    width = renderBox.size.width;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    xPosition = offset.dx;
    yPosition = offset.dy;
  }

  @override
  void initState() {
    actionKey = LabeledGlobalKey(widget.selectedCategoryLabel);
    super.initState();
  }

  OverlayEntry _createFloatingDropdown() {
    return OverlayEntry(builder: (context) {
      return Positioned(
        left: xPosition,
        width: width,
        top: yPosition! + height!,
        height: 5 * height! + 40,
        child: DropDown(
          height!,
          widget.dropDownItemValue!,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: actionKey,
      onTap: () {
        setState(() {
          if (isDropdownOpened) {
            floatingDropdown!.remove();
          } else {
            findDropdownData();
            floatingDropdown = _createFloatingDropdown();
            Overlay.of(context).insert(floatingDropdown!);
          }
          isDropdownOpened = !isDropdownOpened;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: Util.customBorderRadiusFormField,
          color: fillGray,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: <Widget>[
            Expanded(child: CustomText(value: widget.selectedCategoryLabel, fontSize: 16, color: grey, textAlign: TextAlign.start, maxLines: 1,)),
            const SizedBox(width: 10,),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: primary,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}

Widget DropDown(double itemHeight, Widget dropDownItemValue) {
  return Column(
    children: <Widget>[
      const SizedBox(
        height: 5,
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: greyBackgroundShadow,
            ),
            BoxShadow(
              color: fillGray,
              spreadRadius: -5.0,
              blurRadius: 15.0,
            ),
          ],
        ),
        constraints: BoxConstraints(
          maxHeight: 5 * itemHeight,
        ),
        padding: const EdgeInsets.all(10),
        child: dropDownItemValue,
      )
    ],
  );
}

Widget DropDownItem(String itemValue, VoidCallback onChange) {
  return GestureDetector(
    onTap: () {
      onChange.call();
      if (isDropdownOpened) {
        floatingDropdown!.remove();
      }
      isDropdownOpened = !isDropdownOpened;
    },
    child: CustomText(value: itemValue, fontSize: 16, textAlign: TextAlign.start, maxLines: 1, color: grey,),
  );
}



