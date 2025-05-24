import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lms/reg.dart';

import 'homepage.dart';
import 'lecture_schedules_page.dart';
import 'login.dart';
import 'marks_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAMQoK1g7YQ3tiD2xbWXOqPX1_4XHuaY58",
        authDomain: "lms-app-97e1f.firebaseapp.com",
        projectId: "lms-app-97e1f",
        storageBucket: "lms-app-97e1f.appspot.com",
        messagingSenderId: "1003153251570",
        appId: "1:1003153251570:web:1b1d0e93c1ec798641846b",
        measurementId: "G-K1M35H6HV1",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.light,
      ),
      home: LoginPage(),
    );
  }
}
