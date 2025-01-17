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
    apiKey: 'AIzaSyCAMSWbDh2BRPcSZAVlmpWm65Xuqa4-2js',
    appId: '1:742543666088:web:3a0b9298713e1e62e18b9d',
    messagingSenderId: '742543666088',
    projectId: 'flutter-chat-app-46bdc',
    authDomain: 'flutter-chat-app-46bdc.firebaseapp.com',
    storageBucket: 'flutter-chat-app-46bdc.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCbBOjXRnWV9ZicD0J-VZMIOMdqDPA4aLw',
    appId: '1:742543666088:android:d643b7ff959c6d41e18b9d',
    messagingSenderId: '742543666088',
    projectId: 'flutter-chat-app-46bdc',
    storageBucket: 'flutter-chat-app-46bdc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBdT0PipiVjv6FiazeYmbnHumRvO3pWXEQ',
    appId: '1:742543666088:ios:ecf355561e3e2267e18b9d',
    messagingSenderId: '742543666088',
    projectId: 'flutter-chat-app-46bdc',
    storageBucket: 'flutter-chat-app-46bdc.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBdT0PipiVjv6FiazeYmbnHumRvO3pWXEQ',
    appId: '1:742543666088:ios:ecf355561e3e2267e18b9d',
    messagingSenderId: '742543666088',
    projectId: 'flutter-chat-app-46bdc',
    storageBucket: 'flutter-chat-app-46bdc.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCAMSWbDh2BRPcSZAVlmpWm65Xuqa4-2js',
    appId: '1:742543666088:web:8327ad54d5cbb0e9e18b9d',
    messagingSenderId: '742543666088',
    projectId: 'flutter-chat-app-46bdc',
    authDomain: 'flutter-chat-app-46bdc.firebaseapp.com',
    storageBucket: 'flutter-chat-app-46bdc.appspot.com',
  );

}