import 'dart:io';

import 'package:intl/intl.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todoalerts/DatabaseHelper/dbHelper.dart';
import 'package:todoalerts/Model/ModelLibrary.dart';
import 'package:todoalerts/Routes/Routes.dart';
import 'package:todoalerts/Utility/UtilityLibrary.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'Event_Alert',
  'ToDoAlert',
  importance: Importance.max,
  playSound: true,
);

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  Map<String, dynamic> objectData = {};
  if (message.notification != null) {
    objectData = {
      DatabaseHelper.notificationColumnTimeStamp:
      DateFormat("MM/dd/yyyy HH:mm:ss").format(DateTime.now()),
      DatabaseHelper.notificationColumnBody: message.notification!.body,
      DatabaseHelper.notificationColumnTitle: message.notification!.title,
      DatabaseHelper.notificationColumnStatus: 1
    };
    await DatabaseHelper.instance
        .insertRecord(dbNotificationTable, objectData);
  } else if (message.data != null) {
    objectData = {
      DatabaseHelper.notificationColumnTimeStamp:
      DateFormat("MM/dd/yyyy HH:mm:ss").format(DateTime.now()),
      DatabaseHelper.notificationColumnBody: message.notification!.body,
      DatabaseHelper.notificationColumnTitle: message.notification!.title,
      DatabaseHelper.notificationColumnStatus: 1
    };
    await DatabaseHelper.instance
        .insertRecord(dbNotificationTable, objectData);
  }

  int count = SPUtil.getBadgeCount() ?? 0;
  FlutterAppBadger.updateBadgeCount(count + 1);
  await SPUtil.setBadgeCount(count + 1);
}

Future<void> appTrackingPermission() async {
  try {
    // If the system can show an authorization request dialog
    var status = await AppTrackingTransparency.trackingAuthorizationStatus;
    print("App Tracking Permission Status $status");
    if (status == TrackingStatus.notDetermined) {
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
    await AppTrackingTransparency.getAdvertisingIdentifier();
  } on PlatformException {
    print(PlatformException(code: "Permission").message);
  }

  PermissionHandler.determineNotification();
}

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.black
      )
  );

  await Firebase.initializeApp();

  if (Platform.isIOS) {
    appTrackingPermission();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  } else if (Platform.isAndroid) {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  runApp(const ToDoAlerts());
}

class ToDoAlerts extends StatefulWidget {
  const ToDoAlerts({super.key});

  @override
  State<ToDoAlerts> createState() => _ToDoAlertsState();
}

class _ToDoAlertsState extends State<ToDoAlerts> implements UpdateTokenDataController {

  FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final dbHelper = DatabaseHelper.instance;

  final navigatorKey = GlobalKey<NavigatorState>();

  UpdateTokenParent? _updateTokenParent;

  _ToDoAlertsState(){
    _updateTokenParent = UpdateTokenParent(this);
  }

  @override
  void initState() {
    getDeviceId();
    initSP();
    super.initState();
    initFirebase();
    initFlutterLocalNotification();
  }

