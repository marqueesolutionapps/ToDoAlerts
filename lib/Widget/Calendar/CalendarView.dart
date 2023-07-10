// ignore_for_file: library_private_types_in_public_api, file_names

part of '../WidgetLibrary.dart';

class CalendarViewPage extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final List<AllEventData>? allEventData;
  final Function? onSelectDate;

  const CalendarViewPage({Key? key, this.scaffoldKey, this.allEventData, this.onSelectDate}) : super(key: key);

  @override
  _CalendarViewPageState createState() => _CalendarViewPageState();
}

class _CalendarViewPageState extends State<CalendarViewPage> {

  DateTime? _currentMonth;
  DateTime? _selectedDateTime;
  DateTime? _todayDate;
  List<Calendar>? _sequentialDates;

  @override
  void initState() {
    super.initState();
    final date = DateTime.now();
    _currentMonth = DateTime(date.year, date.month,);
    _todayDate = DateTime(date.year, date.month, date.day);
    _selectedDateTime = DateTime(date.year, date.month, date.day);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() => _getCalendar());
    });
  }



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          _calendarView(),
        ],
      ),
    );
  }

  Widget _calendarView(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            _toggleBtn(false),
            const SizedBox(width: 10,),
            Expanded(
              child: Column(
                children: [
                  CustomText(value: Util.monthNames[_currentMonth!.month-1], maxLines: 1, fontWeight: 700, fontSize: 22,),
                  SizedBox(height: 5,),
                  CustomText(value: _currentMonth!.year.toString(), maxLines: 1, color: subtitleGrey, fontWeight: 500, fontSize: 16,),
                ],
              ),
            ),
            const SizedBox(width: 10,),
            _toggleBtn(true),
          ],
        ),
        _calendarBody(),
      ],
    );
  }

  Widget _toggleBtn(bool next) {
    return InkWell(
      onTap: (){
        setState(() => (next) ? _getNextMonth() : _getPrevMonth());
      },
      child: (next) ? CustomForwardButton() : CustomBackButton(),
    );
  }

  Widget _calendarBody() {
    if(_sequentialDates == null) return Container();
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: _sequentialDates!.length + 7,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
        ),
        itemBuilder: (context, index){
          if(index < 7) return _weekDayTitle(index);
          bool eventAvailable=false;
          widget.allEventData!.asMap().forEach((key, element) {
            if(element.date == DateFormat('yyyy-MM-dd').format(_sequentialDates![index - 7].date!)) {
              eventAvailable = true;
            }
          });
          return Container(
            decoration: BoxDecoration(
                border: Border(top: BorderSide(color: index - 0 == 7 || index - 1 == 7 || index - 2 == 7 || index - 3 == 7 || index - 4 == 7 || index - 5 == 7 || index - 6 == 7 ? Colors.transparent : subtitleGrey.withOpacity(0.15),)),
            ),
            child: _calendarDates(_sequentialDates![index - 7], eventAvailable),
          );
        },
      ),
    );
  }

  Widget _weekDayTitle(int index){
    return Center(child: CustomText(value: Util.weekDays[index], fontSize: 15, fontWeight: 500, maxLines: 1, color: bottomBarItemAndDayNameColor,));
  }

  Widget _calendarDates(Calendar calendarDate, bool isEventAvailable){
    return InkWell(
      onTap: (){
        if(calendarDate.nextMonth == false && calendarDate.prevMonth == false) {
          if(_selectedDateTime != calendarDate.date){
            setState(() {
              _selectedDateTime = calendarDate.date;
            });
            widget.onSelectDate!.call(DateFormat('yyyy-MM-dd').format(_selectedDateTime!));
          }
        }
      },
      child: Container(
        alignment: Alignment.topCenter,
        color: scaffoldBackgroundColor,
        child:
        calendarDate.nextMonth ==  true || calendarDate.prevMonth == true ?
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 30,
              width: 30,
              padding: EdgeInsets.all(5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: CustomText(value: '${calendarDate.date!.day}', fontSize: 12, fontWeight: 500, maxLines: 1, color: subtitleGrey),
            ),
            CustomRoundMarker(isEventAvailable ? subtitleGrey : Colors.transparent, 5),
            SizedBox(height: 2.5,)
          ],
        ) :
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                height: 30,
                width: 30,
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _selectedDateTime == calendarDate.date ? primary : calendarDate.date==_todayDate? primary.withOpacity(0.25) : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CustomText(
                  value: '${calendarDate.date!.day}',
                  fontSize: 12,
                  fontWeight: 500,
                  maxLines: 1,
                  color: _selectedDateTime == calendarDate.date ? white : calendarDate.date==_todayDate? primary : themeTextDefaultColor,
                ),
            ),
            CustomRoundMarker(isEventAvailable ? primary : Colors.transparent, 5),
            SizedBox(height: 2.5,)
          ],
        ),
      ),
    );
  }

  void _getNextMonth(){
    if(_currentMonth!.month == 12) {
      _currentMonth = DateTime(_currentMonth!.year+1, 1);
    }
    else{
      _currentMonth = DateTime(_currentMonth!.year, _currentMonth!.month+1);
    }
    _getCalendar();
  }

  void _getPrevMonth(){
    if(_currentMonth!.month == 1){
      _currentMonth = DateTime(_currentMonth!.year-1, 12);
    }
    else{
      _currentMonth = DateTime(_currentMonth!.year, _currentMonth!.month-1);
    }
    _getCalendar();
  }

  void _getCalendar(){
    _sequentialDates = CustomCalendarDesign().getMonthCalendar(_currentMonth!.month, _currentMonth!.year, startWeekDay: StartWeekDay.monday);
  }

  @override
  void dispose() {
    super.dispose();
  }
}