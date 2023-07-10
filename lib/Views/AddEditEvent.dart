// ignore_for_file: file_names

part of 'ViewsLibrary.dart';

class AddEditEventData {
  final AllEventData? data;
  AddEditEventData({required this.data,});
}

class AddEditEvent extends StatefulWidget {
  static const route = '/AddEditEvent';

  final AddEditEventData? eventData;
  AddEditEvent({Key? key, this.eventData}) : super(key: key);

  @override
  State<AddEditEvent> createState() => _AddEditEventState();
}

class _AddEditEventState extends State<AddEditEvent> implements GetAllCategoryDataController, AddCategoryDataController, AddEditEventDataController {

  final _formKey = GlobalKey<FormState>();
  final _formKeyForCategory = GlobalKey<FormState>();

  DateTime? date, startTime, endTime;

  TextEditingController? eventNameCTRL, noteCTRL, dateCTRL, startTimeCTRL, endTimeCTRL, categoryNameCTRL;

  List<AllCategoryData> allCategoryData = [];

  String categoryColor = themeColorList[0].colorName;
  String? selectedCategory;

  bool isLoading = false, snackBarShowing = false, isLoadingCategory = true, isAddCategory = false, isTimeValidate = false;
  bool? isRemindMe;

  GetAllCategoryParent? _getAllCategoryParent;
  AddCategoryParent? _addCategoryParent;
  AddEditEventParent? _addEditEventParent;

  _AddEditEventState() {
    _getAllCategoryParent = GetAllCategoryParent(this);
    _addCategoryParent = AddCategoryParent(this);
    _addEditEventParent = AddEditEventParent(this);
    _getAllCategoryParent!.loadData();
  }

  @override
  void initState() {
    assignVariableValue();
    super.initState();
  }

