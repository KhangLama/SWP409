import 'package:flutter/material.dart';
import 'package:swp409/loginPage.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
        ),
        body: Container(
          child: FlatButton(
            onPressed: () => {
              runApp(LoginPage())
            },
            child: Text('Back'),
          ),
        ),
      ),
    );
  }
}