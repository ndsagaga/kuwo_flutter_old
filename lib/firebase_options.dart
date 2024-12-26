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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCsmAW4R_1X5G422-fcn5pEQA-iv7T0zJQ',
    appId: '1:848238783692:web:c36367b6de1ade1466a669',
    messagingSenderId: '848238783692',
    projectId: 'kuwo-769be',
    authDomain: 'kuwo-769be.firebaseapp.com',
    storageBucket: 'kuwo-769be.appspot.com',
    measurementId: 'G-GR3DLEDR3K',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDjMZhQ5mXwx7dXI87FKklNatwQR2GvDqk',
    appId: '1:848238783692:android:1fc53adbcc87b35066a669',
    messagingSenderId: '848238783692',
    projectId: 'kuwo-769be',
    storageBucket: 'kuwo-769be.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAYGcT8PGOk53y1EuOmVGTQ-4vfYmlZL1A',
    appId: '1:848238783692:ios:ef6a47d133f6385766a669',
    messagingSenderId: '848238783692',
    projectId: 'kuwo-769be',
    storageBucket: 'kuwo-769be.appspot.com',
    iosBundleId: 'com.nirup.kuwo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAYGcT8PGOk53y1EuOmVGTQ-4vfYmlZL1A',
    appId: '1:848238783692:ios:7cc10834dba3d0fc66a669',
    messagingSenderId: '848238783692',
    projectId: 'kuwo-769be',
    storageBucket: 'kuwo-769be.appspot.com',
    iosBundleId: 'com.example.kuwo',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCsmAW4R_1X5G422-fcn5pEQA-iv7T0zJQ',
    appId: '1:848238783692:web:43b9837980e2d39866a669',
    messagingSenderId: '848238783692',
    projectId: 'kuwo-769be',
    authDomain: 'kuwo-769be.firebaseapp.com',
    storageBucket: 'kuwo-769be.appspot.com',
    measurementId: 'G-GZPC7Z9LZD',
  );

}