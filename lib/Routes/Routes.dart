// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:todoalerts/Views/ViewsLibrary.dart';

Route onGenerateRoute(RouteSettings routeSettings) {
  final arguments = routeSettings.arguments;
  switch (routeSettings.name) {
    case '/':
      return MaterialPageRoute(
        builder: (_) => const Splash(),
      );

    case AddUserDetail.route:
      return MaterialPageRoute(
        builder: (_) => const AddUserDetail(),
      );

    case Home.route:
      return MaterialPageRoute(
        builder: (_) => const Home(),
      );

    case Profile.route:
      final data = arguments as ProfileData;
      return MaterialPageRoute(
        builder: (_) => Profile(profileData: data,),
      );

    case EventHistory.route:
      return MaterialPageRoute(
        builder: (_) => const EventHistory(),
      );

    case EventNotification.route:
      return MaterialPageRoute(
        builder: (_) => const EventNotification(),
      );

    case EventDetail.route:
      final data = arguments as EventDetailData;
      return MaterialPageRoute(
        builder: (_) => EventDetail(eventData: data,),
      );

    case EventCalendar.route:
      return MaterialPageRoute(
        builder: (_) => const EventCalendar(),
      );

    case AddEditEvent.route:
      final data = arguments as AddEditEventData;
      return MaterialPageRoute(
        builder: (_) => AddEditEvent(eventData: data,),
      );

    default:
      return MaterialPageRoute(builder: (_) => Container());
  }
}