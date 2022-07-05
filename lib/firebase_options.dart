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
    apiKey: 'AIzaSyDi0nfg8Vl2uZyVmENwI2SfHUsaeuG-dmQ',
    appId: '1:1006388724031:web:6caed0dc347b8f12c9538a',
    messagingSenderId: '1006388724031',
    projectId: 'vacoro-2022',
    authDomain: 'vacoro-2022.firebaseapp.com',
    storageBucket: 'vacoro-2022.appspot.com',
    measurementId: 'G-KMY8C9EP3W',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB9M52L7wymkGH4khd-h5-tHtq8dVHsDxQ',
    appId: '1:1006388724031:android:6e5c38c2ad5f7f02c9538a',
    messagingSenderId: '1006388724031',
    projectId: 'vacoro-2022',
    storageBucket: 'vacoro-2022.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAsBwatrYv5BHG33OZ7bSh9BrjP1NvEATk',
    appId: '1:1006388724031:ios:032766e924e4f95ac9538a',
    messagingSenderId: '1006388724031',
    projectId: 'vacoro-2022',
    storageBucket: 'vacoro-2022.appspot.com',
    iosClientId: '1006388724031-h7ak371r9i30pc4qdmbavumt3nmcs2pv.apps.googleusercontent.com',
    iosBundleId: 'com.example.vacoroProyect',
  );

  
}
