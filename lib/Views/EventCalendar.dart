// ignore_for_file: file_names

part of 'ViewsLibrary.dart';

class EventCalendar extends StatefulWidget {
  static const route = '/EventCalendar';

  const EventCalendar({Key? key}) : super(key: key);

  @override
  State<EventCalendar> createState() => _EventCalendarState();
}

class _EventCalendarState extends State<EventCalendar> implements GetAllEventDataController, DeleteEventDataController {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLoading = true, snackBarShowing = false;

  List<AllEventData> allEventData = [];

  String selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  GetAllEventParent? _getAllEventParent;
  DeleteEventParent? _deleteEventParent;

  _EventCalendarState() {
    _getAllEventParent = GetAllEventParent(this);
    _deleteEventParent = DeleteEventParent(this);
    _getAllEventParent!.loadData();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: Util.paddingAll,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Util.statusBarHeight!),
              CalendarViewPage(
                scaffoldKey: _scaffoldKey,
                allEventData: allEventData,
                onSelectDate: (val){
                  setState(() {
                    selectedDate = val;
                  });
                },
              ),
              SizedBox(height: 10,),
              isLoading == true ? Center(child: CircularProgressIndicator(color: primary,)) :
              Expanded(
                child: SingleChildScrollView(
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: allEventData.length,
                      itemBuilder: (context, index) {
                        return allEventData[index].date == selectedDate
                            ? EventCard(
                            "${allEventData[index].startTime} - ${allEventData[index].endTime}",
                            allEventData[index].eventName!,
                            allEventData[index].note!,
                                (){
                                  Navigator.of(context).pushNamed(EventDetail.route,
                                    arguments: EventDetailData(
                                      data: allEventData[index],
                                      onChangeEvent: () {
                                        _getAllEventParent!.loadData();
                                      }
                                    ),
                                  );
                            },
                                (val){
                              if(val == delete) {
                                _deleteEventParent!.loadData(allEventData[index].id!);
                              }
                              else if(val == edit) {
                                eventModel(context, AddEditEvent(eventData: AddEditEventData(data: allEventData[index]),)).then((value) {
                                  _getAllEventParent!.loadData();
                                });
                              }
                            }
                        )
                            : SizedBox();
                      },
                      separatorBuilder:(BuildContext context, int index){
                        return SizedBox(height: allEventData[index].date == selectedDate ? 10 : 0,);
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: Util.bottomBarHeight! - 10,),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: CustomBottomBarOnlyAddEvent(
              (){
                eventModel(context, AddEditEvent()).then((value) {
                  _getAllEventParent!.loadData();
                });
              },
          ),
        ),
      ],
    );
  }

  void snackBarFun(bool isSuccess,String message) {
    if (!snackBarShowing) {
      snackBarShowing = true;
      showTopSnackBar(context, isSuccess == true ? CustomSnackBar.success(message) : CustomSnackBar.error(message));
      Future.delayed( const Duration(milliseconds: 1500), () {
        setState(() {
          snackBarShowing = false;
          isLoading = false;
        });
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onLoadGetAllEventConnection(connection) {
    snackBarFun(false, connection);
  }

  @override
  void onLoadGetAllEventError(CommonMessageModel items) {
    snackBarFun(false, items.messages!);
  }

  @override
  void onLoadGetAllEventSuccess(GetAllEventModel item) {
    setState(() {
      isLoading = false;
      snackBarShowing = false;
      allEventData.clear();
      if(item.data != null && item.data!.isNotEmpty) {
        if(mounted) {
          setState(() {
            item.data!.asMap().forEach((index, element) {
              allEventData.add(item.data![index]);
            });
          });
        }
      }
    });
  }

  @override
  void onLoadDeleteEventConnection(connection) {
    snackBarFun(false, connection);
  }

  @override
  void onLoadDeleteEventError(CommonMessageModel items) {
    snackBarFun(false, items.messages!);
  }

  @override
  void onLoadDeleteEventSuccess(DeleteEventModel item) {
    snackBarFun(true, item.messages!);
    _getAllEventParent!.loadData();
  }
}

