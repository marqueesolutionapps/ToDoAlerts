// ignore_for_file: file_names

part of 'ViewsLibrary.dart';

class EventNotification extends StatefulWidget {
  static const route = '/EventNotification';

  const EventNotification({Key? key}) : super(key: key);

  @override
  State<EventNotification> createState() => _EventNotificationState();
}

class _EventNotificationState extends State<EventNotification> {

  List<NotificationHistory> listData24 = [];
  List<NotificationHistory> listData48 = [];
  List<NotificationHistory> listData = [];

  final dbHelper = DatabaseHelper.instance;
  List listIDToDelete = [];

  bool isLoading = false;

  @override
  void initState() {
    printAllRecord();
    super.initState();
  }

  Future<void> printAllRecord() async {
    setState(() {
      isLoading = true;
      listData.clear();
      listData24.clear();
      listData48.clear();
    });
    var res = await dbHelper.queryAll();
    List cmpData = res.map((item) => new NotificationHistory.fromJson(item)).toList();
    setState(() {
      for (var items in cmpData) {
        int time = Util.remainTimeToLive(items.timestamp);
        if (time <= 24) {
          listData24.add(items);
        } else if (time > 24 && time <= 48) {
          listData48.add(items);
        } else {
          listData.add(items);
        }
      }
    });
    if (listData.length == 0 &&
        listData24.length == 0 &&
        listData48.length == 0) {
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        listData24 = listData24.reversed.toList();
        listData48 = listData48.reversed.toList();
        listData = listData.reversed.toList();
        isLoading = false;
      });
    }
  }

  Future<void> clearAllNotificationRecord() async {
    FlutterAppBadger.updateBadgeCount(0);
    await SPUtil.setBadgeCount(0);
    FlutterAppBadger.removeBadge();
    await dbHelper.deleteAllRecord();
    printAllRecord();
  }

  Future<bool?> updateStatus(int element, String notificationTitle, int isNew) async {
    if (isNew == 1){
      Map<String, dynamic> objectData = {
        DatabaseHelper.notificationColumnStatus: 0
      };
      var res = await dbHelper.updateStatus(element, objectData);
      if (res == 1) {
        int count = SPUtil.getBadgeCount() ?? 0;
        if(count - 1 <= 0){
          await SPUtil.setBadgeCount(0);
          FlutterAppBadger.removeBadge();
        }else{
          FlutterAppBadger.updateBadgeCount(count - 1);
          await SPUtil.setBadgeCount(count - 1);
        }
      }
    }

    printAllRecord();
    return null;
  }

  Future<bool?> deleteRecord(int element) async {
    var res = await dbHelper.deleteRecord(element);
    if (res == 1) {
      printAllRecord();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Util.paddingAll,
      child: Column(
        children: [
          SizedBox(height: Util.statusBarHeight!),
          Row(
            children: [
              Icon(
                Icons.delete,
                color: Colors.transparent,
                size: 32,
              ),
              SizedBox(width: 10,),
              Expanded(
                child: Column(
                  children: [
                    CustomText(value: notificationTitle, maxLines: 1, fontWeight: 500, fontSize: 22,),
                    CustomText(value: yourToDoListTitle, maxLines: 1, color: subtitleGrey, fontWeight: 500, fontSize: 16,),
                  ],
                ),
              ),
              SizedBox(width: 10,),
              GestureDetector(
                onTap: () {
                  if(listData.length != 0 || listData24.length != 0 || listData48.length != 0)
                  setState(() {
                    clearAllNotificationRecord();
                  });
                },
                child: Icon(
                  Icons.delete,
                  color: listData.length == 0 && listData24.length == 0 && listData48.length == 0 ? Colors.transparent :  primary,
                  size: 32,
                ),
              ),
            ],
          ),
          SizedBox(height: 25,),
          Expanded(
            child: Stack(
              children: [
                isLoading == true ? Center(child: CircularProgressIndicator(color: primary,),) :
                listData.length == 0 && listData24.length == 0 && listData48.length == 0 ? Center(child: CustomText(value: "No Notifications", maxLines: 2, fontWeight: 500, fontSize: 22,),) :
                SingleChildScrollView(
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (listData24.length > 0)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(value: todayTitle, maxLines: 1, fontWeight: 500, fontSize: 20, color: primary,),
                              SizedBox(height: 15,),
                            ],
                          ),
                        if (listData24.length > 0)
                        MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: listData24.length,
                            itemBuilder: (context, index) {
                              return _notificationCardDesign(
                                  listData24[index].title!,
                                  listData24[index].body!,
                                  Util.remainTimeToday(listData24[index].timestamp!).toString(),
                                  listData24[index].status ?? 0,
                                  listData24[index].id!);
                            },
                            separatorBuilder:(BuildContext context, int index){
                              return const SizedBox(height: 10,);
                            },
                          ),
                        ),
                        if (listData48.length > 0)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(value: yesterdayTitle, maxLines: 1, fontWeight: 500, fontSize: 20, color: primary,),
                              SizedBox(height: 15,),
                            ],
                          ),
                        if (listData48.length > 0)
                          MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: listData48.length,
                              itemBuilder: (context, index) {
                                return _notificationCardDesign(
                                    listData48[index].title!,
                                    listData48[index].body!,
                                    Util.remainTimeToday(listData48[index].timestamp!).toString(),
                                    listData48[index].status ?? 0,
                                    listData48[index].id!);
                              },
                              separatorBuilder:(BuildContext context, int index){
                                return const SizedBox(height: 10,);
                              },
                            ),
                          ),
                        if (listData.length > 0)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(value: olderTitle, maxLines: 1, fontWeight: 500, fontSize: 20, color: primary,),
                              SizedBox(height: 15,),
                            ],
                          ),
                        if (listData.length > 0)
                          MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: listData.length,
                              itemBuilder: (context, index) {
                                return _notificationCardDesign(
                                    listData[index].title!,
                                    listData[index].body!,
                                    Util.remainTimeToday(listData[index].timestamp!).toString(),
                                    listData[index].status ?? 0,
                                    listData[index].id!);
                              },
                              separatorBuilder:(BuildContext context, int index){
                                return const SizedBox(height: 10,);
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          printAllRecord();
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(50)),
                        child: Icon(
                          Icons.refresh,
                          color: white,
                          size: 32,
                        ),
                      ),
                    )
                ),
              ],
            ),
          ),
          SizedBox(height: Util.bottomBarHeight,),
        ],
      ),
    );
  }

  Widget _notificationCardDesign(String title, String desc, String timeAway, int isNew, int id) {
    return GestureDetector(
      onTap: () {
        if(isNew == 1){
          updateStatus(id, title, isNew);
        }
      },
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
            if(isNew == 1)
              SizedBox(height: 12,),
            Row(
              children: [
                CustomRoundMarker(primary, 15),
                SizedBox(width: 10,),
                Expanded(child: CustomText(value: timeAway, maxLines: 1, color: subtitleGrey, fontSize: 12, fontWeight: 600, textAlign: TextAlign.start,),),
                SizedBox(width: 10,),
                isNew == 1 ? Container(
                  decoration: BoxDecoration(
                      color: primary, borderRadius: BorderRadius.circular(50),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: CustomText(value: "new", maxLines: 1, fontWeight: 500, fontSize: 14, color: Colors.black, height: 1,),
                ) :
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
                    return const [
                      PopupMenuItem<String>(
                        value: delete,
                        height: 35,
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        child: Center(child: CustomText(value: delete, maxLines: 1, fontSize: 14, color: white, fontWeight: 700,),),
                      ),
                    ];
                  },
                  onSelected:(value){
                    deleteRecord(id);
                  },
                ),
              ],
            ),
            if(isNew == 1)
              SizedBox(height: 10,),
            CustomText(value: title, maxLines: 2, fontSize: 15, fontWeight: 600, textAlign: TextAlign.start,),
            SizedBox(height: 12,),
            CustomText(value: desc, maxLines: 5, color: subtitleGrey, fontSize: 14, fontWeight: 400, textAlign: TextAlign.start,),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

