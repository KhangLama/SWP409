import 'package:flutter/material.dart';
import 'package:swp409/Services/Authentication/splash/splash_screen.dart';
import 'package:swp409/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
