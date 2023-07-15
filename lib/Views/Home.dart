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

  bool isDialogComplete = false;
  bool isRateUsShow = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(isDialogComplete == false) {
          if(SPUtil.getRateApply() == false && SPUtil.getRateUsShowingDate().isEmpty) {
            setState(() {
              isRateUsShow = true;
            });
          }
          else if(SPUtil.getRateApply() == false && (SPUtil.getRateUsShowingDate().isNotEmpty && (DateFormat("dd-MM-yyyy").parse(DateFormat('dd-MM-yyyy').format(DateTime.now())).isAfter(DateFormat("dd-MM-yyyy").parse(SPUtil.getRateUsShowingDate())) == true))) {
            setState(() {
              isRateUsShow = true;
            });
          }
          else{
            setState(() {
              isDialogComplete = true;
            });
          }
        }
        return isDialogComplete == false ? false : true;
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
                if(isRateUsShow == true)
                  RateUsDialog(
                        (){
                      setState(() {
                        isDialogComplete = true;
                        isRateUsShow = false;
                      });
                    },
                        (){
                      setState(() {
                        SPUtil.setRateUsShowingDate(DateFormat('dd-MM-yyyy').format(DateTime.now()));
                        isDialogComplete = true;
                        isRateUsShow = false;
                      });
                    },
                        (){
                      setState(() {
                        SPUtil.showRating().then((value) {
                          setState(() {
                            SPUtil.setRateApply(true);
                          });
                        });
                        isDialogComplete = true;
                        isRateUsShow = false;
                      });
                    },
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


