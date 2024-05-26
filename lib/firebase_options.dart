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
    apiKey: 'AIzaSyDPi949PHS7EGrriDegKpGc0X2cQm5xJQI',
    appId: '1:282212325066:web:7c1c696f4822297d504633',
    messagingSenderId: '282212325066',
    projectId: 'myloginapprubber',
    authDomain: 'myloginapprubber.firebaseapp.com',
    storageBucket: 'myloginapprubber.appspot.com',
    measurementId: 'G-X2HK557GDH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCB3SCg-nDdpn23WJOtiLiut9TWJMiQibQ',
    appId: '1:282212325066:android:0118da57408a955f504633',
    messagingSenderId: '282212325066',
    projectId: 'myloginapprubber',
    storageBucket: 'myloginapprubber.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCRy--cplV2STu2mj5ENsTMQHBhg5ORF1w',
    appId: '1:282212325066:ios:dd844c8335738f40504633',
    messagingSenderId: '282212325066',
    projectId: 'myloginapprubber',
    storageBucket: 'myloginapprubber.appspot.com',
    iosBundleId: 'com.example.rubYang',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCRy--cplV2STu2mj5ENsTMQHBhg5ORF1w',
    appId: '1:282212325066:ios:ce42b7829c2bf766504633',
    messagingSenderId: '282212325066',
    projectId: 'myloginapprubber',
    storageBucket: 'myloginapprubber.appspot.com',
    iosBundleId: 'com.example.rubYang.RunnerTests',
  );
}