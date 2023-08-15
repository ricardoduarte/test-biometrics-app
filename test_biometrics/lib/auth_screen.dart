import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
// import 'package:local_auth_android/local_auth_android.dart';
// import 'package:local_auth_ios/local_auth_ios.dart';
// import 'package:local_auth/error_codes.dart' as auth_error;

import 'home_screen.dart';

class LocalAuthScreen extends StatefulWidget {
  const LocalAuthScreen({super.key});

  @override
  State<LocalAuthScreen> createState() => _LocalAuthScreenState();
}

class _LocalAuthScreenState extends State<LocalAuthScreen> {
  final LocalAuthentication auth = LocalAuthentication();

  Future<void> authenticate() async {
    try {
      final bool isLoggedIn = await auth.authenticate(
        localizedReason:
            'Por favor, se autentique para ver a informação privada',
        options: const AuthenticationOptions(useErrorDialogs: false),
      );

      if (isLoggedIn) {
        // ignore: use_build_context_synchronously
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Biometrics App')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Bem-vindo a Test Biometrics app',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          Center(
            child: ElevatedButton(
              child: const Text('Login with Biometrics'),
              onPressed: () => authenticate(),
            ),
          ),
        ],
      ),
    );
  }
}
