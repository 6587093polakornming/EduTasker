// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBD7xVhQX3Qx649ilvY8BUjT-MI5l3Kjkw',
    appId: '1:47941036680:web:91f81b1252c60f0d7c8d3d',
    messagingSenderId: '47941036680',
    projectId: 'edutasker-login',
    authDomain: 'edutasker-login.firebaseapp.com',
    storageBucket: 'edutasker-login.appspot.com',
    measurementId: 'G-T6747R541H',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCAmQQDI7rYXMWF6-G3W7P37UwTIS-flQ8',
    appId: '1:47941036680:android:5a3178bf817868397c8d3d',
    messagingSenderId: '47941036680',
    projectId: 'edutasker-login',
    storageBucket: 'edutasker-login.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCilGNqxw2BY7l50609VaMyCVsGsohqFYE',
    appId: '1:47941036680:ios:f9321671c849ae4b7c8d3d',
    messagingSenderId: '47941036680',
    projectId: 'edutasker-login',
    storageBucket: 'edutasker-login.appspot.com',
    iosBundleId: 'com.example.eduTakser',
  );
}