  assignVariableValue() {
    if(widget.eventData != null) {
      setState(() {
        date = DateTime.parse(widget.eventData!.data!.date!);
        startTime = DateTime.parse("${widget.eventData!.data!.date!} ${widget.eventData!.data!.startTime!}");
        endTime = DateTime.parse("${widget.eventData!.data!.date!} ${widget.eventData!.data!.endTime!}");
        eventNameCTRL = TextEditingController(text: widget.eventData!.data!.eventName!);
        noteCTRL = TextEditingController(text: widget.eventData!.data!.note!);
        isRemindMe = widget.eventData!.data!.remindMe == "1" ? true : false;
        selectedCategory = widget.eventData!.data!.categoryId!;
        categoryNameCTRL = TextEditingController(text: "");
        dateCTRL = TextEditingController(text: DateFormat('dd-MM-yyyy').format(date!));
        startTimeCTRL = TextEditingController(text: DateFormat("hh:mm a").format(startTime!));
        endTimeCTRL = TextEditingController(text: DateFormat("hh:mm a").format(endTime!));
      });
    }
    else {
      setState(() {
        date = DateTime.now();
        startTime = DateTime(date!.year, date!.month, date!.day, date!.hour, date!.minute, 00);
        endTime = startTime!.add(Duration(minutes: 30));
        eventNameCTRL = TextEditingController(text: "");
        categoryNameCTRL = TextEditingController(text: "");
        noteCTRL = TextEditingController(text: "");
        dateCTRL = TextEditingController(text: DateFormat('dd-MM-yyyy').format(date!));
        startTimeCTRL = TextEditingController(text: DateFormat("hh:mm a").format(startTime!));
        endTimeCTRL = TextEditingController(text: DateFormat("hh:mm a").format(endTime!));
        isRemindMe = false;
        selectedCategory = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: Util.paddingAll,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(child: CustomText(value: widget.eventData != null ? "$edit $eventTitle" : "$addNewTitle $eventTitle", maxLines: 2, fontWeight: 700, fontSize: 22,)),
              SizedBox(height: 20,),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextFormField(
                              isBorder: true,
                              isModelField: true,
                              controller: eventNameCTRL,
                              hintText: "Event Name*",
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.multiline,
                              onTapOutside: (val) => Util.focusOut(context),
                              fillColor: cardAndDialogBackgroundColor,
                              validator: (input) {
                                if (input!.isEmpty) {
                                  return "Please enter event name.";
                                }
                                else if(input.trim().isEmpty) {
                                  return "Only White Space Not Allowed";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15,),
                            CustomTextFormField(
                              isBorder: true,
                              minLines: 4,
                              maxLines: 4,
                              isModelField: true,
                              controller: noteCTRL,
                              hintText: "Type the the note here...",
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.multiline,
                              onTapOutside: (val) => Util.focusOut(context),
                              fillColor: cardAndDialogBackgroundColor,
                              validator: (input) {
                                if (input!.isEmpty) {
                                  return "Please enter note.";
                                }
                                else if(input.trim().isEmpty) {
                                  return "Only White Space Not Allowed";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15,),
                            GestureDetector(
                              onTap: () {
                                if(isLoading == false) {
                                  _selectDate(context);
                                }
                              },
                              child: Stack(
                                children: [
                                  CustomTextFormField(
                                    isBorder: true,
                                    readOnly: true,
                                    isModelField: true,
                                    controller: dateCTRL,
                                    hintText: "Date",
                                    isSuffixIcon: true,
                                    icon: calendarIcon,
                                    textAlign: TextAlign.start,
                                    keyboardType: TextInputType.multiline,
                                    onTapOutside: (val) => Util.focusOut(context),
                                    fillColor: cardAndDialogBackgroundColor,
                                    validator: (input) {
                                      if (input!.isEmpty) {
                                        return "Please select Date";
                                      }
                                      return null;
                                    },
                                  ),
                                  Positioned.fill(
                                    child: Container(color: Colors.transparent,),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      if(isLoading == false) {
                                        selectStartTime(context);
                                      }
                                    },
                                    child: Stack(
                                      children: [
                                        CustomTextFormField(
                                          isBorder: true,
                                          readOnly: true,
                                          isModelField: true,
                                          controller: startTimeCTRL,
                                          hintText: "Start",
                                          isSuffixIcon: true,
                                          icon: clockIcon,
                                          textAlign: TextAlign.start,
                                          keyboardType: TextInputType.multiline,
                                          onTapOutside: (val) => Util.focusOut(context),
                                          fillColor: cardAndDialogBackgroundColor,
                                        ),
                                        Positioned.fill(
                                          child: Container(color: Colors.transparent,),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      if(isLoading == false) {
                                        selectEndTime(context);
                                      }
                                    },
                                    child: Stack(
                                      children: [
                                        CustomTextFormField(
                                          isBorder: true,
                                          readOnly: true,
                                          isModelField: true,
                                          controller: endTimeCTRL,
                                          hintText: "End",
                                          isSuffixIcon: true,
                                          icon: clockIcon,
                                          textAlign: TextAlign.start,
                                          keyboardType: TextInputType.multiline,
                                          onTapOutside: (val) => Util.focusOut(context),
                                          fillColor: cardAndDialogBackgroundColor,
                                        ),
                                        Positioned.fill(
                                          child: Container(color: Colors.transparent,),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if(isTimeValidate == true)
                            SizedBox(height: 10,),
                            if(isTimeValidate == true)
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: const CustomText(value: "End time is shorter than start time", maxLines: 2, fontWeight: 500, fontSize: 14, color: errorColor,),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Expanded(child: const CustomText(value: remindsMeTitle, maxLines: 2, fontWeight: 700, fontSize: 18, textAlign: TextAlign.start,)),
                          FlutterSwitch(
                            value: isRemindMe!,
                            height: 30,
                            inactiveColor:/* SPUtil.getTheme() == lightTheme ? */subtitleGrey/* : black*/,
                            activeColor: primary,
                            onToggle: (val) {
                              setState(() {
                                isRemindMe = val;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      const CustomText(value: "$selectTitle $categoryTitle", maxLines: 2, fontWeight: 700, fontSize: 20,),
                      SizedBox(height: 20,),
                      isLoadingCategory == true ? Center(child: CircularProgressIndicator(color: primary,)) :
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if(allCategoryData.isNotEmpty)
                          Wrap(
                            runSpacing: 10,
                            spacing: 10,
                            children: [
                              for(var i = 0; i < allCategoryData.length; i++)
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedCategory = allCategoryData[i].id!;
                                    });
                                  },
                                  child: CategoryButton(
                                    selectedCategory == allCategoryData[i].id! ? Util.colorValue(allCategoryData[i].categoryColor!) : Colors.transparent,
                                    primary.withOpacity(0.15),
                                    Util.colorValue(allCategoryData[i].categoryColor!),
                                    allCategoryData[i].categoryName!,
                                    18,
                                  ),
                                ),
                            ],
                          ),
                          if(allCategoryData.isNotEmpty)
                          SizedBox(height: 20,),
                          GestureDetector(
                            onTap: () {
                              if(isLoading == false)
                              setState(() {
                                isAddCategory = true;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.add, color: isLoading == false ? primary : primary.withOpacity(0.5),),
                                SizedBox(width: 7.5,),
                                CustomText(value: addNewTitle, maxLines: 2, fontWeight: 700, fontSize: 16, color: isLoading == false ? primary : primary.withOpacity(0.5),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              isLoading == true ? Center(child: CircularProgressIndicator(color: primary,)) : GestureDetector(
                onTap: () {
                  if(isLoadingCategory == false)
                  createEvent();
                },
                child: CustomButton(
                  isLoadingCategory == true ? primary.withOpacity(0.5) : primary,
                  widget.eventData != null ? updateEventTitle : createEventTitle,
                ),
              ),
            ],
          ),
        ),
        if(isAddCategory == true)
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            color: black.withOpacity(0.5),
          ),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Padding(
                    padding: Util.paddingAll,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0),),
                        color: cardAndDialogBackgroundColor,
                      ),
                      // padding: Util.paddingAll,
                      child: Form(
                        key: _formKeyForCategory,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: Util.paddingAll,
                              child: Row(
                                children: [
                                  Icon(Icons.cancel_outlined, color: Colors.transparent, size: 25,),
                                  SizedBox(width: 7.5,),
                                  Expanded(child: Center(child: CustomText(value: "$addNewTitle $categoryTitle", maxLines: 2, fontWeight: 700, fontSize: 20, textAlign: TextAlign.center,))),
                                  SizedBox(width: 7.5,),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        categoryNameCTRL = TextEditingController(text: "");
                                        categoryColor = themeColorList[0].colorName;
                                        isAddCategory = false;
                                      });
                                    },
                                    child: Icon(Icons.cancel_outlined, color: primary, size: 25,),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20) + Util.leftRightPadding,
                              child: CustomText(value: "$categoryTitle $nameTitle", maxLines: 1, textAlign: TextAlign.start,),
                            ),
                            SizedBox(height: 10,),
                            Padding(
                              padding: Util.leftRightPadding,
                              child: CustomTextFormField(
                                isBorder: true,
                                isModelField: true,
                                controller: categoryNameCTRL,
                                hintText: "$enterYour $categoryTitle",
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.multiline,
                                onTapOutside: (val) => Util.focusOut(context),
                                fillColor: cardAndDialogBackgroundColor,
                                validator: (input) {
                                  if (input!.isEmpty) {
                                    return "Please enter Category Name.";
                                  }
                                  else if(input.trim().isEmpty) {
                                    return "Only White Space Not Allowed";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20) + Util.leftRightPadding,
                              child: CustomText(value: "Choose Color", maxLines: 1, textAlign: TextAlign.start,),
                            ),
                            SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    for(var i=0 ; i < themeColorList.length ; i++)
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                categoryColor = themeColorList[i].colorName;
                                              });
                                            },
                                            child: CustomColorButton(
                                              categoryColor == themeColorList[i].colorName ? true : false,
                                              themeColorList[i].color,
                                            ),
                                          ),
                                          SizedBox(width: i < themeColorList.length - 1 ? 10 : 0,)
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: Util.paddingAll,
                              child: GestureDetector(
                                  onTap: () {
                                    saveCategory();
                                  },
                                  child: CustomButton(
                                    primary,
                                    saveTitle,
                                  ),
                                ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Util.screenHeight! * 0.15,)
            ],
          ),
        )
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {

    final DateTime? pickedDate = await CustomDatePicker(context, date!);
    if (pickedDate != null && pickedDate != date){
      setState(() {
        date = pickedDate;
        dateCTRL = TextEditingController(text: DateFormat('dd-MM-yyyy').format(date!));
      });
    }
  }

  Future<void> selectStartTime (BuildContext context) async {

    final TimeOfDay? pickedStartTime = await CustomTimePicker(context, TimeOfDay(hour: startTime!.hour, minute: startTime!.minute));

    if(pickedStartTime != null) {
      setState(() {
        startTime = DateTime(date!.year, date!.month, date!.day, pickedStartTime.hour, pickedStartTime.minute, 00);
        startTimeCTRL = TextEditingController(text: DateFormat("hh:mm a").format(startTime!));
      });
    }
  }

  Future<void> selectEndTime (BuildContext context) async {

    final TimeOfDay? pickedEndTime = await CustomTimePicker(context, TimeOfDay(hour: endTime!.hour, minute: endTime!.minute));

    if(pickedEndTime != null) {
      setState(() {
        endTime = DateTime(date!.year, date!.month, date!.day, pickedEndTime.hour, pickedEndTime.minute, 00);
        endTimeCTRL = TextEditingController(text: DateFormat("hh:mm a").format(endTime!));
      });
    }
  }

  void createEvent() {
    final formState = _formKey.currentState;
    if(formState!.validate() && startTime!.isBefore(endTime!)) {
      setState(() {
        isTimeValidate = false;
        isLoading = true;
      });
      _addEditEventParent!.loadData(widget.eventData != null ? widget.eventData!.data!.id! : "", eventNameCTRL!.text, noteCTRL!.text, DateFormat('yyyy-MM-dd').format(date!), DateFormat("HH:mm:ss").format(startTime!), DateFormat("HH:mm:ss").format(endTime!), isRemindMe!, selectedCategory!);
    }
    else if(startTime!.isAfter(endTime!)) {
      setState(() {
        isTimeValidate = true;
      });
    }
    else {
      setState(() {
        isTimeValidate = false;
      });
    }
  }

  void saveCategory() {
    final formState = _formKeyForCategory.currentState;
    if (formState!.validate()) {
      setState(() {
        isAddCategory = false;
        isLoadingCategory = true;
      });
      _addCategoryParent!.loadData(categoryNameCTRL!.text, categoryColor);
    }
  }

  void snackBarFun(bool isEvent, bool isSuccess,String message) {
    if (!snackBarShowing) {
      snackBarShowing = true;
      showTopSnackBar(context, isSuccess == true ? CustomSnackBar.success(message) : CustomSnackBar.error(message));
      Future.delayed( const Duration(milliseconds: 1500), () {
        setState(() {
          snackBarShowing = false;
          isLoading = false;
          isLoadingCategory = false;
          isAddCategory = false;
        });
      });
      if(isEvent == true) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onLoadGetAllCategoryConnection(connection) {
    snackBarFun(false, false, connection);
  }

  @override
  void onLoadGetAllCategoryError(CommonMessageModel items) {
    snackBarFun(false, false, items.messages!);
  }

  @override
  void onLoadGetAllCategorySuccess(GetAllCategoryModel item) {
    setState(() {
      snackBarShowing = false;
      isLoading = false;
      isLoadingCategory = false;
      isAddCategory = false;
      allCategoryData.clear();
      if(item.data != null && item.data!.isNotEmpty) {
        if(mounted) {
          setState(() {
            item.data!.asMap().forEach((index, element) {
              allCategoryData.add(item.data![index]);
            });
          });
          if(allCategoryData.isNotEmpty && (selectedCategory == "" || selectedCategory == "null")) {
            setState(() {
              selectedCategory = allCategoryData[0].id!;
            });
          }
        }
      }
    });
  }

  @override
  void onLoadAddCategoryConnection(connection) {
    snackBarFun(false, false, connection);
  }

  @override
  void onLoadAddCategoryError(CommonMessageModel items) {
    snackBarFun(false, false, items.messages!);
  }

  @override
  void onLoadAddCategorySuccess(AddCategoryModel item) {
    setState(() {
      categoryNameCTRL = TextEditingController(text: "");
      categoryColor = themeColorList[0].colorName;
    });
    _getAllCategoryParent!.loadData();
  }

  @override
  void onLoadAddEditEventConnection(connection) {
    snackBarFun(false, false, connection);
  }

  @override
  void onLoadAddEditEventError(CommonMessageModel items) {
    snackBarFun(false, false, items.messages!);
  }

  @override
  void onLoadAddEditEventSuccess(AddEditEventModel item) {
    snackBarFun(true, true, item.messages!);
  }
}

