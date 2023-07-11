// ignore_for_file: file_names

part of 'ViewsLibrary.dart';

class ProfileData {
  final VoidCallback? onThemeChange;
  ProfileData({required this.onThemeChange,});
}

class Profile extends StatefulWidget {
  static const route = '/Profile';

  final ProfileData profileData;
  const Profile({Key? key, required this.profileData}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> implements AddEditUserDataController {

  final _formKey = GlobalKey<FormState>();

  TextEditingController? userNameCTRL, emailCTRL, phoneNumberCTRL;

  bool isLoading = false, snackBarShowing = false, isEdit = false;

  AddEditUserParent? _addEditUserParent;

  _ProfileState() {
    _addEditUserParent = AddEditUserParent(this);
  }

  @override
  void initState() {
    assignVariableValue();
    super.initState();
  }

  assignVariableValue() {
    setState(() {
      userNameCTRL = TextEditingController(text: SPUtil.getUserName());
      emailCTRL = TextEditingController(text: SPUtil.getUserEmail());
      phoneNumberCTRL = TextEditingController(text: SPUtil.getUserPhoneNumber());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Util.paddingAll,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: isEdit == true
                  ? Form(
                key: _formKey,
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40,),
                      Center(
                        child: Container(
                          height: Util.screenWidth! * 0.35,
                          width: Util.screenWidth! * 0.35,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 20,
                              ),
                            ],
                          ),
                          child: SvgPicture.asset(
                            appIcon,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(height: 25,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: CustomText(value: "$enterYour $nameTitle", maxLines: 1, textAlign: TextAlign.start,),
                          ),
                          SizedBox(height: 10,),
                          CustomTextFormField(
                            controller: userNameCTRL,
                            hintText: "$enterYour $nameTitle",
                            textAlign: TextAlign.start,
                            inputFormatters: CustomTextInputFormat.acceptUserName,
                            keyboardType: TextInputType.multiline,
                            onTapOutside: (val) => Util.focusOut(context),
                            fillColor: textFormFieldFillColor,
                            validator: (input) {
                              if (input!.isEmpty) {
                                return "Please enter name.";
                              }
                              else if(input.trim().isEmpty) {
                                return "Only White Space Not Allowed";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 25,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: CustomText(value: "$enterYour $emailTitle", maxLines: 1, textAlign: TextAlign.start,),
                          ),
                          SizedBox(height: 10,),
                          CustomTextFormField(
                            controller: emailCTRL,
                            hintText: "$enterYour $emailTitle",
                            textAlign: TextAlign.start,
                            inputFormatters: CustomTextInputFormat.acceptEmail,
                            keyboardType: TextInputType.emailAddress,
                            onTapOutside: (val) => Util.focusOut(context),
                            fillColor: textFormFieldFillColor,
                            validator: (input) {
                              if (input!.isEmpty) {
                                return "Please enter email address.";
                              }
                              else if (!Util.emailregExp
                                  .hasMatch(input)) {
                                return "Please enter valid email address.";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 25,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: CustomText(value: "$enterYour $phoneTitle", maxLines: 1, textAlign: TextAlign.start,),
                          ),
                          SizedBox(height: 10,),
                          CustomTextFormField(
                            controller: phoneNumberCTRL,
                            hintText: "$enterYour $phoneTitle $numberTitle",
                            textAlign: TextAlign.start,
                            inputFormatters: CustomTextInputFormat.acceptPhoneNumber,
                            keyboardType: TextInputType.number,
                            onTapOutside: (val) => Util.focusOut(context),
                            fillColor: textFormFieldFillColor,
                            validator: (input) {
                              if (input!.isEmpty) {
                                return "Please enter phone number.";
                              }
                              else if(input.length < 10) {
                                return "Please enter valid phone number.";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      if(isEdit == true)
                        isLoading == true ? CircularProgressIndicator(color: primary,) : Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  saveData();
                                },
                                child: CustomButton(
                                  primary,
                                  submitTitle,
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isEdit = false;
                                  });
                                },
                                child: CustomButton(
                                  primary,
                                  cancelTitle,
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              )
                  : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40,),
                  Center(
                    child: Container(
                      height: Util.screenWidth! * 0.35,
                      width: Util.screenWidth! * 0.35,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: SvgPicture.asset(
                        appIcon,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(height: 25,),
                  Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          value: nameTitle,
                          maxLines: 1,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isEdit = true;
                          });
                        },
                        child: Icon(
                          Icons.mode_edit_outline_rounded,
                          size: 25,
                          color: themeTextDefaultColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  CustomText(value: SPUtil.getUserName(), maxLines: 2, color: hintGrey, fontWeight: 900, textAlign: TextAlign.start,),
                  SizedBox(height: 25,),
                  CustomText(value: emailTitle, maxLines: 1, textAlign: TextAlign.start,),
                  SizedBox(height: 10,),
                  CustomText(value: SPUtil.getUserEmail(), maxLines: 2, color: hintGrey, fontWeight: 900, textAlign: TextAlign.start,),
                  SizedBox(height: 25,),
                  CustomText(value: "$phoneTitle $numberTitle", maxLines: 1, textAlign: TextAlign.start,),
                  SizedBox(height: 10,),
                  CustomText(value: SPUtil.getUserPhoneNumber(), maxLines: 2, color: hintGrey, fontWeight: 900, textAlign: TextAlign.start,),
                  SizedBox(height: 25,),
                  Divider(
                    height: 2,
                    thickness: 2,
                    color: greyBorder,
                  ),
                  SizedBox(height: 25,),
                  CustomText(value: themeTitle, maxLines: 1, textAlign: TextAlign.start,),
                  SizedBox(height: 10,),
                  CustomDropDownField(
                    selectedCategoryLabel: SPUtil.getTheme(),
                    dropDownItemValue: MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: themeList.length,
                        itemBuilder: (context, index) {
                          return DropDownItem(
                            themeList[index],
                                () {
                              setState(() {
                                SPUtil.setTheme(themeList[index]);
                                if(SPUtil.getTheme() == darkTheme) {
                                  for(var i = 0; i < themeColorList.length; i++) {
                                    if(themeColorList[i].colorName == SPUtil.getThemeColor()) {
                                      setState(() {
                                        primary = themeColorList[i].color;
                                        scaffoldBackgroundColor = black;
                                        themeTextDefaultColor = white;
                                        bottomBarColor = blackGrey;
                                        bottomBarItemAndDayNameColor = white;
                                        cardAndDialogBackgroundColor = blackGrey;
                                        textFormFieldFillColor = blackGrey;
                                        widget.profileData.onThemeChange!.call();
                                      });
                                    }
                                  }
                                }
                                else {
                                  for(var i = 0; i < themeColorList.length; i++) {
                                    if(themeColorList[i].colorName == SPUtil.getThemeColor()) {
                                      setState(() {
                                        primary = themeColorList[i].color;
                                        scaffoldBackgroundColor = white;
                                        themeTextDefaultColor = blackTitle;
                                        bottomBarColor = white;
                                        bottomBarItemAndDayNameColor = subtitleGrey;
                                        cardAndDialogBackgroundColor = white;
                                        textFormFieldFillColor = fillGray;
                                        widget.profileData.onThemeChange!.call();
                                      });
                                    }
                                  }
                                }
                              });

                            },
                          );
                        },
                        separatorBuilder:(BuildContext context, int index){
                          return const SizedBox(height: 15,);
                        },
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 25,),
                      CustomText(value: "$themeTitle $colorTitle", maxLines: 1, textAlign: TextAlign.start,),
                      SizedBox(height: 10,),
                      Wrap(
                        spacing: 15,
                        runSpacing: 15,
                        children: [
                          for(var i=0 ; i < themeColorList.length ; i++)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  SPUtil.setThemeColor(themeColorList[i].colorName);
                                  primary = themeColorList[i].color;
                                  widget.profileData.onThemeChange!.call();
                                });
                              },
                              child: CustomColorButton(
                                SPUtil.getThemeColor() == themeColorList[i].colorName ? true : false,
                                themeColorList[i].color,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: Util.bottomBarHeight,),
        ],
      ),
    );
  }

  void saveData() {
    final formState = _formKey.currentState;
    if (formState!.validate()) {
      setState(() {
        isLoading = true;
      });
      _addEditUserParent!.loadData(SPUtil.getUserId(), userNameCTRL!.text, emailCTRL!.text, phoneNumberCTRL!.text);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void snackBarFun(bool isSuccess,String message) {
    if (!snackBarShowing) {
      snackBarShowing = true;
      showTopSnackBar(context, isSuccess == true ? CustomSnackBar.success(message) : CustomSnackBar.error(message));
      Future.delayed( const Duration(milliseconds: 1500), () {
        setState(() {
          snackBarShowing = false;
          isLoading = false;
          isEdit = false;
        });
      });
    }
  }

  @override
  void onLoadAddEditUserConnection(connection) {
    snackBarFun(false, connection);
    assignVariableValue();
  }

  @override
  void onLoadAddEditUserError(CommonMessageModel items) {
    snackBarFun(false, items.messages!);
    assignVariableValue();
  }

  @override
  void onLoadAddEditUserSuccess(AddEditUserModel item) {
    snackBarFun(true, item.messages!);
    setState(() {
      SPUtil.setUserId(item.data!.id!);
      SPUtil.setUserName(item.data!.username!);
      SPUtil.setUserEmail(item.data!.email!);
      SPUtil.setUserPhoneNumber(item.data!.phoneNo!);
    });
    assignVariableValue();
  }
}