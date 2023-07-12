// ignore_for_file: file_names

part of 'ViewsLibrary.dart';

class EventDetailData {
  final AllEventData? data;
  final VoidCallback? onChangeEvent;
  EventDetailData({required this.data, this.onChangeEvent});
}

class EventDetail extends StatefulWidget {
  static const route = '/EventDetail';

  final EventDetailData? eventData;
  const EventDetail({Key? key, required this.eventData}) : super(key: key);

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
                Padding(
                  padding: Util.paddingAll,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Util.statusBarHeight!),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: CustomBackButton(),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                CustomText(value: DateFormat('MMMM').format(DateTime.parse(widget.eventData!.data!.date!)), maxLines: 1, fontWeight: 700, fontSize: 22,),
                                SizedBox(height: 5,),
                                CustomText(value: DateFormat('yyyy').format(DateTime.parse(widget.eventData!.data!.date!)), maxLines: 1, color: subtitleGrey, fontWeight: 500, fontSize: 16,),
                              ],
                            ),
                          ),
                          SizedBox(width: Util.backAndForwardButtonSize,),
                        ],
                      ),
                      SizedBox(height: 25,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CategoryButton(Colors.transparent, Util.colorValue(widget.eventData!.data!.categoryColor!).withOpacity(0.25), Util.colorValue(widget.eventData!.data!.categoryColor!), widget.eventData!.data!.categoryName!, 18),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomRoundMarker(primary, 10),
                                SizedBox(width: 7.5,),
                                Flexible(child: CustomText(value: "${widget.eventData!.data!.startTime!}-${widget.eventData!.data!.endTime!}", maxLines: 2, color: subtitleGrey, fontSize: 16, fontWeight: 600, textAlign: TextAlign.end,)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      CustomText(value: widget.eventData!.data!.eventName!, maxLines: 100, fontSize: 20, fontWeight: 700, textAlign: TextAlign.start,),
                      SizedBox(height: 20,),
                      Expanded(
                        child: SingleChildScrollView(
                          child: CustomText(value: widget.eventData!.data!.note!, maxLines: 500, color: subtitleGrey, fontSize: 16, fontWeight: 700, textAlign: TextAlign.start,),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          eventModel(context, AddEditEvent(eventData: AddEditEventData(data: widget.eventData!.data!),),).then((value) {
                            widget.eventData!.onChangeEvent!.call();
                            Navigator.of(context).pop();
                          });
                        },
                        child: CustomButton(
                          primary,
                          updateEventTitle,
                        ),
                      ),
                    ],
                  ),
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