  void initFlutterLocalNotification() {
    var initializationSettingAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingIOS = DarwinInitializationSettings(
        defaultPresentAlert: true,
        defaultPresentBadge: true,
        defaultPresentSound: true,
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true);

    var initializationSettings = InitializationSettings(
        android: initializationSettingAndroid, iOS: initializationSettingIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void initFirebase() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        _showForegroundNotification(
          title: message.notification?.title ?? '',
          body: message.notification?.body ?? '',
        );
        RemoteNotification notification = message.notification!;
        if (notification != null && !kIsWeb) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                iOS: const DarwinNotificationDetails( presentAlert: true, presentBadge: true, presentSound: true),
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  icon: '@mipmap/ic_launcher',
                ),
              ));
          print("NEW NOTIFICATION");
          await storeNotificationRecord(message);
        }
      });
    }

    await FirebaseMessaging.instance.getToken().then((token) async {
      await SPUtil.setToken(token ?? '');
      if(SPUtil.getToken().isNotEmpty && SPUtil.getDeviceId().isNotEmpty && SPUtil.getUserId().isNotEmpty) {
        _updateTokenParent!.loadData();
      }
    });
    setupCrashlytics();

    _messaging.subscribeToTopic("All");
  }

  void setupCrashlytics() {
    if (kReleaseMode) {
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    }
  }

  void _showForegroundNotification( {String title = '', String body = ''}) async {
    const androidDetails = AndroidNotificationDetails(
        'general_notification',
        'General Notification'
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails);
  }

  Future<void> storeNotificationRecord(RemoteMessage message) async {
    Map<String, dynamic> objectData = {};
    if (message.notification != null) {
      objectData = {
        DatabaseHelper.notificationColumnTimeStamp:
        DateFormat("MM/dd/yyyy HH:mm:ss").format(DateTime.now()),
        DatabaseHelper.notificationColumnBody: message.notification!.body,
        DatabaseHelper.notificationColumnTitle: message.notification!.title,
        DatabaseHelper.notificationColumnStatus: 1
      };
      await DatabaseHelper.instance
          .insertRecord(dbNotificationTable, objectData);
    } else if (message.data != null) {
      objectData = {
        DatabaseHelper.notificationColumnTimeStamp:
        DateFormat("MM/dd/yyyy HH:mm:ss").format(DateTime.now()),
        DatabaseHelper.notificationColumnBody: message.notification!.body,
        DatabaseHelper.notificationColumnTitle: message.notification!.title,
        DatabaseHelper.notificationColumnStatus: 1
      };
      await DatabaseHelper.instance
          .insertRecord(dbNotificationTable, objectData);
    }
    await SPUtil.getInstance();
    int count = SPUtil.getBadgeCount() ?? 0;
    FlutterAppBadger.updateBadgeCount(count + 1);
    await SPUtil.setBadgeCount(count + 1);
  }

  Future<void> initSP() async {
    await SPUtil.getInstance();
    // rateUs();
    FlutterAppBadger.removeBadge();
  }

  void themeColorSet() async {
    if(SPUtil.getTheme() == lightTheme) {
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
          });
        }
      }
    }
    else {
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
          });
        }
      }
    }
  }

  // void rateUs() async {
  //   Future.delayed(const Duration(minutes: 5), () {
  //     if(SPUtil.getRateApply() == false && SPUtil.getRateUsShowingDate().isEmpty) {
  //       setState(() {
  //         isRateUsShow = true;
  //       });
  //     }
  //     else if(SPUtil.getRateApply() == false && (SPUtil.getRateUsShowingDate().isNotEmpty && (DateFormat("dd-MM-yyyy").parse(DateFormat('dd-MM-yyyy').format(DateTime.now())).isAfter(DateFormat("dd-MM-yyyy").parse(SPUtil.getRateUsShowingDate())) == true))) {
  //       setState(() {
  //         isRateUsShow = true;
  //       });
  //     }
  //   });
  // }

  Future<void> getDeviceId() async{
    final DeviceInfoPlugin deviceInfoPlugin = await DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var deviceDetail = await deviceInfoPlugin.androidInfo;
        setState(() {
          SPUtil.setDeviceId(deviceDetail.id);
        });
      } else if (Platform.isIOS) {
        var deviceDetail = await deviceInfoPlugin.iosInfo;
        setState(() {
          SPUtil.setDeviceId(deviceDetail.identifierForVendor!);
        });
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      SPUtil.setTheme(MediaQuery.platformBrightnessOf(context) == Brightness.dark ? darkTheme : lightTheme);
      themeColorSet();
    });
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints)
      {
        Util.screenWidth = constraints.maxWidth > Util.maxScreenWidth ? Util.maxScreenWidth : constraints.maxWidth;
        Util.screenHeight = constraints.maxHeight;
        return MaterialApp(
          title: appTitle,
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
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

  @override
  void onLoadUpdateTokenConnection(connection) {
  }

  @override
  void onLoadUpdateTokenError(CommonMessageModel items) {
  }

  @override
  void onLoadUpdateTokenSuccess(UpdateTokenModel item) {
  }
}