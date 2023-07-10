// ignore_for_file: file_names

part of 'ViewsLibrary.dart';

class Home extends StatefulWidget {
  static const route = '/Home';

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String selectedPage = eventCalendarPage;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: scaffoldBackgroundColor,
        key: _scaffoldKey,
        body: Center(
          child: SizedBox(
            width: Util.screenWidth,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  bottom: 0,
                  child: CustomBottomBar(
                    selectedPage == eventNotificationPage || selectedPage == profilePage ? true : false,
                    selectedPage,
                        () {
                      eventModel(context, AddEditEvent()).then((value) {setState(() {});});
                    },
                        () {
                      setState(() {
                        selectedPage = eventCalendarPage;
                      });
                    },
                        () {
                      setState(() {
                        selectedPage = eventHistoryPage;
                      });
                    },
                        () {
                      setState(() {
                        selectedPage = eventNotificationPage;
                      });
                    },
                        () {
                      setState(() {
                        selectedPage = profilePage;
                      });
                    },
                  ),
                ),
                Column(
                  children: [
                    Expanded(
                      child: selectedPage == eventCalendarPage ? EventCalendar() : selectedPage == eventHistoryPage ? EventHistory() : selectedPage == eventNotificationPage ? EventNotification() : Profile(profileData: ProfileData(onThemeChange: () {setState(() {});}),),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}


