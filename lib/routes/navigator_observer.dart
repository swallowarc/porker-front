import 'package:flutter/material.dart';
import 'package:porker_front/commons/logger/logger.dart';
import 'package:sprintf/sprintf.dart';

class MyNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);

    var previous = '';
    if (previousRoute == null) {
      previous = 'null';
    } else {
      previous = previousRoute.settings.name!;
    }
    gLogger.d(sprintf("Current: %s, Previous: %s", [route.settings.name!, previous]));
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);

    var previous = '';
    if (previousRoute == null) {
      previous = 'null';
    } else {
      previous = previousRoute.settings.name!;
    }
    gLogger.d(sprintf("Current: %s, Previous: %s", [route.settings.name!, previous]));
  }
}
