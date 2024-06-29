import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';

import 'package:flutter/material.dart';

class ConnectivityService {
  static final ConnectivityService _instance = ConnectivityService._internal();
  factory ConnectivityService() => _instance;
  ConnectivityService._internal() {
    _init();
  }

  final Connectivity _connectivity = Connectivity();
  StreamController<ConnectivityResult> connectivityStreamController =
      StreamController<ConnectivityResult>.broadcast();

  Stream<ConnectivityResult> get connectivityStream =>
      connectivityStreamController.stream;

  void _init() {
    _connectivity.onConnectivityChanged.listen((result) {
      debugPrint('Connectivity changed: $result');
      connectivityStreamController.add(result.first);
    });
  }

  void dispose() {
    connectivityStreamController.close();
  }
}
