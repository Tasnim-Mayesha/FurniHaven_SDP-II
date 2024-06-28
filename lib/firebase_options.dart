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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDUIT4mgRw1Acw7xHhavuWjpC3HEShxXJQ',
    appId: '1:893072319984:android:ce09fd8a9af593b49ce935',
    messagingSenderId: '893072319984',
    projectId: 'sdp2-bf09c',
    storageBucket: 'sdp2-bf09c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCverPsgHQIP7fjcatLvvGyPgSFmavzSQ8',
    appId: '1:893072319984:ios:1d0ecb32f83826679ce935',
    messagingSenderId: '893072319984',
    projectId: 'sdp2-bf09c',
    storageBucket: 'sdp2-bf09c.appspot.com',
    androidClientId: '893072319984-0mv09u5ifrotauusqsultr9ko5rl6qvf.apps.googleusercontent.com',
    iosClientId: '893072319984-1q5oglvh2ktu1nreu2gvieppoadqo6fe.apps.googleusercontent.com',
    iosBundleId: 'com.example.sdp2',
  );

}