// ignore_for_file: file_names

part of 'ViewsLibrary.dart';

class Splash extends StatefulWidget {
  static const route = '/Splash';

  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
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
        backgroundColor: black,
        key: _scaffoldKey,
        body: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: Util.screenWidth,
              height: Util.screenHeight,
            ),
            Positioned(
              top: Util.statusBarHeight,
              left: 15,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: primary)
                    ),
                    child: SvgPicture.asset(
                      bell
                    ),
                  ),

                ],
              )
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: Util.screenWidth! * 0.4,
                height: Util.screenHeight! * 0.53,
                color: primary,
              )
            ),
            Positioned(
              bottom: 0,
              child: Image.asset(
                splashGirl,
                height: Util.screenHeight! * 0.7,
                fit: BoxFit.contain,
              ),
            )
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

