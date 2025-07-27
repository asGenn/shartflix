import 'package:flutter/material.dart';
import 'navigation_service.dart';

class NavigationServiceImpl implements NavigationService {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  NavigatorState? get _navigator => _navigatorKey.currentState;

  @override
  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigator!.pushNamed(routeName, arguments: arguments);
  }

  @override
  Future<dynamic> navigateAndReplace(String routeName, {dynamic arguments}) {
    return _navigator!.pushReplacementNamed(routeName, arguments: arguments);
  }

  

  @override
  void goBack({dynamic result}) {
    return _navigator!.pop(result);
  }

}
