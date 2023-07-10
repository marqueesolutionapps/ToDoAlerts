// ignore_for_file: file_names

part of 'UtilityLibrary.dart';

class SPUtil {
  static SPUtil? _singleton;
  static SharedPreferences? _prefs;
  // static SharedPreferences? _ratePrefs;
  static final Lock _lock = Lock();

  static Future<SPUtil?> getInstance() async {
    if (_singleton == null) {
      await _lock.synchronized(() async {
        if (_singleton == null) {
          var singleton = SPUtil._();
          await singleton._init();
          _singleton = singleton;
        }
      });
    }
    return _singleton;
  }

  SPUtil._();
  Future _init() async {
    _prefs = await SharedPreferences.getInstance();
    // _ratePrefs = await SharedPreferences.getInstance();
  }

  // static Future<bool> showRating() async {
  //   try {
  //     final InAppReview inAppReview = InAppReview.instance;
  //
  //     final available = await inAppReview.isAvailable();
  //
  //     inAppReview.requestReview();
  //     inAppReview.openStoreListing(
  //       appStoreId: appStoreIdValue,
  //     );
  //
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  // //Rate Us Showing Data
  // static String getRateUsShowingDate({String defValue = ''}) {
  //   if (_ratePrefs == null) return defValue;
  //   return _ratePrefs!.getString("RateUsShowingDate") ?? defValue;
  // }
  //
  // static Future<bool>? setRateUsShowingDate(String displayString) {
  //   if (_ratePrefs == null) return null;
  //   return _ratePrefs!.setString("RateUsShowingDate", displayString);
  // }
  //
  // //Rate Already Applied Or Nor
  // static bool getRateApply({bool defValue = false}) {
  //   if (_ratePrefs == null) return defValue;
  //   return _ratePrefs!.getBool("RateApply") ?? defValue;
  // }
  //
  // static Future<bool>? setRateApply(bool defValue) {
  //   if (_ratePrefs == null) return null;
  //   return _ratePrefs!.setBool("RateApply", defValue);
  // }

  //Token
  static String getToken({String defValue = ''}) {
    if (_prefs == null) return defValue;
    return _prefs!.getString("token") ?? defValue;
  }

  static Future<bool>? setToken(String displayString) {
    if (_prefs == null) return null;
    return _prefs!.setString("token", displayString);
  }

  //Device Id
  static String getDeviceId({String defValue = ''}) {
    if (_prefs == null) return defValue;
    return _prefs!.getString("deviceId") ?? defValue;
  }

  static Future<bool>? setDeviceId(String displayString) {
    if (_prefs == null) return null;
    return _prefs!.setString("deviceId", displayString);
  }

  //Notification Budge
  static int getBadgeCount({int defValue = 0}) {
    if (_prefs == null) return defValue;
    return _prefs!.getInt("badgeCount") ?? defValue;
  }

  static Future<bool>? setBadgeCount(int count) {
    if (_prefs == null) return null;
    return _prefs!.setInt("badgeCount", count);
  }

  //Theme
  static String getTheme({String defValue = lightTheme}) {
    if (_prefs == null) return defValue;
    return _prefs!.getString("Theme") ?? defValue;
  }

  static Future<bool>? setTheme(String displayString) {
    if (_prefs == null) return null;
    return _prefs!.setString("Theme", displayString);
  }

  //Theme Color
  static String getThemeColor({String defValue = 'pink'}) {
    if (_prefs == null) return defValue;
    return _prefs!.getString("ThemeColor") ?? defValue;
  }

  static Future<bool>? setThemeColor(String displayString) {
    if (_prefs == null) return null;
    return _prefs!.setString("ThemeColor", displayString);
  }

  //User ID
  static String getUserId({String defValue = ''}) {
    if (_prefs == null) return defValue;
    return _prefs!.getString("UserId") ?? defValue;
  }

  static Future<bool>? setUserId(String displayString) {
    if (_prefs == null) return null;
    return _prefs!.setString("UserId", displayString);
  }

  //User Name
  static String getUserName({String defValue = ''}) {
    if (_prefs == null) return defValue;
    return _prefs!.getString("UserName") ?? defValue;
  }

  static Future<bool>? setUserName(String displayString) {
    if (_prefs == null) return null;
    return _prefs!.setString("UserName", displayString);
  }

  //User Email
  static String getUserEmail({String defValue = ''}) {
    if (_prefs == null) return defValue;
    return _prefs!.getString("UserEmail") ?? defValue;
  }

  static Future<bool>? setUserEmail(String displayString) {
    if (_prefs == null) return null;
    return _prefs!.setString("UserEmail", displayString);
  }

  //User PhoneNumber
  static String getUserPhoneNumber({String defValue = ''}) {
    if (_prefs == null) return defValue;
    return _prefs!.getString("UserPhoneNumber") ?? defValue;
  }

  static Future<bool>? setUserPhoneNumber(String displayString) {
    if (_prefs == null) return null;
    return _prefs!.setString("UserPhoneNumber", displayString);
  }

}