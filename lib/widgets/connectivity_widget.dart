import 'package:flutter/material.dart';
import 'package:sky_cast/services/connectivity_service.dart';

class ConnectivityProvider extends InheritedWidget {
  final ConnectivityService connectivityService;

  const ConnectivityProvider({
    super.key,
    required this.connectivityService,
    required super.child,
  });

  static ConnectivityProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ConnectivityProvider>();
  }

  @override
  bool updateShouldNotify(ConnectivityProvider oldWidget) {
    return connectivityService != oldWidget.connectivityService;
  }
}