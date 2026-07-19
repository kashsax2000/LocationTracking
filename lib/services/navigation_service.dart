import 'package:flutter/material.dart';

class NavigationService {
  NavigationService._();

  static final NavigationService instance = NavigationService._();

  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  NavigatorState? get navigator =>
      navigatorKey.currentState;

  Future<T?> navigateTo<T>(
    String routeName, {
    Object? arguments,
  }) {
    return navigator!.pushNamed<T>(
      routeName,
      arguments: arguments,
    );
  }

  Future<T?> replaceWith<T>(
    String routeName, {
    Object? arguments,
  }) {
    return navigator!.pushReplacementNamed<T, dynamic>(
      routeName,
      arguments: arguments,
    );
  }

  Future<T?> clearAndNavigate<T>(
    String routeName, {
    Object? arguments,
  }) {
    return navigator!.pushNamedAndRemoveUntil<T>(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  void goBack<T>([T? result]) {
    if (navigator!.canPop()) {
      navigator!.pop(result);
    }
  }
}