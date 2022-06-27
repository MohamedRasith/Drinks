import 'package:drinks/screens/drink_details_screen.dart';
import 'package:drinks/screens/home_screen.dart';
import 'package:drinks/screens/splash_screen.dart';
import 'package:drinks/utils/logger.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as dynamic;
    log<RouteGenerator>(msg: "Pushed ${settings.name}(${args ?? ''})");
    switch (settings.name) {
      case SplashScreen.id:
        return _route(const SplashScreen());
      case HomeScreen.id:
        return _route(const HomeScreen());
      case DrinkDetailsScreen.id:
        return _route(DrinkDetailsScreen(drink: args));
      default:
        return _errorRoute(settings.name);
    }
  }

  static MaterialPageRoute _route(Widget widget) =>
      MaterialPageRoute(builder: (context) => widget);

  static Route<dynamic> _errorRoute(String? name) {
    return _route(
      Scaffold(
        body: Center(
          child: Text('ROUTE\n\n$name\n\nNOT FOUND'),
        ),
      ),
    );
  }
}
