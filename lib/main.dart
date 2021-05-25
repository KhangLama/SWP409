import 'package:flutter/material.dart';
import 'package:swp409/Interface/Home/mainScreen.dart';
import 'package:swp409/Services/Authentication/splash/splash_screen.dart';
import 'package:swp409/theme.dart';

import 'Clinic/Interface/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clinic booking',
      theme: theme(),
      home: SplashScreen(),
    );
  }
}
