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
    apiKey: 'AIzaSyCN9eHavMyUruOZUPF8FF4oNA5O6WSI3eQ',
    appId: '1:637455013229:web:4650de30c3d98533d63664',
    messagingSenderId: '637455013229',
    projectId: 'swap-me-f4272',
    authDomain: 'swap-me-f4272.firebaseapp.com',
    storageBucket: 'swap-me-f4272.appspot.com',
    measurementId: 'G-Q8RV0ER5NB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCXJVfZ9CY_tyQI7HlqwKlzNtRbfMLPtXk',
    appId: '1:637455013229:android:6baf5bfa352df9d3d63664',
    messagingSenderId: '637455013229',
    projectId: 'swap-me-f4272',
    storageBucket: 'swap-me-f4272.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBFdubcVQZ0ufa6z0oUG7OTEmAVZKFPwQ8',
    appId: '1:637455013229:ios:db2b36219fbaf4b6d63664',
    messagingSenderId: '637455013229',
    projectId: 'swap-me-f4272',
    storageBucket: 'swap-me-f4272.appspot.com',
    iosClientId: '637455013229-65o82u92l6ufsn5frbrg12ehp4k7eu5t.apps.googleusercontent.com',
    iosBundleId: 'com.example.swapMe',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBFdubcVQZ0ufa6z0oUG7OTEmAVZKFPwQ8',
    appId: '1:637455013229:ios:db2b36219fbaf4b6d63664',
    messagingSenderId: '637455013229',
    projectId: 'swap-me-f4272',
    storageBucket: 'swap-me-f4272.appspot.com',
    iosClientId: '637455013229-65o82u92l6ufsn5frbrg12ehp4k7eu5t.apps.googleusercontent.com',
    iosBundleId: 'com.example.swapMe',
  );
}
