import 'package:flutter/material.dart';
import 'package:swp409/Services/Authentication/splash/splash_screen.dart';
import 'package:swp409/theme.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
