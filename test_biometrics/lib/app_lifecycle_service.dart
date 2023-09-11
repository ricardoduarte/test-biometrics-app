import 'package:flutter/material.dart';

class AppLifecycleService {

  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        debugPrint('App Resumed');
        break;
      case AppLifecycleState.inactive:
        debugPrint('App Inactive');
        break;
      case AppLifecycleState.paused:
        debugPrint('App Paused');
        break;
      case AppLifecycleState.detached:
        debugPrint('App Closed');
        break;
    }
  }
}