// ignore_for_file: depend_on_referenced_packages, public_member_api_docs

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in_dartio/google_sign_in_dartio.dart';
import 'package:window_manager/window_manager.dart';
import 'package:yaru/yaru.dart';

import 'login.dart';
import 'profile.dart';

/// Initialize with a secondary app until dart-only initialization is merged.
FirebaseOptions get firebaseOptions => const FirebaseOptions(
      appId: '1:964057941219:web:8cb88c4db434f2059831d6',
      apiKey: 'AIzaSyDjO1hd6RaTERgSP9jE7z4BUneDz6g3mMA',
      projectId: 'memotai',
      messagingSenderId: '964057941219',
      authDomain: 'https://memotai.firebaseapp.com',
    );

// Requires that the Firebase Auth emulator is running locally
// e.g via `melos run firebase:emulator`.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await windowManager.ensureInitialized();

  await Firebase.initializeApp(options: firebaseOptions);
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  await GoogleSignInDart.register(
    clientId: '964057941219-rtdhn5mhh4j29epfsn4gqpm033pi4v4l.apps.googleusercontent.com',
  );

  runApp(const AuthExampleApp());
}

/// The entry point of the application.
///
/// Returns a [MaterialApp].
class AuthExampleApp extends StatelessWidget {
  const AuthExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Example App',
      darkTheme: yaruDark,
      theme: yaruLight,
      home: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraines) {
            return Row(
              children: [
                Visibility(
                  visible: constraines.maxWidth >= 1200,
                  child: Expanded(
                    child: Container(
                      height: double.infinity,
                      color: Theme.of(context).colorScheme.primary,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Firebase Auth Desktop',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: StreamBuilder<User?>(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return const ProfilePage();
                      }
                      return const AuthGate();
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
