// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDrZkDaZsvtxfJbmZVhFc6w0hNwAsa-C5A',
    appId: '1:209458394153:web:950830db4c54f0505d5838',
    messagingSenderId: '209458394153',
    projectId: 'fiapmbachatapp',
    authDomain: 'fiapmbachatapp.firebaseapp.com',
    storageBucket: 'fiapmbachatapp.appspot.com',
    measurementId: 'G-1VCMJ4N1K6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB7wQjLvzkVfkiUwAd_1mAGrnZFUjqJd4E',
    appId: '1:209458394153:android:d2cde9957a7078365d5838',
    messagingSenderId: '209458394153',
    projectId: 'fiapmbachatapp',
    storageBucket: 'fiapmbachatapp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBZv0pJc9nwn7sZ_HUSiKUK-cRBiYYDmYU',
    appId: '1:209458394153:ios:ee664597d58f5a905d5838',
    messagingSenderId: '209458394153',
    projectId: 'fiapmbachatapp',
    storageBucket: 'fiapmbachatapp.appspot.com',
    iosBundleId: 'com.example.chatAutonomos',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBZv0pJc9nwn7sZ_HUSiKUK-cRBiYYDmYU',
    appId: '1:209458394153:ios:3f2af20fc557e4e95d5838',
    messagingSenderId: '209458394153',
    projectId: 'fiapmbachatapp',
    storageBucket: 'fiapmbachatapp.appspot.com',
    iosBundleId: 'com.example.chatAutonomos.RunnerTests',
  );
}
