import 'package:flutter/material.dart';

import '../../core/utils/log_utils.dart';
import '../../injection_container.dart';
import 'app_routes.dart';

class AppNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route.settings.name != null) {
      AppRoutes.pushRouteToRoutesStack(route.settings.name!);
    }
    Log.i(
        '@ROUTES: [push] current: ${route.settings.name}, previous: ${previousRoute?.settings.name}, routesStack: ${routesStack.toString()}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (route.settings.name != null) {
      AppRoutes.popRouteFromRoutesStack();
    }
    Log.i(
        '@ROUTES: [pop] current: ${route.settings.name}, previous: ${previousRoute?.settings.name}, routesStack: ${routesStack.toString()}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (oldRoute != null) {
      if (oldRoute.settings.name != null) {
        AppRoutes.popRouteFromRoutesStack();
      }
    }

    if (newRoute != null) {
      if (newRoute.settings.name != null) {
        AppRoutes.pushRouteToRoutesStack(newRoute.settings.name!);
      }
    }
    Log.i(
        '@ROUTES: [replace] current: ${newRoute?.settings.name}, previous: ${oldRoute?.settings.name}, routesStack: ${routesStack.toString()}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    if (route.settings.name != null) {
      String lastRoute = routesStack.last;
      routesStack.clear();
      routesStack.add(lastRoute);
    }
    Log.i(
        '@ROUTES: [remove] current: ${route.settings.name}, previous: ${previousRoute?.settings.name}, routesStack: ${routesStack.toString()}');
  }
}
