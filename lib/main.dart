import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lms/reg.dart';

import 'homepage.dart';
import 'lecture_schedules_page.dart';
import 'login.dart';
import 'marks_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
