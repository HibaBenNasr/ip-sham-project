import 'package:flutter/material.dart';
import 'package:sham_robot/route/routing_consts.dart';
import 'package:sham_robot/screens/dashboard_screen.dart';
import 'package:sham_robot/screens/signin_screen.dart';
import 'package:sham_robot/screens/splash_screen.dart';
import 'package:sham_robot/screens/undefined_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreenRoute:
      return MaterialPageRoute(builder: (context) => SplashScreen());

    case SignInScreenRoute:
      return MaterialPageRoute(builder: (context) => SignInScreen());

    case DashboardScreenRoute:
      return MaterialPageRoute(builder: (context) => DashboardScreen());

    default:
      return MaterialPageRoute(
          builder: (context) => UndefinedView(
            name: settings.name!,
          ));
  }
}