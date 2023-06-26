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

    default:
      return MaterialPageRoute(builder: (_) => Container());
  }
}