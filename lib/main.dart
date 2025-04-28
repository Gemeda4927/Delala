import 'package:delala/app.dart';
import 'package:delala/injector.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// // Web-specific Firebase initialization
// const firebaseConfig = {
//   "apiKey": "AIzaSyAhtQgartlm-Dn5SPrUQcaKeTAv2L19hTI",
//   "authDomain": "delala-71e07.firebaseapp.com",
//   "projectId": "delala-71e07",
//   "storageBucket": "delala-71e07.firebasestorage.app",
//   "messagingSenderId": "702173882756",
//   "appId": "1:702173882756:web:21d40fc92f4a6afbedd5d1",
// };

Future<void> main() async {
  // Initialize the dependency injector
  await initInjector();

  // // Ensure Firebase is initialized
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: FirebaseOptions(
  //     apiKey: firebaseConfig["apiKey"]!,
  //     authDomain: firebaseConfig["authDomain"]!,
  //     projectId: firebaseConfig["projectId"]!,
  //     storageBucket: firebaseConfig["storageBucket"]!,
  //     messagingSenderId: firebaseConfig["messagingSenderId"]!,
  //     appId: firebaseConfig["appId"]!,
  //   ),
  // );

  // Run the app
  runApp(const App());
}
