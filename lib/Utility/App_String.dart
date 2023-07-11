// ignore_for_file: file_names, camel_case_types

part of 'UtilityLibrary.dart';


const String appStoreIdValue = "com.tools.todoalerts";

const String lightTheme = "light";
const String darkTheme = "dark";

const String edit = "Edit";
const String delete = "Delete";

const String appTitle = "To Do Alert";

const String welcomeTitle = "Welcome!";
const String organizeYorDayTitle = "It's Time to Organize your Day!";

const String saveTitle = "Save";
const String cancelTitle = "Cancel";
const String submitTitle = "Submit";
const String historyTitle = "History";
const String notificationTitle = "Notification";
const String yourToDoListTitle = "Your to do list";
const String todayTitle = "Today";
const String yesterdayTitle = "Yesterday";
const String tomorrowTitle = "Tomorrow";
const String olderTitle = "Older";
const String createEventTitle = "Create Event";
const String updateEventTitle = "Update Event";
const String completedTitle = "Completed";
const String upcomingTitle = "Upcoming";

const String enterYour= "Enter Your";
const String nameTitle= "Name";
const String emailTitle= "Email";
const String phoneTitle= "Phone";
const String numberTitle= "Number";
const String themeTitle= "Theme";
const String colorTitle= "Color";

const String addNewTitle= "Add New";
const String eventTitle= "Event";
const String selectTitle= "Select";
const String categoryTitle= "Category";
const String remindsMeTitle= "Reminds me";

const String eventCalendarPage= "Event Calendar";
const String eventHistoryPage= "Event History";
const String eventNotificationPage= "Event Notification";
const String profilePage= "Profile";

const String unauthorized = "Unauthorized";
const String serverApiError = "Error 502";
const String pleaseCheckInternetConnection="Please check your internet connection";
const String somethingWrongString="Something Went Wrong";

const String dbNotificationTable = "allNotifications";

List<String> themeList = [
  lightTheme,
  darkTheme,
];

List<String> eventOperation = [
  edit,
  delete,
];

List<colorObject> themeColorList = [
  colorObject(colorName: "pink", color: pink),
  colorObject(colorName: "darkGreen", color: darkGreen),
  colorObject(colorName: "darkBlue", color: darkBlue),
  colorObject(colorName: "yellow", color: yellow),
  colorObject(colorName: "darkRed", color: darkRed),
  colorObject(colorName: "greenAccent", color: greenAccent),
  colorObject(colorName: "lightPurple", color: lightPurple),
  colorObject(colorName: "skyBlue", color: skyBlue),
  colorObject(colorName: "orange", color: orange),
  colorObject(colorName: "lightGreen", color: lightGreen),
  colorObject(colorName: "nevyBlue", color: nevyBlue),
  colorObject(colorName: "darkPurple", color: darkPurple),
];

class colorObject {
  final String colorName;
  final Color color;

  colorObject({required this.colorName, required this.color});
}