
// ignore_for_file: file_names, non_constant_identifier_names

part of 'DecorationLibrary.dart';

Widget RateUsDialog(GestureTapCallback onTapNotNow, GestureTapCallback onTapMaybeLater, GestureTapCallback onTapRateUs) {
  return Container(
    height: Util.screenHeight,
    width: Util.screenWidth,
    alignment: Alignment.center,
    padding: Util.paddingAll * 2,
    color: scaffoldBackgroundColor.withOpacity(0.25),
    child: Container(
      padding: Util.paddingAll,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: themeTextDefaultColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: Util.screenWidth! * 0.2,
            width: Util.screenWidth! * 0.2,
            child: SvgPicture.asset(
              appIcon,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(height: 10,),
          CustomText(value: rateThisAppTitle, maxLines: 2, fontSize: 22, fontWeight: 600, color: scaffoldBackgroundColor,),
          const SizedBox(height: 10,),
          const CustomText(value: rateThisAppDescription, maxLines: 10, fontSize: 18, fontWeight: 500, color: subtitleGrey,),
          const SizedBox(height: 20,),
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: onTapNotNow,
                  child: CustomText(
                    value: notNowTitle,
                    maxLines: 2,
                    fontSize: 18,
                    fontWeight: 600,
                    color: primary,
                  ),
                ),
                const SizedBox(height: 10,),
                GestureDetector(
                  onTap: onTapMaybeLater,
                  child: CustomText(
                    value: maybeLaterTitle,
                    maxLines: 2,
                    fontSize: 18,
                    fontWeight: 600,
                    color: primary,
                  ),
                ),
                const SizedBox(height: 10,),
                GestureDetector(
                  onTap: onTapRateUs,
                  child: CustomText(
                    value: rateUsTitle,
                    maxLines: 2,
                    fontSize: 18,
                    fontWeight: 600,
                    color: primary,
                  ),
                ),
              ],
            ),
          ),
          // IntrinsicHeight(
          //   child: Row(
          //     mainAxisSize: MainAxisSize.max,
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       Expanded(
          //         child: GestureDetector(
          //           onTap: () {
          //             setState(() {
          //               Util.isRateUsShow = false;
          //             });
          //           },
          //           child: SimpleContainerWithGradient(
          //             const CustomText(
          //               value: notNowTitle,
          //               maxLines: 2,
          //               fontSize: 18,
          //               fontWeight: 600,
          //               color: white,
          //             ),
          //           ),
          //         ),
          //       ),
          //       const SizedBox(width: 10,),
          //       Expanded(
          //         child: GestureDetector(
          //           onTap: () {
          //             setState(() {
          //               Util.isRateUsShow = false;
          //             });
          //           },
          //           child: SimpleContainerWithGradient(
          //             const CustomText(
          //               value: maybeLaterTitle,
          //               maxLines: 2,
          //               fontSize: 18,
          //               fontWeight: 600,
          //               color: white,
          //             ),
          //           ),
          //         ),
          //       ),
          //       const SizedBox(width: 10,),
          //       Expanded(
          //         child: GestureDetector(
          //           onTap: () {
          //             setState(() {
          //               Util.isRateUsShow = false;
          //             });
          //           },
          //           child: SimpleContainerWithGradient(
          //             const CustomText(
          //               value: rateUsTitle,
          //               maxLines: 2,
          //               fontSize: 18,
          //               fontWeight: 600,
          //               color: white,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    ),
  );
}