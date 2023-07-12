// ignore_for_file: file_names, non_constant_identifier_names

part of 'DecorationLibrary.dart';

Widget EventCard(String time, String eventTitle, String eventDescription, GestureTapCallback onTapCard, Function onTap,) {
  return GestureDetector(
    onTap: onTapCard,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: cardAndDialogBackgroundColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: SPUtil.getTheme() == lightTheme ? cardBorder : Colors.transparent,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomRoundMarker(primary, 10),
              SizedBox(width: 10,),
              Expanded(child: CustomText(value: time, maxLines: 1, color: subtitleGrey, fontSize: 12, fontWeight: 600, textAlign: TextAlign.start,),),
              SizedBox(width: 10,),
              PopupMenuButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                ),
                icon: const Icon(
                  Icons.more_horiz_rounded, color: subtitleGrey, size: 26,
                ),
                color: primary,
                position: PopupMenuPosition.under,
                padding: EdgeInsets.symmetric(vertical: 0),
                itemBuilder: (context) {
                  return eventOperation.map((value) {
                    return PopupMenuItem<String>(
                      value: value,
                      height: 35,
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      child: Center(child: CustomText(value: value, maxLines: 1, fontSize: 14, color: white, fontWeight: 700,),),
                    );
                  }).toList();
                },
                onSelected:(value){
                  onTap.call(value);
                },
              ),
            ],
          ),
          CustomText(value: eventTitle, maxLines: 1, fontSize: 15, fontWeight: 600, textAlign: TextAlign.start,),
          SizedBox(height: 5,),
          CustomText(value: eventDescription, maxLines: 1, color: subtitleGrey, fontSize: 14, fontWeight: 400, textAlign: TextAlign.start,),
        ],
      ),
    ),
  );
}