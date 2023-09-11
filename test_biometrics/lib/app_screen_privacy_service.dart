import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppScreenPrivacyService {
  static const platform = MethodChannel('security');

  Future<void> disableScreenPrivacy() async {
    try {
      await platform.invokeMethod('disableAppSecurity');
    } on PlatformException catch (e) {
      debugPrint('Failed to disable app security: "${e.message}"');
    }
  }

  Future<void> enableScreenPrivacy() async {
    try {
      await platform.invokeMethod('enableAppSecurity');
    } on PlatformException catch (e) {
      debugPrint('Failed to enable app security: "${e.message}"');
    }
  }
}