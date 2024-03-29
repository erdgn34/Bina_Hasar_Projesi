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
    apiKey: 'AIzaSyBpTiJJOVajcRmgHnBX_edCQ0VZtBt29jA',
    appId: '1:599304549619:web:efac2f083c12e3400bf386',
    messagingSenderId: '599304549619',
    projectId: 'fir-new-e9526',
    authDomain: 'fir-new-e9526.firebaseapp.com',
    storageBucket: 'fir-new-e9526.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCo_kTWEP4tT-OhC2Z16lcVydqr6IMoixo',
    appId: '1:599304549619:android:e0ebefcfb7bc29460bf386',
    messagingSenderId: '599304549619',
    projectId: 'fir-new-e9526',
    storageBucket: 'fir-new-e9526.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAo2aKM3UIps_DIh_2uiyWIfjK4LzL9p_k',
    appId: '1:599304549619:ios:06a2ab3aca21b1f70bf386',
    messagingSenderId: '599304549619',
    projectId: 'fir-new-e9526',
    storageBucket: 'fir-new-e9526.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAo2aKM3UIps_DIh_2uiyWIfjK4LzL9p_k',
    appId: '1:599304549619:ios:8d12da2a2d4793350bf386',
    messagingSenderId: '599304549619',
    projectId: 'fir-new-e9526',
    storageBucket: 'fir-new-e9526.appspot.com',
    iosBundleId: 'com.example.flutterApplication1.RunnerTests',
  );
}
