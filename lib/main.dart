import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todoalerts/Routes/Routes.dart';
import 'package:todoalerts/Utility/UtilityLibrary.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent
      )
  );
  runApp(const ToDoAlerts());
}

class ToDoAlerts extends StatelessWidget {
  const ToDoAlerts({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints)
      {
        Util.screenWidth = constraints.maxWidth > Util.maxScreenWidth ? Util.maxScreenWidth : constraints.maxWidth;
        Util.screenHeight = constraints.maxHeight;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: appTitle,
          onGenerateRoute: onGenerateRoute,
          builder: (context, child) => ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(physics: const BouncingScrollPhysics()),
            child: Stack(
              children: [
                child!,
              ],
            ),
          ),
        );
      },
    );
  }
}
