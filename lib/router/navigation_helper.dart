import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationHelper {
  static void goTo(BuildContext context, String route) {
    context.go(route);
  }

  static void goToAndReplace(BuildContext context, String route) {
    context.pushReplacement(route);
  }

  static void pushReplacement(BuildContext context, String route) {
    context.pushReplacement(route);
  }

  static void pushTo(BuildContext context, String route) {
    context.push(route);
  }

  static void goBack(BuildContext context, [dynamic result]) {
    context.pop(result);
  }

  static void goToNamed(
    BuildContext context,
    String name, {
    Map<String, String>? pathParameters,
    Map<String, dynamic>? queryParameters,
    Object? extra,
  }) {
    context.goNamed(
      name,
      pathParameters: pathParameters ?? {},
      queryParameters: queryParameters ?? {},
      extra: extra,
    );
  }

  static void pushNamed(
    BuildContext context,
    String name, {
    Map<String, String>? pathParameters,
    Map<String, dynamic>? queryParameters,
    Object? extra,
  }) {
    context.pushNamed(
      name,
      pathParameters: pathParameters ?? {},
      queryParameters: queryParameters ?? {},
      extra: extra,
    );
  }
}
