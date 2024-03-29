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
    apiKey: 'AIzaSyCy5XWcKNBH-ITYp8iOAtZPSOIbHMqRI-8',
    appId: '1:174727970445:web:5738cc5ff5259540c6ecc4',
    messagingSenderId: '174727970445',
    projectId: 'cmsc190-lifeguard',
    authDomain: 'cmsc190-lifeguard.firebaseapp.com',
    storageBucket: 'cmsc190-lifeguard.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBVzTXbqWFXKeMLndMaqkK_D_haH43x5E8',
    appId: '1:174727970445:android:a21badd702ebe14cc6ecc4',
    messagingSenderId: '174727970445',
    projectId: 'cmsc190-lifeguard',
    storageBucket: 'cmsc190-lifeguard.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCGVkA875mKTpsAF6skaJfyTSKYiIaelw8',
    appId: '1:174727970445:ios:cb0f3ae4bf55cc21c6ecc4',
    messagingSenderId: '174727970445',
    projectId: 'cmsc190-lifeguard',
    storageBucket: 'cmsc190-lifeguard.appspot.com',
    iosClientId: '174727970445-pgfv4fin7g21c0panh5hgffbr1lj91vt.apps.googleusercontent.com',
    iosBundleId: 'com.example.alphaLifeguard',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCGVkA875mKTpsAF6skaJfyTSKYiIaelw8',
    appId: '1:174727970445:ios:cb0f3ae4bf55cc21c6ecc4',
    messagingSenderId: '174727970445',
    projectId: 'cmsc190-lifeguard',
    storageBucket: 'cmsc190-lifeguard.appspot.com',
    iosClientId: '174727970445-pgfv4fin7g21c0panh5hgffbr1lj91vt.apps.googleusercontent.com',
    iosBundleId: 'com.example.alphaLifeguard',
  );
}
