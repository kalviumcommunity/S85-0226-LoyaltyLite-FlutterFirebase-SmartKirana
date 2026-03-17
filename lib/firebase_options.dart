import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not configured for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDemoKeyForTestingOnly-ReplaceWithRealKey',
    appId: '1:123456789:android:abcdef123456',
    messagingSenderId: '123456789',
    projectId: 'smart-kirana-demo',
    storageBucket: 'smart-kirana-demo.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDemoKeyForTestingOnly-ReplaceWithRealKey',
    appId: '1:123456789:ios:abcdef123456',
    messagingSenderId: '123456789',
    projectId: 'smart-kirana-demo',
    storageBucket: 'smart-kirana-demo.appspot.com',
    iosBundleId: 'com.example.smartkirana',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDemoKeyForTestingOnly-ReplaceWithRealKey',
    appId: '1:123456789:web:abcdef123456',
    messagingSenderId: '123456789',
    projectId: 'smart-kirana-demo',
    storageBucket: 'smart-kirana-demo.appspot.com',
    authDomain: 'smart-kirana-demo.firebaseapp.com',
  );
}
