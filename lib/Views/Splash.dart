// ignore_for_file: file_names

part of 'ViewsLibrary.dart';

class Splash extends StatefulWidget {
  static const route = '/Splash';

  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> implements GetUserDataController {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool snackBarShowing = false;

  double _dot1Width = Util.screenWidth! * 0.08;
  Color _dot1Color = primary;
  double _dot2Width = Util.screenWidth! * 0.08;
  Color _dot2Color = white;
  double _dot3Width = Util.screenWidth! * 0.08;
  Color _dot3Color = primary;
  Timer? timer1;
  Timer? timer2;
  Timer? timer3;

  GetUserParent? _getUserParent;

  _SplashState() {
    _getUserParent = GetUserParent(this);
  }

  @override
  void initState() {
    _splashAnimation();
    changeSize1();
    Future.delayed(const Duration(milliseconds: 100), () {
      changeSize2();
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      changeSize3();
    });
    super.initState();
  }

  void _splashAnimation() async {
    Future.delayed(const Duration(milliseconds: 2500), () {
      if(SPUtil.getUserId().isNotEmpty) {
        Navigator.of(context).pushReplacementNamed(Home.route);
      }
      else {
        _getUserParent!.loadData();
      }
    });
  }

  void changeSize1() {
    timer1 = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        if(_dot1Width == Util.screenWidth! * 0.06) {
          _dot1Width = Util.screenWidth! * 0.03;
          _dot1Color = white;
        }
        else {
          _dot1Width = Util.screenWidth! * 0.06;
          _dot1Color = primary;
        }
      });
    });
  }

  void changeSize2() {
    timer2 = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        if(_dot2Width == Util.screenWidth! * 0.06) {
          _dot2Width = Util.screenWidth! * 0.03;
          _dot2Color = primary;
        }
        else {
          _dot2Width = Util.screenWidth! * 0.06;
          _dot2Color = white;
        }
      });
    });
  }

  void changeSize3() {
    timer3 = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        if(_dot3Width == Util.screenWidth! * 0.06) {
          _dot3Width = Util.screenWidth! * 0.03;
          _dot3Color = white;
        }
        else {
          _dot3Width = Util.screenWidth! * 0.06;
          _dot3Color = primary;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Util.statusBarHeight = MediaQuery.of(context).padding.top;
    Util.appBarHeight = AppBar().preferredSize.height;
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
                Column(
                  children: [
                    SizedBox(
                      height: Util.appBarHeight! + Util.statusBarHeight!,
                      child: Padding(
                        padding: EdgeInsets.only(top: Util.statusBarHeight!, left: 10, right: 10),
                        child: Center(
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(2.5),
                                height: Util.appBarHeight! * 0.6,
                                width: Util.appBarHeight! * 0.6,
                                decoration: BoxDecoration(
                                  color: themeTextDefaultColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: primary,
                                    width: 1.5,
                                  ),
                                ),
                                child: SvgPicture.asset(
                                  bell,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                child: CustomText(value: appTitle, fontSize: 22, fontWeight: 900, textAlign: TextAlign.start, maxLines: 1,),
                              ),
                              SizedBox(width: 10,),
                              Row(
                                children: [
                                  AnimatedContainer(
                                    width: _dot1Width,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: _dot1Color,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    duration: Duration(seconds: 1),
                                    curve: Curves.fastOutSlowIn,
                                  ),
                                  SizedBox(width: 2.5,),
                                  AnimatedContainer(
                                    width: _dot2Width,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: _dot2Color,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    duration: Duration(seconds: 1),
                                    curve: Curves.fastOutSlowIn,
                                  ),
                                  SizedBox(width: 2.5,),
                                  AnimatedContainer(
                                    width: _dot3Width,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: _dot3Color,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    duration: Duration(seconds: 1),
                                    curve: Curves.fastOutSlowIn,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 40),
                            child: Column(
                              children: [
                                CustomText(value: welcomeTitle, fontSize: Util.screenWidth! * 0.05, letterSpacing: 1, fontWeight: 500, maxLines: 1,),
                                SizedBox(height: 10,),
                                CustomText(value: organizeYorDayTitle, fontSize: Util.screenWidth! * 0.075, fontWeight: 700, maxLines: 3,),
                              ],
                            ),
                          ),
                          Expanded(
                            child: LayoutBuilder(
                              builder: (context, constraint) {
                                return Stack(
                                  children: [
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        height: constraint.maxHeight * 0.75,
                                        width: constraint.maxWidth * 0.5,
                                        color: primary,
                                      ),
                                    ),
                                    SizedBox(
                                      height: constraint.maxHeight,
                                      width: constraint.maxWidth,
                                      child: Image.asset(
                                        splashGirl,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.play_arrow),
        //   backgroundColor: Colors.green,
        //   onPressed: () {
        //     setState(() {
        //       // random generator
        //       final random = Random();
        //
        //
        //       if(_width == Util.screenWidth! * 0.08) {
        //         _width = Util.screenWidth! * 0.04;
        //       }
        //       else {
        //         _width = Util.screenWidth! * 0.08;
        //       }
        //     });
        //   },
        // ),
      ),
    );
  }

  @override
  void dispose() {
    timer1!.cancel();
    timer2!.cancel();
    timer3!.cancel();
    super.dispose();
  }

  void snackBarFun(bool isSuccess,String message) {
    if (!snackBarShowing) {
      snackBarShowing = true;
      showTopSnackBar(context, isSuccess == true ? CustomSnackBar.success(message) : CustomSnackBar.error(message));
      Future.delayed( const Duration(milliseconds: 1500), () {
        setState(() {
          snackBarShowing = false;
        });
      });
    }
  }

  @override
  void onLoadGetUserConnection(connection) {
    snackBarFun(false, connection);
  }

  @override
  void onLoadGetUserError(CommonMessageModel items) {
    snackBarFun(false, items.messages!);
  }

  @override
  void onLoadGetUserSuccess(GetUserModel item) {
    if(item.data == null) {
      Navigator.of(context).pushReplacementNamed(AddUserDetail.route);
    }
    else {
      setState(() {
        SPUtil.setUserId(item.data!.id!);
        SPUtil.setUserName(item.data!.username!);
        SPUtil.setUserEmail(item.data!.email!);
        SPUtil.setUserPhoneNumber(item.data!.phoneNo!);
        SPUtil.setToken(item.data!.token!);
      });
      Navigator.of(context).pushReplacementNamed(Home.route);
    }

  }
}

