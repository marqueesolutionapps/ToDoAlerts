// ignore_for_file: file_names, non_constant_identifier_names, deprecated_member_use

part of 'DecorationLibrary.dart';

Widget CustomBottomBar(bool isShowAddEventButton, String selectedMenu, GestureTapCallback onTapAddEvent, GestureTapCallback onTapEventCalendar, GestureTapCallback onTapEventHistory, GestureTapCallback onTapEventNotification, GestureTapCallback onTapProfile,) {
  return Container(
    width: Util.screenWidth,
    height: Util.bottomBarHeight,
    child: Stack(
      children: [
        CustomPaint(
          size: Size(Util.screenWidth!, Util.bottomBarHeight!),
          painter: CustomBottomNavigationBar(color: bottomBarColor),
        ),
        if(isShowAddEventButton == true)
          AddEventFloatingButton(onTapAddEvent),
        Positioned(
          bottom: 25,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: onTapEventCalendar,
                child: SvgPicture.asset(
                  calendarIcon,
                  height: Util.bottomBarMenuSize,
                  width: Util.bottomBarMenuSize,
                  color: selectedMenu == eventCalendarPage ? primary : bottomBarItemAndDayNameColor,
                  fit: BoxFit.fill,
                ),
              ),
              GestureDetector(
                onTap: onTapEventHistory,
                child: SvgPicture.asset(
                  clockIcon,
                  height: Util.bottomBarMenuSize,
                  width: Util.bottomBarMenuSize,
                  color: selectedMenu == eventHistoryPage ? primary : bottomBarItemAndDayNameColor,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(width: Util.screenWidth! * 0.20,),
              GestureDetector(
                onTap: onTapEventNotification,
                child: SvgPicture.asset(
                  notificationIcon,
                  height: Util.bottomBarMenuSize,
                  width: Util.bottomBarMenuSize,
                  color: selectedMenu == eventNotificationPage ? primary : bottomBarItemAndDayNameColor,
                  fit: BoxFit.fill,
                ),
              ),
              GestureDetector(
                onTap: onTapProfile,
                child: SvgPicture.asset(
                  profileIcon,
                  height: Util.bottomBarMenuSize,
                  width: Util.bottomBarMenuSize,
                  color: selectedMenu == profilePage ? primary : bottomBarItemAndDayNameColor,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget CustomBottomBarOnlyAddEvent(GestureTapCallback onTapAddEvent) {
  return Container(
    width: Util.screenWidth,
    height: Util.bottomBarHeight,
    child: Stack(
      children: [
        SizedBox(
          width: Util.screenWidth!,
          height: Util.bottomBarHeight!,
        ),
        AddEventFloatingButton(onTapAddEvent),
      ],
    ),
  );
}

Widget AddEventFloatingButton(GestureTapCallback onTapAddEvent) {
  return Center(
    heightFactor: 0.75,
    child: FloatingActionButton(
      onPressed: onTapAddEvent,
      backgroundColor: primary,
      child: Icon(
        Icons.add,
        size: Util.bottomBarHeight! / 2,
        color: white,
      ),
      elevation: 5,
    ),
  );
}