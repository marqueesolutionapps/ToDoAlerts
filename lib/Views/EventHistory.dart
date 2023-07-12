// ignore_for_file: file_names

part of 'ViewsLibrary.dart';

class EventHistory extends StatefulWidget {
  static const route = '/EventHistory';

  const EventHistory({Key? key}) : super(key: key);

  @override
  State<EventHistory> createState() => _EventHistoryState();
}

class _EventHistoryState extends State<EventHistory> with SingleTickerProviderStateMixin implements GetAllEventDataController, DeleteEventDataController {

  bool isLoading = true, snackBarShowing = false;

  List<AllEventData> allEventData = [];
  Map<String, List<AllEventData>> _upcomingEventData = {};
  Map<String, List<AllEventData>> _completedEventData = {};
  List<String> _dateOfUpcomingEvent = [];
  List<String> _dateOfCompletedEvent = [];


  GetAllEventParent? _getAllEventParent;
  DeleteEventParent? _deleteEventParent;

  _EventHistoryState() {
    _getAllEventParent = GetAllEventParent(this);
    _deleteEventParent = DeleteEventParent(this);
    _getAllEventParent!.loadData();
  }

  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
    _tabController!.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            SizedBox(height: Util.statusBarHeight!),
            Padding(
              padding: Util.paddingAll,
              child: Column(
                children: [
                  CustomText(value: historyTitle, maxLines: 1, fontWeight: 500, fontSize: 22,),
                  CustomText(value: yourToDoListTitle, maxLines: 1, color: subtitleGrey, fontWeight: 500, fontSize: 16,),
                ],
              ),
            ),
            Expanded(
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: Column(
                  children: [
                    TabBar(
                      physics: BouncingScrollPhysics(),
                      controller: _tabController,
                      padding: EdgeInsets.zero,
                      labelPadding: EdgeInsets.zero,
                      indicatorColor: Colors.transparent,
                      tabs: [
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(width: 1, color: _tabController!.index != 0 ? subtitleGrey : primary),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              width: double.infinity,
                              child: CustomText(value: completedTitle, maxLines: 1, fontWeight: 500, color: _tabController!.index == 0 ? primary : themeTextDefaultColor,),
                            ),
                            if(_tabController!.index == 0)
                            Divider(thickness: 2, height: 2, color: primary,)
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(width: 1, color: _tabController!.index != 1 ? subtitleGrey : primary),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                width: double.infinity,
                                child: CustomText(value: upcomingTitle, maxLines: 1, fontWeight: 500, color: _tabController!.index == 1 ? primary : themeTextDefaultColor,)),
                            if(_tabController!.index == 1)
                            Divider(thickness: 2, height: 2, color: primary,)
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        physics: BouncingScrollPhysics(),
                        children: [
                          isLoading == true ? Center(child: CircularProgressIndicator(color: primary,),) :
                          _dateOfCompletedEvent.isEmpty ? Center(child: CustomText(value: "Events Not Available", maxLines: 2, fontWeight: 500, fontSize: 22,),) :
                          SingleChildScrollView(
                            child: MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              child: Padding(
                                padding: Util.leftRightPadding,
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: _dateOfCompletedEvent.length,
                                  itemBuilder: (context, dateIndex) {
                                    String eventDate = _dateOfCompletedEvent[dateIndex];
                                    bool isToday = DateFormat('dd-MM-yyyy').format(DateTime.parse("$eventDate")) == DateFormat('dd-MM-yyyy').format(DateTime.now());
                                    bool isYesterday = DateFormat('dd-MM-yyyy').format(DateTime.parse("$eventDate")) == DateFormat('dd-MM-yyyy').format(DateTime.now().subtract(Duration(days: 1)));
                                    String dateTitle = isToday ? todayTitle : isYesterday ? yesterdayTitle : eventDate;
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomText(value: dateTitle, maxLines: 1, fontWeight: 500, fontSize: 20, color: primary,),
                                        SizedBox(height: 15,),
                                        MediaQuery.removePadding(
                                          context: context,
                                          removeTop: true,
                                          child: ListView.separated(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: _completedEventData[eventDate]!.length,
                                            itemBuilder: (context, eventIndex) {
                                              AllEventData eventDetail = _completedEventData[eventDate]![eventIndex];
                                              return EventCard(
                                                  "${eventDetail.startTime} - ${eventDetail.endTime}",
                                                  eventDetail.eventName!,
                                                  eventDetail.note!,
                                                      (){
                                                    Navigator.of(context).pushNamed(EventDetail.route,
                                                      arguments: EventDetailData(
                                                          data: eventDetail,
                                                          onChangeEvent: () {
                                                            _getAllEventParent!.loadData();
                                                          }
                                                      ),
                                                    );
                                                  },
                                                      (val){
                                                    if(val == delete) {
                                                      _deleteEventParent!.loadData(eventDetail.id!);
                                                    }
                                                    else if(val == edit) {
                                                      eventModel(context, AddEditEvent(eventData: AddEditEventData(data: eventDetail),)).then((value) {
                                                        _getAllEventParent!.loadData();
                                                      });
                                                    }
                                                  }
                                              );
                                            },
                                            separatorBuilder:(BuildContext context, int index){
                                              return SizedBox(height: 10);
                                            },
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                  separatorBuilder:(BuildContext context, int index){
                                    return SizedBox(height: 10);
                                  },
                                ),
                              ),
                            ),
                          ),
                          isLoading == true ? Center(child: CircularProgressIndicator(color: primary,),) :
                          _dateOfUpcomingEvent.isEmpty ? Center(child: CustomText(value: "Events Not Available", maxLines: 2, fontWeight: 500, fontSize: 22,),) :
                          SingleChildScrollView(
                            child: MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              child: Padding(
                                padding: Util.leftRightPadding,
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: _dateOfUpcomingEvent.length,
                                  itemBuilder: (context, dateIndex) {
                                    String eventDate = _dateOfUpcomingEvent[dateIndex];
                                    bool isToday = DateFormat('dd-MM-yyyy').format(DateTime.parse("$eventDate")) == DateFormat('dd-MM-yyyy').format(DateTime.now());
                                    bool isTomorrow = DateFormat('dd-MM-yyyy').format(DateTime.parse("$eventDate")) == DateFormat('dd-MM-yyyy').format(DateTime.now().add(Duration(days: 1)));
                                    String dateTitle = isToday ? todayTitle : isTomorrow ? tomorrowTitle : eventDate;
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomText(value: dateTitle, maxLines: 1, fontWeight: 500, fontSize: 20, color: primary,),
                                        SizedBox(height: 15,),
                                        MediaQuery.removePadding(
                                          context: context,
                                          removeTop: true,
                                          child: ListView.separated(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: _upcomingEventData[eventDate]!.length,
                                            itemBuilder: (context, eventIndex) {
                                              AllEventData eventDetail = _upcomingEventData[eventDate]![eventIndex];
                                              return EventCard(
                                                  "${eventDetail.startTime} - ${eventDetail.endTime}",
                                                  eventDetail.eventName!,
                                                  eventDetail.note!,
                                                      (){
                                                    Navigator.of(context).pushNamed(EventDetail.route,
                                                      arguments: EventDetailData(
                                                          data: eventDetail,
                                                          onChangeEvent: () {
                                                            _getAllEventParent!.loadData();
                                                          }
                                                      ),
                                                    );
                                                  },
                                                      (val){
                                                    if(val == delete) {
                                                      _deleteEventParent!.loadData(eventDetail.id!);
                                                    }
                                                    else if(val == edit) {
                                                      eventModel(context, AddEditEvent(eventData: AddEditEventData(data: eventDetail),)).then((value) {
                                                        _getAllEventParent!.loadData();
                                                      });
                                                    }
                                                  }
                                              );
                                            },
                                            separatorBuilder:(BuildContext context, int index){
                                              return SizedBox(height: 10);
                                            },
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                  separatorBuilder:(BuildContext context, int index){
                                    return SizedBox(height: 10);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: Util.bottomBarHeight! + Util.paddingValue - 10,),
          ],
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
      if(allEventData.isNotEmpty) {
        allEventData.asMap().forEach((index, element) {
          String eventDateTimeString = DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.parse("${allEventData[index].date} ${allEventData[index].endTime}"));
          String currentDateTimeString = DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now());
          DateTime eventDateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(eventDateTimeString);
          DateTime currentDateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(currentDateTimeString);

          if(eventDateTime.isBefore(currentDateTime)) {
            if (!_dateOfCompletedEvent.contains(allEventData[index].date))
              _dateOfCompletedEvent.add(allEventData[index].date!);
          }
          else {
            if (!_dateOfUpcomingEvent.contains(allEventData[index].date))
              _dateOfUpcomingEvent.add(allEventData[index].date!);
          }
        });

        _dateOfCompletedEvent.sort((first, second) {
          var firstDate = "$first $second";
          var secondDate = "$second $second";
          return -firstDate.compareTo(secondDate);
        });

        _dateOfUpcomingEvent.sort((first, second) {
          var firstDate = "$first $second";
          var secondDate = "$second $second";
          return firstDate.compareTo(secondDate);
        });

        _dateOfCompletedEvent.asMap().forEach((key, element) {
          List<AllEventData> tmpList = [];
          allEventData.asMap().forEach((index, element) {
            String eventDateTimeString = DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.parse("${allEventData[index].date} ${allEventData[index].endTime}"));
            String currentDateTimeString = DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now());
            DateTime eventDateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(eventDateTimeString);
            DateTime currentDateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(currentDateTimeString);

            if(eventDateTime.isBefore(currentDateTime)) {
              if(_dateOfCompletedEvent[key] == allEventData[index].date) {
                tmpList.add(allEventData[index]);
              }
            }
          });

          tmpList.sort((first, second) {
            var firstDate = "${first.startTime} ${second.startTime}";
            var secondDate = "${second.startTime} ${second.startTime}";
            return firstDate.compareTo(secondDate);
          });

          _completedEventData.addAll({_dateOfCompletedEvent[key]: tmpList});
        });

        _dateOfUpcomingEvent.asMap().forEach((key, element) {
          List<AllEventData> tmpList = [];
          allEventData.asMap().forEach((index, element) {
            String eventDateTimeString = DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.parse("${allEventData[index].date} ${allEventData[index].endTime}"));
            String currentDateTimeString = DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now());
            DateTime eventDateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(eventDateTimeString);
            DateTime currentDateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(currentDateTimeString);

            if(eventDateTime.isAfter(currentDateTime)) {
              if(_dateOfUpcomingEvent[key] == allEventData[index].date) {
                tmpList.add(allEventData[index]);
              }
            }
          });

          tmpList.sort((first, second) {
            var firstDate = "${first.startTime} ${second.startTime}";
            var secondDate = "${second.startTime} ${second.startTime}";
            return firstDate.compareTo(secondDate);
          });

          _upcomingEventData.addAll({_dateOfUpcomingEvent[key]: tmpList});
        });
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

