import 'package:flutter/material.dart';

import 'splash_screen.dart';
import 'auth_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  Future<bool> fetchData() async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: fetchData(),
        builder: (
          BuildContext context,
          AsyncSnapshot<bool> snapshot,
        ) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.data == null) {
                return const SplashScreen();
              } else {
                return const LocalAuthScreen();
              }
            default:
              return const SplashScreen();
          }
        });
  }
}
