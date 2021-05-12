import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:swp409/Services/AuthService/auth_service.dart';
import 'package:swp409/Services/Authentication/splash/splash_screen.dart';
import 'package:swp409/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    AuthService()
      .login('', 'lamminhkhang123a@gmail.com', 'King0fGod.', "King0fGod.")
      .then((val) {
    if (val.data['success']) {
      Fluttertoast.showToast(
        msg: 'Authenticated',
        
      );
    }
  });
  }
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
