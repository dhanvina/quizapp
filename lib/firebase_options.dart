// lib/firebase_options.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return const FirebaseOptions(
          apiKey: "AIzaSyAYtGzwaLvmKZVLo10Rwx3b2T29XWlakCM",
          authDomain: "quizapp-36d3b.firebaseapp.com",
          projectId: "quizapp-36d3b",
          storageBucket: "quizapp-36d3b.appspot.com",
          messagingSenderId: "21854926649",
          appId: "1:21854926649:web:a6b848a2429c2222d5dae8",
          measurementId: "G-DN6M7QM3LE");
    } else {
      throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.');
    }
  }
}
