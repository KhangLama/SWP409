import 'package:flutter/material.dart';
import 'package:swp409/Interface/Home/mainScreen.dart';
import 'package:swp409/Services/Authentication/SignIn.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.greenAccent,
        appBar: AppBar(
          leading: BackButton(onPressed: () => runApp(MainScreen()),),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8),

          ),
        ),
      ),
    );
  }
}
