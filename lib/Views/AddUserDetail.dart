// ignore_for_file: file_names

part of 'ViewsLibrary.dart';

class AddUserDetail extends StatefulWidget {
  static const route = '/AddUserDetail';

  const AddUserDetail({Key? key}) : super(key: key);

  @override
  State<AddUserDetail> createState() => _AddUserDetailState();
}

class _AddUserDetailState extends State<AddUserDetail> implements AddEditUserDataController {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  TextEditingController? userNameCTRL, emailCTRL, phoneNumberCTRL;

  bool isLoading = false, snackBarShowing = false;
  AddEditUserParent? _addEditUserParent;

  _AddUserDetailState() {
    _addEditUserParent = AddEditUserParent(this);
  }

  @override
  void initState() {
    assignVariableValue();
    super.initState();
  }

  assignVariableValue() {
    setState(() {
      userNameCTRL = TextEditingController(text: "");
      emailCTRL = TextEditingController(text: "");
      phoneNumberCTRL = TextEditingController(text: "");
    });
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
                    children: [
                      SizedBox(height: Util.statusBarHeight!,),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20,),
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
                                      child: Image.asset(
                                        addUserGirl,
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
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      isLoading == true ? CircularProgressIndicator(color: primary,) : GestureDetector(
                        onTap: () {
                          saveData();
                        },
                        child: CustomButton(
                          primary,
                          submitTitle,
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

  void saveData() {
    final formState = _formKey.currentState;
    if (formState!.validate()) {
      setState(() {
        isLoading = true;
      });
      _addEditUserParent!.loadData("", userNameCTRL!.text, emailCTRL!.text, phoneNumberCTRL!.text);
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
        });
        if(isSuccess == true) {
          Navigator.of(context).pushReplacementNamed(Home.route);
        }
      });
    }
  }

  @override
  void onLoadAddEditUserConnection(connection) {
    snackBarFun(false, connection);
  }

  @override
  void onLoadAddEditUserError(CommonMessageModel items) {
    snackBarFun(false, items.messages!);
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
  }
}

