import 'package:flutter/material.dart';
import 'package:media_design_assingment_app/modules/order/screens/order_confirmation_screen.dart';
import 'package:media_design_assingment_app/modules/order/screens/order_preview_screen.dart';
import 'package:media_design_assingment_app/modules/order/screens/order_screen.dart';

class AppRouter {
  //ROUTES NAMING
  static const home = '/';
  static const orderConfirmation = 'orderConfirmation';
  static const orderPreview = 'orderPreview';

  //NAVIGATOR HELPERS
  static final key = GlobalKey<NavigatorState>();
  static String currentRoute = home;

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    currentRoute = settings.name.toString();
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const OrderScreen(),
        );
      case orderConfirmation:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const OrderConfirmationScreen(),
        );
      case orderPreview:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const OrderPreviewScreen(),
        );
      default:
        return MaterialPageRoute(builder: (context) => Container());
    }
  }

  //NAVIGATIONS METHODS
  static pushAndReplace(String route, {Object? arguments}) {
    key.currentState!.pushNamedAndRemoveUntil(
      route,
      (Route<dynamic> route) => false,
    );
    key.currentState!.pushReplacementNamed(route, arguments: arguments);
  }

  static pushAndReplaceAll(String route, {Object? arguments}) {
    key.currentState!.pushNamedAndRemoveUntil(
      route,
      (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }

  static popAndPush(String route, {Object? arguments}) {
    pop();
    key.currentState!.pushNamed(route, arguments: arguments);
  }

  static Future push<T extends Object?>(
    String route, {
    Object? arguments,
  }) async {
    final data = key.currentState!.pushNamed(route, arguments: arguments);
    return data;
  }

  static pop<T>([T? result]) {
    key.currentState!.pop(result);
    currentRoute = 'home';
  }

  static popTimes<T>(int count, [T? result]) {
    while (count != 0) {
      key.currentState!.pop(result);
      count--;
    }
  }

  static String get currentRouter => currentRoute;
}
