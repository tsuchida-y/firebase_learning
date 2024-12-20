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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyCWb9RQPzvgA0ujjxt8BzSJnbdOJ_lJ12g',
    appId: '1:182898265279:android:931a7b374d5bf772eb4a0a',
    messagingSenderId: '182898265279',
    projectId: 'fir-learning-b12f3',
    storageBucket: 'fir-learning-b12f3.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBpqFuTBHtVaTYa-_Y7VMPECpQXqjAJhgQ',
    appId: '1:182898265279:ios:0555912e214fa606eb4a0a',
    messagingSenderId: '182898265279',
    projectId: 'fir-learning-b12f3',
    storageBucket: 'fir-learning-b12f3.firebasestorage.app',
    iosBundleId: 'com.example.firebaseLearning',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDHc1OzN3z0JQQjjT9_t4GmvhaVDz7-mh8',
    appId: '1:141865235618:web:a9099b09ad82da188513fb',
    messagingSenderId: '141865235618',
    projectId: 'fir-learning-40d20',
    authDomain: 'fir-learning-40d20.firebaseapp.com',
    storageBucket: 'fir-learning-40d20.firebasestorage.app',
    measurementId: 'G-XVCPSNZ5VV',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD3CrifZ102fVdgb2K7tZi3pgq2h7Yrs8k',
    appId: '1:141865235618:ios:a3132b1f779d9be68513fb',
    messagingSenderId: '141865235618',
    projectId: 'fir-learning-40d20',
    storageBucket: 'fir-learning-40d20.firebasestorage.app',
    iosBundleId: 'com.example.firebaseLearning',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDHc1OzN3z0JQQjjT9_t4GmvhaVDz7-mh8',
    appId: '1:141865235618:web:f3ac2942283acc438513fb',
    messagingSenderId: '141865235618',
    projectId: 'fir-learning-40d20',
    authDomain: 'fir-learning-40d20.firebaseapp.com',
    storageBucket: 'fir-learning-40d20.firebasestorage.app',
    measurementId: 'G-D8KJDSJQQD',
  );

}